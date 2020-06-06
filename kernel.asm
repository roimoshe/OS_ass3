
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 00 e6 10 80       	mov    $0x8010e600,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 32 10 80       	mov    $0x80103280,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 34 e6 10 80       	mov    $0x8010e634,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 7d 10 80       	push   $0x80107d00
80100051:	68 00 e6 10 80       	push   $0x8010e600
80100056:	e8 05 48 00 00       	call   80104860 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 4c 2d 11 80 fc 	movl   $0x80112cfc,0x80112d4c
80100062:	2c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 50 2d 11 80 fc 	movl   $0x80112cfc,0x80112d50
8010006c:	2c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba fc 2c 11 80       	mov    $0x80112cfc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 fc 2c 11 80 	movl   $0x80112cfc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 7d 10 80       	push   $0x80107d07
80100097:	50                   	push   %eax
80100098:	e8 93 46 00 00       	call   80104730 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 50 2d 11 80       	mov    0x80112d50,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 50 2d 11 80    	mov    %ebx,0x80112d50
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d fc 2c 11 80       	cmp    $0x80112cfc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 00 e6 10 80       	push   $0x8010e600
801000e4:	e8 b7 48 00 00       	call   801049a0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 50 2d 11 80    	mov    0x80112d50,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb fc 2c 11 80    	cmp    $0x80112cfc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb fc 2c 11 80    	cmp    $0x80112cfc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 4c 2d 11 80    	mov    0x80112d4c,%ebx
80100126:	81 fb fc 2c 11 80    	cmp    $0x80112cfc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb fc 2c 11 80    	cmp    $0x80112cfc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 00 e6 10 80       	push   $0x8010e600
80100162:	e8 f9 48 00 00       	call   80104a60 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 45 00 00       	call   80104770 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 6d 23 00 00       	call   801024f0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 0e 7d 10 80       	push   $0x80107d0e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 46 00 00       	call   80104810 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 27 23 00 00       	jmp    801024f0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 7d 10 80       	push   $0x80107d1f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 46 00 00       	call   80104810 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 45 00 00       	call   801047d0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 00 e6 10 80 	movl   $0x8010e600,(%esp)
8010020b:	e8 90 47 00 00       	call   801049a0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 50 2d 11 80       	mov    0x80112d50,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 fc 2c 11 80 	movl   $0x80112cfc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 50 2d 11 80       	mov    0x80112d50,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 50 2d 11 80    	mov    %ebx,0x80112d50
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 00 e6 10 80 	movl   $0x8010e600,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 ff 47 00 00       	jmp    80104a60 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 7d 10 80       	push   $0x80107d26
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 1b 15 00 00       	call   801017a0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 0f 47 00 00       	call   801049a0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 e0 2f 11 80    	mov    0x80112fe0,%edx
801002a7:	39 15 e4 2f 11 80    	cmp    %edx,0x80112fe4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 b5 10 80       	push   $0x8010b520
801002c0:	68 e0 2f 11 80       	push   $0x80112fe0
801002c5:	e8 06 40 00 00       	call   801042d0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 e0 2f 11 80    	mov    0x80112fe0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 e4 2f 11 80    	cmp    0x80112fe4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 60 39 00 00       	call   80103c40 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 6c 47 00 00       	call   80104a60 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 c4 13 00 00       	call   801016c0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 e0 2f 11 80       	mov    %eax,0x80112fe0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 60 2f 11 80 	movsbl -0x7feed0a0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 b5 10 80       	push   $0x8010b520
8010034d:	e8 0e 47 00 00       	call   80104a60 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 66 13 00 00       	call   801016c0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 e0 2f 11 80    	mov    %edx,0x80112fe0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 62 27 00 00       	call   80102b10 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 2d 7d 10 80       	push   $0x80107d2d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 23 87 10 80 	movl   $0x80108723,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 a3 44 00 00       	call   80104880 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 41 7d 10 80       	push   $0x80107d41
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 21 5d 00 00       	call   80106160 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 6f 5c 00 00       	call   80106160 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 63 5c 00 00       	call   80106160 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 57 5c 00 00       	call   80106160 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 37 46 00 00       	call   80104b60 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 6a 45 00 00       	call   80104ab0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 45 7d 10 80       	push   $0x80107d45
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 70 7d 10 80 	movzbl -0x7fef8290(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 8c 11 00 00       	call   801017a0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 80 43 00 00       	call   801049a0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 14 44 00 00       	call   80104a60 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 6b 10 00 00       	call   801016c0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 b5 10 80       	push   $0x8010b520
8010071f:	e8 3c 43 00 00       	call   80104a60 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 58 7d 10 80       	mov    $0x80107d58,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 ab 41 00 00       	call   801049a0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 5f 7d 10 80       	push   $0x80107d5f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 b5 10 80       	push   $0x8010b520
80100823:	e8 78 41 00 00       	call   801049a0 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 e8 2f 11 80       	mov    0x80112fe8,%eax
80100856:	3b 05 e4 2f 11 80    	cmp    0x80112fe4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 e8 2f 11 80       	mov    %eax,0x80112fe8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 b5 10 80       	push   $0x8010b520
80100888:	e8 d3 41 00 00       	call   80104a60 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 e8 2f 11 80       	mov    0x80112fe8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 e0 2f 11 80    	sub    0x80112fe0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 e8 2f 11 80    	mov    %edx,0x80112fe8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 60 2f 11 80    	mov    %cl,-0x7feed0a0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 e0 2f 11 80       	mov    0x80112fe0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 e8 2f 11 80    	cmp    %eax,0x80112fe8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 e4 2f 11 80       	mov    %eax,0x80112fe4
          wakeup(&input.r);
80100911:	68 e0 2f 11 80       	push   $0x80112fe0
80100916:	e8 75 3b 00 00       	call   80104490 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 e8 2f 11 80       	mov    0x80112fe8,%eax
8010093d:	39 05 e4 2f 11 80    	cmp    %eax,0x80112fe4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 e8 2f 11 80       	mov    %eax,0x80112fe8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 e8 2f 11 80       	mov    0x80112fe8,%eax
80100964:	3b 05 e4 2f 11 80    	cmp    0x80112fe4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 60 2f 11 80 0a 	cmpb   $0xa,-0x7feed0a0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 74 3c 00 00       	jmp    80104610 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 60 2f 11 80 0a 	movb   $0xa,-0x7feed0a0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 e8 2f 11 80       	mov    0x80112fe8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 68 7d 10 80       	push   $0x80107d68
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 8b 3e 00 00       	call   80104860 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 ac 39 11 80 00 	movl   $0x80100600,0x801139ac
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 a8 39 11 80 70 	movl   $0x80100270,0x801139a8
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 a2 1c 00 00       	call   801026a0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 1f 32 00 00       	call   80103c40 <myproc>
80100a21:	89 c6                	mov    %eax,%esi
80100a23:	8d 80 80 00 00 00    	lea    0x80(%eax),%eax
80100a29:	8d 96 80 01 00 00    	lea    0x180(%esi),%edx
80100a2f:	90                   	nop
  
  for(int i = 0; i< 16; i++){
    curproc->swap_file_pages[i].state_used = 0;
80100a30:	c6 80 00 01 00 00 00 	movb   $0x0,0x100(%eax)
    curproc->main_mem_pages[i].state_used = 0;
80100a37:	c6 00 00             	movb   $0x0,(%eax)
80100a3a:	83 c0 10             	add    $0x10,%eax
  for(int i = 0; i< 16; i++){
80100a3d:	39 d0                	cmp    %edx,%eax
80100a3f:	75 ef                	jne    80100a30 <exec+0x20>
  }

  begin_op();
80100a41:	e8 3a 25 00 00       	call   80102f80 <begin_op>

  if((ip = namei(path)) == 0){
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	ff 75 08             	pushl  0x8(%ebp)
80100a4c:	e8 cf 14 00 00       	call   80101f20 <namei>
80100a51:	83 c4 10             	add    $0x10,%esp
80100a54:	85 c0                	test   %eax,%eax
80100a56:	89 c3                	mov    %eax,%ebx
80100a58:	0f 84 ae 01 00 00    	je     80100c0c <exec+0x1fc>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a5e:	83 ec 0c             	sub    $0xc,%esp
80100a61:	50                   	push   %eax
80100a62:	e8 59 0c 00 00       	call   801016c0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a67:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a6d:	6a 34                	push   $0x34
80100a6f:	6a 00                	push   $0x0
80100a71:	50                   	push   %eax
80100a72:	53                   	push   %ebx
80100a73:	e8 28 0f 00 00       	call   801019a0 <readi>
80100a78:	83 c4 20             	add    $0x20,%esp
80100a7b:	83 f8 34             	cmp    $0x34,%eax
80100a7e:	74 20                	je     80100aa0 <exec+0x90>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a80:	83 ec 0c             	sub    $0xc,%esp
80100a83:	53                   	push   %ebx
80100a84:	e8 c7 0e 00 00       	call   80101950 <iunlockput>
    end_op();
80100a89:	e8 62 25 00 00       	call   80102ff0 <end_op>
80100a8e:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a99:	5b                   	pop    %ebx
80100a9a:	5e                   	pop    %esi
80100a9b:	5f                   	pop    %edi
80100a9c:	5d                   	pop    %ebp
80100a9d:	c3                   	ret    
80100a9e:	66 90                	xchg   %ax,%ax
  if(elf.magic != ELF_MAGIC)
80100aa0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aa7:	45 4c 46 
80100aaa:	75 d4                	jne    80100a80 <exec+0x70>
  if((pgdir = setupkvm()) == 0)
80100aac:	e8 0f 6f 00 00       	call   801079c0 <setupkvm>
80100ab1:	85 c0                	test   %eax,%eax
80100ab3:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100ab9:	74 c5                	je     80100a80 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100abb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ac2:	00 
80100ac3:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ac9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100acf:	0f 84 a9 02 00 00    	je     80100d7e <exec+0x36e>
  sz = 0;
80100ad5:	31 c0                	xor    %eax,%eax
80100ad7:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100add:	31 ff                	xor    %edi,%edi
80100adf:	89 c6                	mov    %eax,%esi
80100ae1:	eb 7f                	jmp    80100b62 <exec+0x152>
80100ae3:	90                   	nop
80100ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ae8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100aef:	75 63                	jne    80100b54 <exec+0x144>
    if(ph.memsz < ph.filesz)
80100af1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100af7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100afd:	0f 82 86 00 00 00    	jb     80100b89 <exec+0x179>
80100b03:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b09:	72 7e                	jb     80100b89 <exec+0x179>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b0b:	83 ec 04             	sub    $0x4,%esp
80100b0e:	50                   	push   %eax
80100b0f:	56                   	push   %esi
80100b10:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b16:	e8 15 6a 00 00       	call   80107530 <allocuvm>
80100b1b:	83 c4 10             	add    $0x10,%esp
80100b1e:	85 c0                	test   %eax,%eax
80100b20:	89 c6                	mov    %eax,%esi
80100b22:	74 65                	je     80100b89 <exec+0x179>
    if(ph.vaddr % PGSIZE != 0)
80100b24:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b2a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b2f:	75 58                	jne    80100b89 <exec+0x179>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b31:	83 ec 0c             	sub    $0xc,%esp
80100b34:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b3a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b40:	53                   	push   %ebx
80100b41:	50                   	push   %eax
80100b42:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b48:	e8 43 65 00 00       	call   80107090 <loaduvm>
80100b4d:	83 c4 20             	add    $0x20,%esp
80100b50:	85 c0                	test   %eax,%eax
80100b52:	78 35                	js     80100b89 <exec+0x179>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b54:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b5b:	83 c7 01             	add    $0x1,%edi
80100b5e:	39 f8                	cmp    %edi,%eax
80100b60:	7e 3d                	jle    80100b9f <exec+0x18f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b62:	89 f8                	mov    %edi,%eax
80100b64:	6a 20                	push   $0x20
80100b66:	c1 e0 05             	shl    $0x5,%eax
80100b69:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100b6f:	50                   	push   %eax
80100b70:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b76:	50                   	push   %eax
80100b77:	53                   	push   %ebx
80100b78:	e8 23 0e 00 00       	call   801019a0 <readi>
80100b7d:	83 c4 10             	add    $0x10,%esp
80100b80:	83 f8 20             	cmp    $0x20,%eax
80100b83:	0f 84 5f ff ff ff    	je     80100ae8 <exec+0xd8>
    freevm(pgdir);
80100b89:	83 ec 0c             	sub    $0xc,%esp
80100b8c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b92:	e8 a9 6d 00 00       	call   80107940 <freevm>
80100b97:	83 c4 10             	add    $0x10,%esp
80100b9a:	e9 e1 fe ff ff       	jmp    80100a80 <exec+0x70>
80100b9f:	89 f0                	mov    %esi,%eax
80100ba1:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100ba7:	05 ff 0f 00 00       	add    $0xfff,%eax
80100bac:	89 c7                	mov    %eax,%edi
80100bae:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100bb4:	8d 87 00 20 00 00    	lea    0x2000(%edi),%eax
  iunlockput(ip);
80100bba:	83 ec 0c             	sub    $0xc,%esp
80100bbd:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bc3:	53                   	push   %ebx
80100bc4:	e8 87 0d 00 00       	call   80101950 <iunlockput>
  end_op();
80100bc9:	e8 22 24 00 00       	call   80102ff0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100bce:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bd4:	83 c4 0c             	add    $0xc,%esp
80100bd7:	50                   	push   %eax
80100bd8:	57                   	push   %edi
80100bd9:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bdf:	e8 4c 69 00 00       	call   80107530 <allocuvm>
80100be4:	83 c4 10             	add    $0x10,%esp
80100be7:	85 c0                	test   %eax,%eax
80100be9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bef:	75 3a                	jne    80100c2b <exec+0x21b>
    freevm(pgdir);
80100bf1:	83 ec 0c             	sub    $0xc,%esp
80100bf4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bfa:	e8 41 6d 00 00       	call   80107940 <freevm>
80100bff:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c07:	e9 8a fe ff ff       	jmp    80100a96 <exec+0x86>
    end_op();
80100c0c:	e8 df 23 00 00       	call   80102ff0 <end_op>
    cprintf("exec: fail\n");
80100c11:	83 ec 0c             	sub    $0xc,%esp
80100c14:	68 81 7d 10 80       	push   $0x80107d81
80100c19:	e8 42 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100c1e:	83 c4 10             	add    $0x10,%esp
80100c21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c26:	e9 6b fe ff ff       	jmp    80100a96 <exec+0x86>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c2b:	89 c7                	mov    %eax,%edi
80100c2d:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100c33:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100c36:	31 db                	xor    %ebx,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c38:	50                   	push   %eax
80100c39:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c3f:	e8 1c 6e 00 00       	call   80107a60 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c44:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c47:	83 c4 10             	add    $0x10,%esp
80100c4a:	8b 00                	mov    (%eax),%eax
80100c4c:	85 c0                	test   %eax,%eax
80100c4e:	75 0d                	jne    80100c5d <exec+0x24d>
80100c50:	e9 35 01 00 00       	jmp    80100d8a <exec+0x37a>
80100c55:	8d 76 00             	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100c58:	83 fb 20             	cmp    $0x20,%ebx
80100c5b:	74 94                	je     80100bf1 <exec+0x1e1>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c5d:	83 ec 0c             	sub    $0xc,%esp
80100c60:	50                   	push   %eax
80100c61:	e8 6a 40 00 00       	call   80104cd0 <strlen>
80100c66:	f7 d0                	not    %eax
80100c68:	01 f8                	add    %edi,%eax
80100c6a:	83 e0 fc             	and    $0xfffffffc,%eax
80100c6d:	89 c7                	mov    %eax,%edi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c6f:	58                   	pop    %eax
80100c70:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c73:	ff 34 98             	pushl  (%eax,%ebx,4)
80100c76:	e8 55 40 00 00       	call   80104cd0 <strlen>
80100c7b:	83 c0 01             	add    $0x1,%eax
80100c7e:	50                   	push   %eax
80100c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c82:	ff 34 98             	pushl  (%eax,%ebx,4)
80100c85:	57                   	push   %edi
80100c86:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c8c:	e8 2f 6f 00 00       	call   80107bc0 <copyout>
80100c91:	83 c4 20             	add    $0x20,%esp
80100c94:	85 c0                	test   %eax,%eax
80100c96:	0f 88 55 ff ff ff    	js     80100bf1 <exec+0x1e1>
  for(argc = 0; argv[argc]; argc++) {
80100c9c:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c9f:	89 bc 9d 64 ff ff ff 	mov    %edi,-0x9c(%ebp,%ebx,4)
  for(argc = 0; argv[argc]; argc++) {
80100ca6:	83 c3 01             	add    $0x1,%ebx
    ustack[3+argc] = sp;
80100ca9:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100caf:	8b 04 98             	mov    (%eax,%ebx,4),%eax
80100cb2:	85 c0                	test   %eax,%eax
80100cb4:	75 a2                	jne    80100c58 <exec+0x248>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb6:	8d 04 9d 04 00 00 00 	lea    0x4(,%ebx,4),%eax
80100cbd:	89 fa                	mov    %edi,%edx
  ustack[3+argc] = 0;
80100cbf:	c7 84 9d 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%ebx,4)
80100cc6:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100cca:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cd1:	ff ff ff 
  ustack[1] = argc;
80100cd4:	89 9d 5c ff ff ff    	mov    %ebx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cda:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100cdc:	83 c0 0c             	add    $0xc,%eax
80100cdf:	29 c7                	sub    %eax,%edi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ce1:	50                   	push   %eax
80100ce2:	51                   	push   %ecx
80100ce3:	57                   	push   %edi
80100ce4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cea:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cf0:	e8 cb 6e 00 00       	call   80107bc0 <copyout>
80100cf5:	83 c4 10             	add    $0x10,%esp
80100cf8:	85 c0                	test   %eax,%eax
80100cfa:	0f 88 f1 fe ff ff    	js     80100bf1 <exec+0x1e1>
  for(last=s=path; *s; s++)
80100d00:	8b 45 08             	mov    0x8(%ebp),%eax
80100d03:	0f b6 00             	movzbl (%eax),%eax
80100d06:	84 c0                	test   %al,%al
80100d08:	74 17                	je     80100d21 <exec+0x311>
80100d0a:	8b 55 08             	mov    0x8(%ebp),%edx
80100d0d:	89 d1                	mov    %edx,%ecx
80100d0f:	83 c1 01             	add    $0x1,%ecx
80100d12:	3c 2f                	cmp    $0x2f,%al
80100d14:	0f b6 01             	movzbl (%ecx),%eax
80100d17:	0f 44 d1             	cmove  %ecx,%edx
80100d1a:	84 c0                	test   %al,%al
80100d1c:	75 f1                	jne    80100d0f <exec+0x2ff>
80100d1e:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d21:	8d 46 6c             	lea    0x6c(%esi),%eax
80100d24:	83 ec 04             	sub    $0x4,%esp
80100d27:	6a 10                	push   $0x10
80100d29:	ff 75 08             	pushl  0x8(%ebp)
80100d2c:	50                   	push   %eax
80100d2d:	e8 5e 3f 00 00       	call   80104c90 <safestrcpy>
  oldpgdir = curproc->pgdir;
80100d32:	8b 46 04             	mov    0x4(%esi),%eax
  curproc->tf->eip = elf.entry;  // main
80100d35:	8b 56 18             	mov    0x18(%esi),%edx
  oldpgdir = curproc->pgdir;
80100d38:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  curproc->pgdir = pgdir;
80100d3e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100d44:	89 46 04             	mov    %eax,0x4(%esi)
  curproc->sz = sz;
80100d47:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d4d:	89 06                	mov    %eax,(%esi)
  curproc->tf->eip = elf.entry;  // main
80100d4f:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100d55:	89 4a 38             	mov    %ecx,0x38(%edx)
  curproc->tf->esp = sp;
80100d58:	8b 56 18             	mov    0x18(%esi),%edx
80100d5b:	89 7a 44             	mov    %edi,0x44(%edx)
  switchuvm(curproc);
80100d5e:	89 34 24             	mov    %esi,(%esp)
80100d61:	e8 9a 61 00 00       	call   80106f00 <switchuvm>
  freevm(oldpgdir);
80100d66:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100d6c:	89 04 24             	mov    %eax,(%esp)
80100d6f:	e8 cc 6b 00 00       	call   80107940 <freevm>
  return 0;
80100d74:	83 c4 10             	add    $0x10,%esp
80100d77:	31 c0                	xor    %eax,%eax
80100d79:	e9 18 fd ff ff       	jmp    80100a96 <exec+0x86>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d7e:	31 ff                	xor    %edi,%edi
80100d80:	b8 00 20 00 00       	mov    $0x2000,%eax
80100d85:	e9 30 fe ff ff       	jmp    80100bba <exec+0x1aa>
  for(argc = 0; argv[argc]; argc++) {
80100d8a:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d90:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d96:	e9 1b ff ff ff       	jmp    80100cb6 <exec+0x2a6>
80100d9b:	66 90                	xchg   %ax,%ax
80100d9d:	66 90                	xchg   %ax,%ax
80100d9f:	90                   	nop

80100da0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100da0:	55                   	push   %ebp
80100da1:	89 e5                	mov    %esp,%ebp
80100da3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100da6:	68 8d 7d 10 80       	push   $0x80107d8d
80100dab:	68 00 30 11 80       	push   $0x80113000
80100db0:	e8 ab 3a 00 00       	call   80104860 <initlock>
}
80100db5:	83 c4 10             	add    $0x10,%esp
80100db8:	c9                   	leave  
80100db9:	c3                   	ret    
80100dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100dc0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100dc4:	bb 34 30 11 80       	mov    $0x80113034,%ebx
{
80100dc9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100dcc:	68 00 30 11 80       	push   $0x80113000
80100dd1:	e8 ca 3b 00 00       	call   801049a0 <acquire>
80100dd6:	83 c4 10             	add    $0x10,%esp
80100dd9:	eb 10                	jmp    80100deb <filealloc+0x2b>
80100ddb:	90                   	nop
80100ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100de0:	83 c3 18             	add    $0x18,%ebx
80100de3:	81 fb 94 39 11 80    	cmp    $0x80113994,%ebx
80100de9:	73 25                	jae    80100e10 <filealloc+0x50>
    if(f->ref == 0){
80100deb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dee:	85 c0                	test   %eax,%eax
80100df0:	75 ee                	jne    80100de0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100df2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100df5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dfc:	68 00 30 11 80       	push   $0x80113000
80100e01:	e8 5a 3c 00 00       	call   80104a60 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e06:	89 d8                	mov    %ebx,%eax
      return f;
80100e08:	83 c4 10             	add    $0x10,%esp
}
80100e0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e0e:	c9                   	leave  
80100e0f:	c3                   	ret    
  release(&ftable.lock);
80100e10:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e13:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e15:	68 00 30 11 80       	push   $0x80113000
80100e1a:	e8 41 3c 00 00       	call   80104a60 <release>
}
80100e1f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e21:	83 c4 10             	add    $0x10,%esp
}
80100e24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e27:	c9                   	leave  
80100e28:	c3                   	ret    
80100e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e30 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
80100e34:	83 ec 10             	sub    $0x10,%esp
80100e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e3a:	68 00 30 11 80       	push   $0x80113000
80100e3f:	e8 5c 3b 00 00       	call   801049a0 <acquire>
  if(f->ref < 1)
80100e44:	8b 43 04             	mov    0x4(%ebx),%eax
80100e47:	83 c4 10             	add    $0x10,%esp
80100e4a:	85 c0                	test   %eax,%eax
80100e4c:	7e 1a                	jle    80100e68 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e4e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e51:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e54:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e57:	68 00 30 11 80       	push   $0x80113000
80100e5c:	e8 ff 3b 00 00       	call   80104a60 <release>
  return f;
}
80100e61:	89 d8                	mov    %ebx,%eax
80100e63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e66:	c9                   	leave  
80100e67:	c3                   	ret    
    panic("filedup");
80100e68:	83 ec 0c             	sub    $0xc,%esp
80100e6b:	68 94 7d 10 80       	push   $0x80107d94
80100e70:	e8 1b f5 ff ff       	call   80100390 <panic>
80100e75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e80 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	57                   	push   %edi
80100e84:	56                   	push   %esi
80100e85:	53                   	push   %ebx
80100e86:	83 ec 28             	sub    $0x28,%esp
80100e89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e8c:	68 00 30 11 80       	push   $0x80113000
80100e91:	e8 0a 3b 00 00       	call   801049a0 <acquire>
  if(f->ref < 1)
80100e96:	8b 43 04             	mov    0x4(%ebx),%eax
80100e99:	83 c4 10             	add    $0x10,%esp
80100e9c:	85 c0                	test   %eax,%eax
80100e9e:	0f 8e 9b 00 00 00    	jle    80100f3f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100ea4:	83 e8 01             	sub    $0x1,%eax
80100ea7:	85 c0                	test   %eax,%eax
80100ea9:	89 43 04             	mov    %eax,0x4(%ebx)
80100eac:	74 1a                	je     80100ec8 <fileclose+0x48>
    release(&ftable.lock);
80100eae:	c7 45 08 00 30 11 80 	movl   $0x80113000,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eb8:	5b                   	pop    %ebx
80100eb9:	5e                   	pop    %esi
80100eba:	5f                   	pop    %edi
80100ebb:	5d                   	pop    %ebp
    release(&ftable.lock);
80100ebc:	e9 9f 3b 00 00       	jmp    80104a60 <release>
80100ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100ec8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100ecc:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100ece:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ed1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ed4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eda:	88 45 e7             	mov    %al,-0x19(%ebp)
80100edd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ee0:	68 00 30 11 80       	push   $0x80113000
  ff = *f;
80100ee5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ee8:	e8 73 3b 00 00       	call   80104a60 <release>
  if(ff.type == FD_PIPE)
80100eed:	83 c4 10             	add    $0x10,%esp
80100ef0:	83 ff 01             	cmp    $0x1,%edi
80100ef3:	74 13                	je     80100f08 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100ef5:	83 ff 02             	cmp    $0x2,%edi
80100ef8:	74 26                	je     80100f20 <fileclose+0xa0>
}
80100efa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100efd:	5b                   	pop    %ebx
80100efe:	5e                   	pop    %esi
80100eff:	5f                   	pop    %edi
80100f00:	5d                   	pop    %ebp
80100f01:	c3                   	ret    
80100f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f08:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f0c:	83 ec 08             	sub    $0x8,%esp
80100f0f:	53                   	push   %ebx
80100f10:	56                   	push   %esi
80100f11:	e8 1a 28 00 00       	call   80103730 <pipeclose>
80100f16:	83 c4 10             	add    $0x10,%esp
80100f19:	eb df                	jmp    80100efa <fileclose+0x7a>
80100f1b:	90                   	nop
80100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f20:	e8 5b 20 00 00       	call   80102f80 <begin_op>
    iput(ff.ip);
80100f25:	83 ec 0c             	sub    $0xc,%esp
80100f28:	ff 75 e0             	pushl  -0x20(%ebp)
80100f2b:	e8 c0 08 00 00       	call   801017f0 <iput>
    end_op();
80100f30:	83 c4 10             	add    $0x10,%esp
}
80100f33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f36:	5b                   	pop    %ebx
80100f37:	5e                   	pop    %esi
80100f38:	5f                   	pop    %edi
80100f39:	5d                   	pop    %ebp
    end_op();
80100f3a:	e9 b1 20 00 00       	jmp    80102ff0 <end_op>
    panic("fileclose");
80100f3f:	83 ec 0c             	sub    $0xc,%esp
80100f42:	68 9c 7d 10 80       	push   $0x80107d9c
80100f47:	e8 44 f4 ff ff       	call   80100390 <panic>
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f50 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	53                   	push   %ebx
80100f54:	83 ec 04             	sub    $0x4,%esp
80100f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f5a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f5d:	75 31                	jne    80100f90 <filestat+0x40>
    ilock(f->ip);
80100f5f:	83 ec 0c             	sub    $0xc,%esp
80100f62:	ff 73 10             	pushl  0x10(%ebx)
80100f65:	e8 56 07 00 00       	call   801016c0 <ilock>
    stati(f->ip, st);
80100f6a:	58                   	pop    %eax
80100f6b:	5a                   	pop    %edx
80100f6c:	ff 75 0c             	pushl  0xc(%ebp)
80100f6f:	ff 73 10             	pushl  0x10(%ebx)
80100f72:	e8 f9 09 00 00       	call   80101970 <stati>
    iunlock(f->ip);
80100f77:	59                   	pop    %ecx
80100f78:	ff 73 10             	pushl  0x10(%ebx)
80100f7b:	e8 20 08 00 00       	call   801017a0 <iunlock>
    return 0;
80100f80:	83 c4 10             	add    $0x10,%esp
80100f83:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f88:	c9                   	leave  
80100f89:	c3                   	ret    
80100f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f95:	eb ee                	jmp    80100f85 <filestat+0x35>
80100f97:	89 f6                	mov    %esi,%esi
80100f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fa0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	57                   	push   %edi
80100fa4:	56                   	push   %esi
80100fa5:	53                   	push   %ebx
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fac:	8b 75 0c             	mov    0xc(%ebp),%esi
80100faf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100fb2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fb6:	74 60                	je     80101018 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100fb8:	8b 03                	mov    (%ebx),%eax
80100fba:	83 f8 01             	cmp    $0x1,%eax
80100fbd:	74 41                	je     80101000 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fbf:	83 f8 02             	cmp    $0x2,%eax
80100fc2:	75 5b                	jne    8010101f <fileread+0x7f>
    ilock(f->ip);
80100fc4:	83 ec 0c             	sub    $0xc,%esp
80100fc7:	ff 73 10             	pushl  0x10(%ebx)
80100fca:	e8 f1 06 00 00       	call   801016c0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fcf:	57                   	push   %edi
80100fd0:	ff 73 14             	pushl  0x14(%ebx)
80100fd3:	56                   	push   %esi
80100fd4:	ff 73 10             	pushl  0x10(%ebx)
80100fd7:	e8 c4 09 00 00       	call   801019a0 <readi>
80100fdc:	83 c4 20             	add    $0x20,%esp
80100fdf:	85 c0                	test   %eax,%eax
80100fe1:	89 c6                	mov    %eax,%esi
80100fe3:	7e 03                	jle    80100fe8 <fileread+0x48>
      f->off += r;
80100fe5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fe8:	83 ec 0c             	sub    $0xc,%esp
80100feb:	ff 73 10             	pushl  0x10(%ebx)
80100fee:	e8 ad 07 00 00       	call   801017a0 <iunlock>
    return r;
80100ff3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100ff6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ff9:	89 f0                	mov    %esi,%eax
80100ffb:	5b                   	pop    %ebx
80100ffc:	5e                   	pop    %esi
80100ffd:	5f                   	pop    %edi
80100ffe:	5d                   	pop    %ebp
80100fff:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101000:	8b 43 0c             	mov    0xc(%ebx),%eax
80101003:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101006:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101009:	5b                   	pop    %ebx
8010100a:	5e                   	pop    %esi
8010100b:	5f                   	pop    %edi
8010100c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010100d:	e9 ce 28 00 00       	jmp    801038e0 <piperead>
80101012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101018:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010101d:	eb d7                	jmp    80100ff6 <fileread+0x56>
  panic("fileread");
8010101f:	83 ec 0c             	sub    $0xc,%esp
80101022:	68 a6 7d 10 80       	push   $0x80107da6
80101027:	e8 64 f3 ff ff       	call   80100390 <panic>
8010102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101030 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 1c             	sub    $0x1c,%esp
80101039:	8b 75 08             	mov    0x8(%ebp),%esi
8010103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010103f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101043:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101046:	8b 45 10             	mov    0x10(%ebp),%eax
80101049:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010104c:	0f 84 aa 00 00 00    	je     801010fc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101052:	8b 06                	mov    (%esi),%eax
80101054:	83 f8 01             	cmp    $0x1,%eax
80101057:	0f 84 c3 00 00 00    	je     80101120 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010105d:	83 f8 02             	cmp    $0x2,%eax
80101060:	0f 85 d9 00 00 00    	jne    8010113f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101066:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101069:	31 ff                	xor    %edi,%edi
    while(i < n){
8010106b:	85 c0                	test   %eax,%eax
8010106d:	7f 34                	jg     801010a3 <filewrite+0x73>
8010106f:	e9 9c 00 00 00       	jmp    80101110 <filewrite+0xe0>
80101074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101078:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101081:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101084:	e8 17 07 00 00       	call   801017a0 <iunlock>
      end_op();
80101089:	e8 62 1f 00 00       	call   80102ff0 <end_op>
8010108e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101091:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101094:	39 c3                	cmp    %eax,%ebx
80101096:	0f 85 96 00 00 00    	jne    80101132 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010109c:	01 df                	add    %ebx,%edi
    while(i < n){
8010109e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010a1:	7e 6d                	jle    80101110 <filewrite+0xe0>
      int n1 = n - i;
801010a3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010a6:	b8 00 06 00 00       	mov    $0x600,%eax
801010ab:	29 fb                	sub    %edi,%ebx
801010ad:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010b3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801010b6:	e8 c5 1e 00 00       	call   80102f80 <begin_op>
      ilock(f->ip);
801010bb:	83 ec 0c             	sub    $0xc,%esp
801010be:	ff 76 10             	pushl  0x10(%esi)
801010c1:	e8 fa 05 00 00       	call   801016c0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010c9:	53                   	push   %ebx
801010ca:	ff 76 14             	pushl  0x14(%esi)
801010cd:	01 f8                	add    %edi,%eax
801010cf:	50                   	push   %eax
801010d0:	ff 76 10             	pushl  0x10(%esi)
801010d3:	e8 c8 09 00 00       	call   80101aa0 <writei>
801010d8:	83 c4 20             	add    $0x20,%esp
801010db:	85 c0                	test   %eax,%eax
801010dd:	7f 99                	jg     80101078 <filewrite+0x48>
      iunlock(f->ip);
801010df:	83 ec 0c             	sub    $0xc,%esp
801010e2:	ff 76 10             	pushl  0x10(%esi)
801010e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010e8:	e8 b3 06 00 00       	call   801017a0 <iunlock>
      end_op();
801010ed:	e8 fe 1e 00 00       	call   80102ff0 <end_op>
      if(r < 0)
801010f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f5:	83 c4 10             	add    $0x10,%esp
801010f8:	85 c0                	test   %eax,%eax
801010fa:	74 98                	je     80101094 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010ff:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101104:	89 f8                	mov    %edi,%eax
80101106:	5b                   	pop    %ebx
80101107:	5e                   	pop    %esi
80101108:	5f                   	pop    %edi
80101109:	5d                   	pop    %ebp
8010110a:	c3                   	ret    
8010110b:	90                   	nop
8010110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101110:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101113:	75 e7                	jne    801010fc <filewrite+0xcc>
}
80101115:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101118:	89 f8                	mov    %edi,%eax
8010111a:	5b                   	pop    %ebx
8010111b:	5e                   	pop    %esi
8010111c:	5f                   	pop    %edi
8010111d:	5d                   	pop    %ebp
8010111e:	c3                   	ret    
8010111f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101120:	8b 46 0c             	mov    0xc(%esi),%eax
80101123:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101126:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101129:	5b                   	pop    %ebx
8010112a:	5e                   	pop    %esi
8010112b:	5f                   	pop    %edi
8010112c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010112d:	e9 9e 26 00 00       	jmp    801037d0 <pipewrite>
        panic("short filewrite");
80101132:	83 ec 0c             	sub    $0xc,%esp
80101135:	68 af 7d 10 80       	push   $0x80107daf
8010113a:	e8 51 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010113f:	83 ec 0c             	sub    $0xc,%esp
80101142:	68 b5 7d 10 80       	push   $0x80107db5
80101147:	e8 44 f2 ff ff       	call   80100390 <panic>
8010114c:	66 90                	xchg   %ax,%ax
8010114e:	66 90                	xchg   %ax,%ax

80101150 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	56                   	push   %esi
80101154:	53                   	push   %ebx
80101155:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101157:	c1 ea 0c             	shr    $0xc,%edx
8010115a:	03 15 18 3a 11 80    	add    0x80113a18,%edx
80101160:	83 ec 08             	sub    $0x8,%esp
80101163:	52                   	push   %edx
80101164:	50                   	push   %eax
80101165:	e8 66 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010116a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010116c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010116f:	ba 01 00 00 00       	mov    $0x1,%edx
80101174:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101177:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010117d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101180:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101182:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101187:	85 d1                	test   %edx,%ecx
80101189:	74 25                	je     801011b0 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010118b:	f7 d2                	not    %edx
8010118d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010118f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101192:	21 ca                	and    %ecx,%edx
80101194:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101198:	56                   	push   %esi
80101199:	e8 b2 1f 00 00       	call   80103150 <log_write>
  brelse(bp);
8010119e:	89 34 24             	mov    %esi,(%esp)
801011a1:	e8 3a f0 ff ff       	call   801001e0 <brelse>
}
801011a6:	83 c4 10             	add    $0x10,%esp
801011a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801011ac:	5b                   	pop    %ebx
801011ad:	5e                   	pop    %esi
801011ae:	5d                   	pop    %ebp
801011af:	c3                   	ret    
    panic("freeing free block");
801011b0:	83 ec 0c             	sub    $0xc,%esp
801011b3:	68 bf 7d 10 80       	push   $0x80107dbf
801011b8:	e8 d3 f1 ff ff       	call   80100390 <panic>
801011bd:	8d 76 00             	lea    0x0(%esi),%esi

801011c0 <balloc>:
{
801011c0:	55                   	push   %ebp
801011c1:	89 e5                	mov    %esp,%ebp
801011c3:	57                   	push   %edi
801011c4:	56                   	push   %esi
801011c5:	53                   	push   %ebx
801011c6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801011c9:	8b 0d 00 3a 11 80    	mov    0x80113a00,%ecx
{
801011cf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801011d2:	85 c9                	test   %ecx,%ecx
801011d4:	0f 84 87 00 00 00    	je     80101261 <balloc+0xa1>
801011da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011e1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011e4:	83 ec 08             	sub    $0x8,%esp
801011e7:	89 f0                	mov    %esi,%eax
801011e9:	c1 f8 0c             	sar    $0xc,%eax
801011ec:	03 05 18 3a 11 80    	add    0x80113a18,%eax
801011f2:	50                   	push   %eax
801011f3:	ff 75 d8             	pushl  -0x28(%ebp)
801011f6:	e8 d5 ee ff ff       	call   801000d0 <bread>
801011fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011fe:	a1 00 3a 11 80       	mov    0x80113a00,%eax
80101203:	83 c4 10             	add    $0x10,%esp
80101206:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101209:	31 c0                	xor    %eax,%eax
8010120b:	eb 2f                	jmp    8010123c <balloc+0x7c>
8010120d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101210:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101212:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101215:	bb 01 00 00 00       	mov    $0x1,%ebx
8010121a:	83 e1 07             	and    $0x7,%ecx
8010121d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010121f:	89 c1                	mov    %eax,%ecx
80101221:	c1 f9 03             	sar    $0x3,%ecx
80101224:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101229:	85 df                	test   %ebx,%edi
8010122b:	89 fa                	mov    %edi,%edx
8010122d:	74 41                	je     80101270 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010122f:	83 c0 01             	add    $0x1,%eax
80101232:	83 c6 01             	add    $0x1,%esi
80101235:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010123a:	74 05                	je     80101241 <balloc+0x81>
8010123c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010123f:	77 cf                	ja     80101210 <balloc+0x50>
    brelse(bp);
80101241:	83 ec 0c             	sub    $0xc,%esp
80101244:	ff 75 e4             	pushl  -0x1c(%ebp)
80101247:	e8 94 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010124c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101253:	83 c4 10             	add    $0x10,%esp
80101256:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101259:	39 05 00 3a 11 80    	cmp    %eax,0x80113a00
8010125f:	77 80                	ja     801011e1 <balloc+0x21>
  panic("balloc: out of blocks");
80101261:	83 ec 0c             	sub    $0xc,%esp
80101264:	68 d2 7d 10 80       	push   $0x80107dd2
80101269:	e8 22 f1 ff ff       	call   80100390 <panic>
8010126e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101270:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101273:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101276:	09 da                	or     %ebx,%edx
80101278:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010127c:	57                   	push   %edi
8010127d:	e8 ce 1e 00 00       	call   80103150 <log_write>
        brelse(bp);
80101282:	89 3c 24             	mov    %edi,(%esp)
80101285:	e8 56 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010128a:	58                   	pop    %eax
8010128b:	5a                   	pop    %edx
8010128c:	56                   	push   %esi
8010128d:	ff 75 d8             	pushl  -0x28(%ebp)
80101290:	e8 3b ee ff ff       	call   801000d0 <bread>
80101295:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101297:	8d 40 5c             	lea    0x5c(%eax),%eax
8010129a:	83 c4 0c             	add    $0xc,%esp
8010129d:	68 00 02 00 00       	push   $0x200
801012a2:	6a 00                	push   $0x0
801012a4:	50                   	push   %eax
801012a5:	e8 06 38 00 00       	call   80104ab0 <memset>
  log_write(bp);
801012aa:	89 1c 24             	mov    %ebx,(%esp)
801012ad:	e8 9e 1e 00 00       	call   80103150 <log_write>
  brelse(bp);
801012b2:	89 1c 24             	mov    %ebx,(%esp)
801012b5:	e8 26 ef ff ff       	call   801001e0 <brelse>
}
801012ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012bd:	89 f0                	mov    %esi,%eax
801012bf:	5b                   	pop    %ebx
801012c0:	5e                   	pop    %esi
801012c1:	5f                   	pop    %edi
801012c2:	5d                   	pop    %ebp
801012c3:	c3                   	ret    
801012c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801012d0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	57                   	push   %edi
801012d4:	56                   	push   %esi
801012d5:	53                   	push   %ebx
801012d6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012d8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012da:	bb 54 3a 11 80       	mov    $0x80113a54,%ebx
{
801012df:	83 ec 28             	sub    $0x28,%esp
801012e2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012e5:	68 20 3a 11 80       	push   $0x80113a20
801012ea:	e8 b1 36 00 00       	call   801049a0 <acquire>
801012ef:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012f2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012f5:	eb 17                	jmp    8010130e <iget+0x3e>
801012f7:	89 f6                	mov    %esi,%esi
801012f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101300:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101306:	81 fb 74 56 11 80    	cmp    $0x80115674,%ebx
8010130c:	73 22                	jae    80101330 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010130e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101311:	85 c9                	test   %ecx,%ecx
80101313:	7e 04                	jle    80101319 <iget+0x49>
80101315:	39 3b                	cmp    %edi,(%ebx)
80101317:	74 4f                	je     80101368 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101319:	85 f6                	test   %esi,%esi
8010131b:	75 e3                	jne    80101300 <iget+0x30>
8010131d:	85 c9                	test   %ecx,%ecx
8010131f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101322:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101328:	81 fb 74 56 11 80    	cmp    $0x80115674,%ebx
8010132e:	72 de                	jb     8010130e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101330:	85 f6                	test   %esi,%esi
80101332:	74 5b                	je     8010138f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101334:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101337:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101339:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010133c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101343:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010134a:	68 20 3a 11 80       	push   $0x80113a20
8010134f:	e8 0c 37 00 00       	call   80104a60 <release>

  return ip;
80101354:	83 c4 10             	add    $0x10,%esp
}
80101357:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010135a:	89 f0                	mov    %esi,%eax
8010135c:	5b                   	pop    %ebx
8010135d:	5e                   	pop    %esi
8010135e:	5f                   	pop    %edi
8010135f:	5d                   	pop    %ebp
80101360:	c3                   	ret    
80101361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101368:	39 53 04             	cmp    %edx,0x4(%ebx)
8010136b:	75 ac                	jne    80101319 <iget+0x49>
      release(&icache.lock);
8010136d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101370:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101373:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101375:	68 20 3a 11 80       	push   $0x80113a20
      ip->ref++;
8010137a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010137d:	e8 de 36 00 00       	call   80104a60 <release>
      return ip;
80101382:	83 c4 10             	add    $0x10,%esp
}
80101385:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101388:	89 f0                	mov    %esi,%eax
8010138a:	5b                   	pop    %ebx
8010138b:	5e                   	pop    %esi
8010138c:	5f                   	pop    %edi
8010138d:	5d                   	pop    %ebp
8010138e:	c3                   	ret    
    panic("iget: no inodes");
8010138f:	83 ec 0c             	sub    $0xc,%esp
80101392:	68 e8 7d 10 80       	push   $0x80107de8
80101397:	e8 f4 ef ff ff       	call   80100390 <panic>
8010139c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	57                   	push   %edi
801013a4:	56                   	push   %esi
801013a5:	53                   	push   %ebx
801013a6:	89 c6                	mov    %eax,%esi
801013a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013ab:	83 fa 0b             	cmp    $0xb,%edx
801013ae:	77 18                	ja     801013c8 <bmap+0x28>
801013b0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801013b3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801013b6:	85 db                	test   %ebx,%ebx
801013b8:	74 76                	je     80101430 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013bd:	89 d8                	mov    %ebx,%eax
801013bf:	5b                   	pop    %ebx
801013c0:	5e                   	pop    %esi
801013c1:	5f                   	pop    %edi
801013c2:	5d                   	pop    %ebp
801013c3:	c3                   	ret    
801013c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801013c8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801013cb:	83 fb 7f             	cmp    $0x7f,%ebx
801013ce:	0f 87 90 00 00 00    	ja     80101464 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801013d4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013da:	8b 00                	mov    (%eax),%eax
801013dc:	85 d2                	test   %edx,%edx
801013de:	74 70                	je     80101450 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801013e0:	83 ec 08             	sub    $0x8,%esp
801013e3:	52                   	push   %edx
801013e4:	50                   	push   %eax
801013e5:	e8 e6 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013ea:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013ee:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801013f1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013f3:	8b 1a                	mov    (%edx),%ebx
801013f5:	85 db                	test   %ebx,%ebx
801013f7:	75 1d                	jne    80101416 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801013f9:	8b 06                	mov    (%esi),%eax
801013fb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013fe:	e8 bd fd ff ff       	call   801011c0 <balloc>
80101403:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101406:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101409:	89 c3                	mov    %eax,%ebx
8010140b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010140d:	57                   	push   %edi
8010140e:	e8 3d 1d 00 00       	call   80103150 <log_write>
80101413:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101416:	83 ec 0c             	sub    $0xc,%esp
80101419:	57                   	push   %edi
8010141a:	e8 c1 ed ff ff       	call   801001e0 <brelse>
8010141f:	83 c4 10             	add    $0x10,%esp
}
80101422:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101425:	89 d8                	mov    %ebx,%eax
80101427:	5b                   	pop    %ebx
80101428:	5e                   	pop    %esi
80101429:	5f                   	pop    %edi
8010142a:	5d                   	pop    %ebp
8010142b:	c3                   	ret    
8010142c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101430:	8b 00                	mov    (%eax),%eax
80101432:	e8 89 fd ff ff       	call   801011c0 <balloc>
80101437:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010143a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010143d:	89 c3                	mov    %eax,%ebx
}
8010143f:	89 d8                	mov    %ebx,%eax
80101441:	5b                   	pop    %ebx
80101442:	5e                   	pop    %esi
80101443:	5f                   	pop    %edi
80101444:	5d                   	pop    %ebp
80101445:	c3                   	ret    
80101446:	8d 76 00             	lea    0x0(%esi),%esi
80101449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101450:	e8 6b fd ff ff       	call   801011c0 <balloc>
80101455:	89 c2                	mov    %eax,%edx
80101457:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010145d:	8b 06                	mov    (%esi),%eax
8010145f:	e9 7c ff ff ff       	jmp    801013e0 <bmap+0x40>
  panic("bmap: out of range");
80101464:	83 ec 0c             	sub    $0xc,%esp
80101467:	68 f8 7d 10 80       	push   $0x80107df8
8010146c:	e8 1f ef ff ff       	call   80100390 <panic>
80101471:	eb 0d                	jmp    80101480 <readsb>
80101473:	90                   	nop
80101474:	90                   	nop
80101475:	90                   	nop
80101476:	90                   	nop
80101477:	90                   	nop
80101478:	90                   	nop
80101479:	90                   	nop
8010147a:	90                   	nop
8010147b:	90                   	nop
8010147c:	90                   	nop
8010147d:	90                   	nop
8010147e:	90                   	nop
8010147f:	90                   	nop

80101480 <readsb>:
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	56                   	push   %esi
80101484:	53                   	push   %ebx
80101485:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101488:	83 ec 08             	sub    $0x8,%esp
8010148b:	6a 01                	push   $0x1
8010148d:	ff 75 08             	pushl  0x8(%ebp)
80101490:	e8 3b ec ff ff       	call   801000d0 <bread>
80101495:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101497:	8d 40 5c             	lea    0x5c(%eax),%eax
8010149a:	83 c4 0c             	add    $0xc,%esp
8010149d:	6a 1c                	push   $0x1c
8010149f:	50                   	push   %eax
801014a0:	56                   	push   %esi
801014a1:	e8 ba 36 00 00       	call   80104b60 <memmove>
  brelse(bp);
801014a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801014a9:	83 c4 10             	add    $0x10,%esp
}
801014ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014af:	5b                   	pop    %ebx
801014b0:	5e                   	pop    %esi
801014b1:	5d                   	pop    %ebp
  brelse(bp);
801014b2:	e9 29 ed ff ff       	jmp    801001e0 <brelse>
801014b7:	89 f6                	mov    %esi,%esi
801014b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014c0 <iinit>:
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	53                   	push   %ebx
801014c4:	bb 60 3a 11 80       	mov    $0x80113a60,%ebx
801014c9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801014cc:	68 0b 7e 10 80       	push   $0x80107e0b
801014d1:	68 20 3a 11 80       	push   $0x80113a20
801014d6:	e8 85 33 00 00       	call   80104860 <initlock>
801014db:	83 c4 10             	add    $0x10,%esp
801014de:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014e0:	83 ec 08             	sub    $0x8,%esp
801014e3:	68 12 7e 10 80       	push   $0x80107e12
801014e8:	53                   	push   %ebx
801014e9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ef:	e8 3c 32 00 00       	call   80104730 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014f4:	83 c4 10             	add    $0x10,%esp
801014f7:	81 fb 80 56 11 80    	cmp    $0x80115680,%ebx
801014fd:	75 e1                	jne    801014e0 <iinit+0x20>
  readsb(dev, &sb);
801014ff:	83 ec 08             	sub    $0x8,%esp
80101502:	68 00 3a 11 80       	push   $0x80113a00
80101507:	ff 75 08             	pushl  0x8(%ebp)
8010150a:	e8 71 ff ff ff       	call   80101480 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010150f:	ff 35 18 3a 11 80    	pushl  0x80113a18
80101515:	ff 35 14 3a 11 80    	pushl  0x80113a14
8010151b:	ff 35 10 3a 11 80    	pushl  0x80113a10
80101521:	ff 35 0c 3a 11 80    	pushl  0x80113a0c
80101527:	ff 35 08 3a 11 80    	pushl  0x80113a08
8010152d:	ff 35 04 3a 11 80    	pushl  0x80113a04
80101533:	ff 35 00 3a 11 80    	pushl  0x80113a00
80101539:	68 bc 7e 10 80       	push   $0x80107ebc
8010153e:	e8 1d f1 ff ff       	call   80100660 <cprintf>
}
80101543:	83 c4 30             	add    $0x30,%esp
80101546:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101549:	c9                   	leave  
8010154a:	c3                   	ret    
8010154b:	90                   	nop
8010154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101550 <ialloc>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	57                   	push   %edi
80101554:	56                   	push   %esi
80101555:	53                   	push   %ebx
80101556:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101559:	83 3d 08 3a 11 80 01 	cmpl   $0x1,0x80113a08
{
80101560:	8b 45 0c             	mov    0xc(%ebp),%eax
80101563:	8b 75 08             	mov    0x8(%ebp),%esi
80101566:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101569:	0f 86 91 00 00 00    	jbe    80101600 <ialloc+0xb0>
8010156f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101574:	eb 21                	jmp    80101597 <ialloc+0x47>
80101576:	8d 76 00             	lea    0x0(%esi),%esi
80101579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101580:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101583:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101586:	57                   	push   %edi
80101587:	e8 54 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010158c:	83 c4 10             	add    $0x10,%esp
8010158f:	39 1d 08 3a 11 80    	cmp    %ebx,0x80113a08
80101595:	76 69                	jbe    80101600 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101597:	89 d8                	mov    %ebx,%eax
80101599:	83 ec 08             	sub    $0x8,%esp
8010159c:	c1 e8 03             	shr    $0x3,%eax
8010159f:	03 05 14 3a 11 80    	add    0x80113a14,%eax
801015a5:	50                   	push   %eax
801015a6:	56                   	push   %esi
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
801015ac:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801015ae:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801015b0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801015b3:	83 e0 07             	and    $0x7,%eax
801015b6:	c1 e0 06             	shl    $0x6,%eax
801015b9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015bd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015c1:	75 bd                	jne    80101580 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015c3:	83 ec 04             	sub    $0x4,%esp
801015c6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015c9:	6a 40                	push   $0x40
801015cb:	6a 00                	push   $0x0
801015cd:	51                   	push   %ecx
801015ce:	e8 dd 34 00 00       	call   80104ab0 <memset>
      dip->type = type;
801015d3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015d7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015da:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015dd:	89 3c 24             	mov    %edi,(%esp)
801015e0:	e8 6b 1b 00 00       	call   80103150 <log_write>
      brelse(bp);
801015e5:	89 3c 24             	mov    %edi,(%esp)
801015e8:	e8 f3 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ed:	83 c4 10             	add    $0x10,%esp
}
801015f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015f3:	89 da                	mov    %ebx,%edx
801015f5:	89 f0                	mov    %esi,%eax
}
801015f7:	5b                   	pop    %ebx
801015f8:	5e                   	pop    %esi
801015f9:	5f                   	pop    %edi
801015fa:	5d                   	pop    %ebp
      return iget(dev, inum);
801015fb:	e9 d0 fc ff ff       	jmp    801012d0 <iget>
  panic("ialloc: no inodes");
80101600:	83 ec 0c             	sub    $0xc,%esp
80101603:	68 18 7e 10 80       	push   $0x80107e18
80101608:	e8 83 ed ff ff       	call   80100390 <panic>
8010160d:	8d 76 00             	lea    0x0(%esi),%esi

80101610 <iupdate>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	56                   	push   %esi
80101614:	53                   	push   %ebx
80101615:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101618:	83 ec 08             	sub    $0x8,%esp
8010161b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010161e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101621:	c1 e8 03             	shr    $0x3,%eax
80101624:	03 05 14 3a 11 80    	add    0x80113a14,%eax
8010162a:	50                   	push   %eax
8010162b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010162e:	e8 9d ea ff ff       	call   801000d0 <bread>
80101633:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101635:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101638:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010163f:	83 e0 07             	and    $0x7,%eax
80101642:	c1 e0 06             	shl    $0x6,%eax
80101645:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101649:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010164c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101650:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101653:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101657:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010165b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010165f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101663:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101667:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010166a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010166d:	6a 34                	push   $0x34
8010166f:	53                   	push   %ebx
80101670:	50                   	push   %eax
80101671:	e8 ea 34 00 00       	call   80104b60 <memmove>
  log_write(bp);
80101676:	89 34 24             	mov    %esi,(%esp)
80101679:	e8 d2 1a 00 00       	call   80103150 <log_write>
  brelse(bp);
8010167e:	89 75 08             	mov    %esi,0x8(%ebp)
80101681:	83 c4 10             	add    $0x10,%esp
}
80101684:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101687:	5b                   	pop    %ebx
80101688:	5e                   	pop    %esi
80101689:	5d                   	pop    %ebp
  brelse(bp);
8010168a:	e9 51 eb ff ff       	jmp    801001e0 <brelse>
8010168f:	90                   	nop

80101690 <idup>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	53                   	push   %ebx
80101694:	83 ec 10             	sub    $0x10,%esp
80101697:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010169a:	68 20 3a 11 80       	push   $0x80113a20
8010169f:	e8 fc 32 00 00       	call   801049a0 <acquire>
  ip->ref++;
801016a4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016a8:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
801016af:	e8 ac 33 00 00       	call   80104a60 <release>
}
801016b4:	89 d8                	mov    %ebx,%eax
801016b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016b9:	c9                   	leave  
801016ba:	c3                   	ret    
801016bb:	90                   	nop
801016bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016c0 <ilock>:
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	56                   	push   %esi
801016c4:	53                   	push   %ebx
801016c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016c8:	85 db                	test   %ebx,%ebx
801016ca:	0f 84 b7 00 00 00    	je     80101787 <ilock+0xc7>
801016d0:	8b 53 08             	mov    0x8(%ebx),%edx
801016d3:	85 d2                	test   %edx,%edx
801016d5:	0f 8e ac 00 00 00    	jle    80101787 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016db:	8d 43 0c             	lea    0xc(%ebx),%eax
801016de:	83 ec 0c             	sub    $0xc,%esp
801016e1:	50                   	push   %eax
801016e2:	e8 89 30 00 00       	call   80104770 <acquiresleep>
  if(ip->valid == 0){
801016e7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ea:	83 c4 10             	add    $0x10,%esp
801016ed:	85 c0                	test   %eax,%eax
801016ef:	74 0f                	je     80101700 <ilock+0x40>
}
801016f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016f4:	5b                   	pop    %ebx
801016f5:	5e                   	pop    %esi
801016f6:	5d                   	pop    %ebp
801016f7:	c3                   	ret    
801016f8:	90                   	nop
801016f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101700:	8b 43 04             	mov    0x4(%ebx),%eax
80101703:	83 ec 08             	sub    $0x8,%esp
80101706:	c1 e8 03             	shr    $0x3,%eax
80101709:	03 05 14 3a 11 80    	add    0x80113a14,%eax
8010170f:	50                   	push   %eax
80101710:	ff 33                	pushl  (%ebx)
80101712:	e8 b9 e9 ff ff       	call   801000d0 <bread>
80101717:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101719:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010171c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010171f:	83 e0 07             	and    $0x7,%eax
80101722:	c1 e0 06             	shl    $0x6,%eax
80101725:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101729:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010172c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010172f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101733:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101737:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010173b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010173f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101743:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101747:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010174b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010174e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101751:	6a 34                	push   $0x34
80101753:	50                   	push   %eax
80101754:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101757:	50                   	push   %eax
80101758:	e8 03 34 00 00       	call   80104b60 <memmove>
    brelse(bp);
8010175d:	89 34 24             	mov    %esi,(%esp)
80101760:	e8 7b ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101765:	83 c4 10             	add    $0x10,%esp
80101768:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010176d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101774:	0f 85 77 ff ff ff    	jne    801016f1 <ilock+0x31>
      panic("ilock: no type");
8010177a:	83 ec 0c             	sub    $0xc,%esp
8010177d:	68 30 7e 10 80       	push   $0x80107e30
80101782:	e8 09 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101787:	83 ec 0c             	sub    $0xc,%esp
8010178a:	68 2a 7e 10 80       	push   $0x80107e2a
8010178f:	e8 fc eb ff ff       	call   80100390 <panic>
80101794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010179a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801017a0 <iunlock>:
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	56                   	push   %esi
801017a4:	53                   	push   %ebx
801017a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017a8:	85 db                	test   %ebx,%ebx
801017aa:	74 28                	je     801017d4 <iunlock+0x34>
801017ac:	8d 73 0c             	lea    0xc(%ebx),%esi
801017af:	83 ec 0c             	sub    $0xc,%esp
801017b2:	56                   	push   %esi
801017b3:	e8 58 30 00 00       	call   80104810 <holdingsleep>
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	85 c0                	test   %eax,%eax
801017bd:	74 15                	je     801017d4 <iunlock+0x34>
801017bf:	8b 43 08             	mov    0x8(%ebx),%eax
801017c2:	85 c0                	test   %eax,%eax
801017c4:	7e 0e                	jle    801017d4 <iunlock+0x34>
  releasesleep(&ip->lock);
801017c6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017cc:	5b                   	pop    %ebx
801017cd:	5e                   	pop    %esi
801017ce:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017cf:	e9 fc 2f 00 00       	jmp    801047d0 <releasesleep>
    panic("iunlock");
801017d4:	83 ec 0c             	sub    $0xc,%esp
801017d7:	68 3f 7e 10 80       	push   $0x80107e3f
801017dc:	e8 af eb ff ff       	call   80100390 <panic>
801017e1:	eb 0d                	jmp    801017f0 <iput>
801017e3:	90                   	nop
801017e4:	90                   	nop
801017e5:	90                   	nop
801017e6:	90                   	nop
801017e7:	90                   	nop
801017e8:	90                   	nop
801017e9:	90                   	nop
801017ea:	90                   	nop
801017eb:	90                   	nop
801017ec:	90                   	nop
801017ed:	90                   	nop
801017ee:	90                   	nop
801017ef:	90                   	nop

801017f0 <iput>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	57                   	push   %edi
801017f4:	56                   	push   %esi
801017f5:	53                   	push   %ebx
801017f6:	83 ec 28             	sub    $0x28,%esp
801017f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017fc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017ff:	57                   	push   %edi
80101800:	e8 6b 2f 00 00       	call   80104770 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101805:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101808:	83 c4 10             	add    $0x10,%esp
8010180b:	85 d2                	test   %edx,%edx
8010180d:	74 07                	je     80101816 <iput+0x26>
8010180f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101814:	74 32                	je     80101848 <iput+0x58>
  releasesleep(&ip->lock);
80101816:	83 ec 0c             	sub    $0xc,%esp
80101819:	57                   	push   %edi
8010181a:	e8 b1 2f 00 00       	call   801047d0 <releasesleep>
  acquire(&icache.lock);
8010181f:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
80101826:	e8 75 31 00 00       	call   801049a0 <acquire>
  ip->ref--;
8010182b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010182f:	83 c4 10             	add    $0x10,%esp
80101832:	c7 45 08 20 3a 11 80 	movl   $0x80113a20,0x8(%ebp)
}
80101839:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010183c:	5b                   	pop    %ebx
8010183d:	5e                   	pop    %esi
8010183e:	5f                   	pop    %edi
8010183f:	5d                   	pop    %ebp
  release(&icache.lock);
80101840:	e9 1b 32 00 00       	jmp    80104a60 <release>
80101845:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101848:	83 ec 0c             	sub    $0xc,%esp
8010184b:	68 20 3a 11 80       	push   $0x80113a20
80101850:	e8 4b 31 00 00       	call   801049a0 <acquire>
    int r = ip->ref;
80101855:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101858:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
8010185f:	e8 fc 31 00 00       	call   80104a60 <release>
    if(r == 1){
80101864:	83 c4 10             	add    $0x10,%esp
80101867:	83 fe 01             	cmp    $0x1,%esi
8010186a:	75 aa                	jne    80101816 <iput+0x26>
8010186c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101872:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101875:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101878:	89 cf                	mov    %ecx,%edi
8010187a:	eb 0b                	jmp    80101887 <iput+0x97>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101880:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101883:	39 fe                	cmp    %edi,%esi
80101885:	74 19                	je     801018a0 <iput+0xb0>
    if(ip->addrs[i]){
80101887:	8b 16                	mov    (%esi),%edx
80101889:	85 d2                	test   %edx,%edx
8010188b:	74 f3                	je     80101880 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010188d:	8b 03                	mov    (%ebx),%eax
8010188f:	e8 bc f8 ff ff       	call   80101150 <bfree>
      ip->addrs[i] = 0;
80101894:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010189a:	eb e4                	jmp    80101880 <iput+0x90>
8010189c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018a0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018a6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018a9:	85 c0                	test   %eax,%eax
801018ab:	75 33                	jne    801018e0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801018ad:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801018b0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801018b7:	53                   	push   %ebx
801018b8:	e8 53 fd ff ff       	call   80101610 <iupdate>
      ip->type = 0;
801018bd:	31 c0                	xor    %eax,%eax
801018bf:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801018c3:	89 1c 24             	mov    %ebx,(%esp)
801018c6:	e8 45 fd ff ff       	call   80101610 <iupdate>
      ip->valid = 0;
801018cb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018d2:	83 c4 10             	add    $0x10,%esp
801018d5:	e9 3c ff ff ff       	jmp    80101816 <iput+0x26>
801018da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018e0:	83 ec 08             	sub    $0x8,%esp
801018e3:	50                   	push   %eax
801018e4:	ff 33                	pushl  (%ebx)
801018e6:	e8 e5 e7 ff ff       	call   801000d0 <bread>
801018eb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018f1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018f7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018fa:	83 c4 10             	add    $0x10,%esp
801018fd:	89 cf                	mov    %ecx,%edi
801018ff:	eb 0e                	jmp    8010190f <iput+0x11f>
80101901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101908:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010190b:	39 fe                	cmp    %edi,%esi
8010190d:	74 0f                	je     8010191e <iput+0x12e>
      if(a[j])
8010190f:	8b 16                	mov    (%esi),%edx
80101911:	85 d2                	test   %edx,%edx
80101913:	74 f3                	je     80101908 <iput+0x118>
        bfree(ip->dev, a[j]);
80101915:	8b 03                	mov    (%ebx),%eax
80101917:	e8 34 f8 ff ff       	call   80101150 <bfree>
8010191c:	eb ea                	jmp    80101908 <iput+0x118>
    brelse(bp);
8010191e:	83 ec 0c             	sub    $0xc,%esp
80101921:	ff 75 e4             	pushl  -0x1c(%ebp)
80101924:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101927:	e8 b4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010192c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101932:	8b 03                	mov    (%ebx),%eax
80101934:	e8 17 f8 ff ff       	call   80101150 <bfree>
    ip->addrs[NDIRECT] = 0;
80101939:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101940:	00 00 00 
80101943:	83 c4 10             	add    $0x10,%esp
80101946:	e9 62 ff ff ff       	jmp    801018ad <iput+0xbd>
8010194b:	90                   	nop
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <iunlockput>:
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	53                   	push   %ebx
80101954:	83 ec 10             	sub    $0x10,%esp
80101957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010195a:	53                   	push   %ebx
8010195b:	e8 40 fe ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101960:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101963:	83 c4 10             	add    $0x10,%esp
}
80101966:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101969:	c9                   	leave  
  iput(ip);
8010196a:	e9 81 fe ff ff       	jmp    801017f0 <iput>
8010196f:	90                   	nop

80101970 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	8b 55 08             	mov    0x8(%ebp),%edx
80101976:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101979:	8b 0a                	mov    (%edx),%ecx
8010197b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010197e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101981:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101984:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101988:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010198b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010198f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101993:	8b 52 58             	mov    0x58(%edx),%edx
80101996:	89 50 10             	mov    %edx,0x10(%eax)
}
80101999:	5d                   	pop    %ebp
8010199a:	c3                   	ret    
8010199b:	90                   	nop
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019a0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	57                   	push   %edi
801019a4:	56                   	push   %esi
801019a5:	53                   	push   %ebx
801019a6:	83 ec 1c             	sub    $0x1c,%esp
801019a9:	8b 45 08             	mov    0x8(%ebp),%eax
801019ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801019af:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019b2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801019b7:	89 75 e0             	mov    %esi,-0x20(%ebp)
801019ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019bd:	8b 75 10             	mov    0x10(%ebp),%esi
801019c0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019c3:	0f 84 a7 00 00 00    	je     80101a70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019cc:	8b 40 58             	mov    0x58(%eax),%eax
801019cf:	39 c6                	cmp    %eax,%esi
801019d1:	0f 87 ba 00 00 00    	ja     80101a91 <readi+0xf1>
801019d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019da:	89 f9                	mov    %edi,%ecx
801019dc:	01 f1                	add    %esi,%ecx
801019de:	0f 82 ad 00 00 00    	jb     80101a91 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019e4:	89 c2                	mov    %eax,%edx
801019e6:	29 f2                	sub    %esi,%edx
801019e8:	39 c8                	cmp    %ecx,%eax
801019ea:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ed:	31 ff                	xor    %edi,%edi
801019ef:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019f1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f4:	74 6c                	je     80101a62 <readi+0xc2>
801019f6:	8d 76 00             	lea    0x0(%esi),%esi
801019f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a03:	89 f2                	mov    %esi,%edx
80101a05:	c1 ea 09             	shr    $0x9,%edx
80101a08:	89 d8                	mov    %ebx,%eax
80101a0a:	e8 91 f9 ff ff       	call   801013a0 <bmap>
80101a0f:	83 ec 08             	sub    $0x8,%esp
80101a12:	50                   	push   %eax
80101a13:	ff 33                	pushl  (%ebx)
80101a15:	e8 b6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a1a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a1d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a1f:	89 f0                	mov    %esi,%eax
80101a21:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a26:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a2b:	83 c4 0c             	add    $0xc,%esp
80101a2e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a30:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a34:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a37:	29 fb                	sub    %edi,%ebx
80101a39:	39 d9                	cmp    %ebx,%ecx
80101a3b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a3e:	53                   	push   %ebx
80101a3f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a40:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a42:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a45:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a47:	e8 14 31 00 00       	call   80104b60 <memmove>
    brelse(bp);
80101a4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a4f:	89 14 24             	mov    %edx,(%esp)
80101a52:	e8 89 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a57:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a5a:	83 c4 10             	add    $0x10,%esp
80101a5d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a60:	77 9e                	ja     80101a00 <readi+0x60>
  }
  return n;
80101a62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a68:	5b                   	pop    %ebx
80101a69:	5e                   	pop    %esi
80101a6a:	5f                   	pop    %edi
80101a6b:	5d                   	pop    %ebp
80101a6c:	c3                   	ret    
80101a6d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a74:	66 83 f8 09          	cmp    $0x9,%ax
80101a78:	77 17                	ja     80101a91 <readi+0xf1>
80101a7a:	8b 04 c5 a0 39 11 80 	mov    -0x7feec660(,%eax,8),%eax
80101a81:	85 c0                	test   %eax,%eax
80101a83:	74 0c                	je     80101a91 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a85:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a8b:	5b                   	pop    %ebx
80101a8c:	5e                   	pop    %esi
80101a8d:	5f                   	pop    %edi
80101a8e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a8f:	ff e0                	jmp    *%eax
      return -1;
80101a91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a96:	eb cd                	jmp    80101a65 <readi+0xc5>
80101a98:	90                   	nop
80101a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101aa0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 1c             	sub    $0x1c,%esp
80101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101aaf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ab7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101abd:	8b 75 10             	mov    0x10(%ebp),%esi
80101ac0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101ac3:	0f 84 b7 00 00 00    	je     80101b80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ac9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101acc:	39 70 58             	cmp    %esi,0x58(%eax)
80101acf:	0f 82 eb 00 00 00    	jb     80101bc0 <writei+0x120>
80101ad5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ad8:	31 d2                	xor    %edx,%edx
80101ada:	89 f8                	mov    %edi,%eax
80101adc:	01 f0                	add    %esi,%eax
80101ade:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ae1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ae6:	0f 87 d4 00 00 00    	ja     80101bc0 <writei+0x120>
80101aec:	85 d2                	test   %edx,%edx
80101aee:	0f 85 cc 00 00 00    	jne    80101bc0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af4:	85 ff                	test   %edi,%edi
80101af6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101afd:	74 72                	je     80101b71 <writei+0xd1>
80101aff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b03:	89 f2                	mov    %esi,%edx
80101b05:	c1 ea 09             	shr    $0x9,%edx
80101b08:	89 f8                	mov    %edi,%eax
80101b0a:	e8 91 f8 ff ff       	call   801013a0 <bmap>
80101b0f:	83 ec 08             	sub    $0x8,%esp
80101b12:	50                   	push   %eax
80101b13:	ff 37                	pushl  (%edi)
80101b15:	e8 b6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b1a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b1d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b20:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b22:	89 f0                	mov    %esi,%eax
80101b24:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b29:	83 c4 0c             	add    $0xc,%esp
80101b2c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b31:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b33:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b37:	39 d9                	cmp    %ebx,%ecx
80101b39:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b3c:	53                   	push   %ebx
80101b3d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b40:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b42:	50                   	push   %eax
80101b43:	e8 18 30 00 00       	call   80104b60 <memmove>
    log_write(bp);
80101b48:	89 3c 24             	mov    %edi,(%esp)
80101b4b:	e8 00 16 00 00       	call   80103150 <log_write>
    brelse(bp);
80101b50:	89 3c 24             	mov    %edi,(%esp)
80101b53:	e8 88 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b58:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b5b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b5e:	83 c4 10             	add    $0x10,%esp
80101b61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b64:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b67:	77 97                	ja     80101b00 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b6f:	77 37                	ja     80101ba8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b71:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b77:	5b                   	pop    %ebx
80101b78:	5e                   	pop    %esi
80101b79:	5f                   	pop    %edi
80101b7a:	5d                   	pop    %ebp
80101b7b:	c3                   	ret    
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b84:	66 83 f8 09          	cmp    $0x9,%ax
80101b88:	77 36                	ja     80101bc0 <writei+0x120>
80101b8a:	8b 04 c5 a4 39 11 80 	mov    -0x7feec65c(,%eax,8),%eax
80101b91:	85 c0                	test   %eax,%eax
80101b93:	74 2b                	je     80101bc0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b95:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b9b:	5b                   	pop    %ebx
80101b9c:	5e                   	pop    %esi
80101b9d:	5f                   	pop    %edi
80101b9e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b9f:	ff e0                	jmp    *%eax
80101ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101bab:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101bae:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101bb1:	50                   	push   %eax
80101bb2:	e8 59 fa ff ff       	call   80101610 <iupdate>
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	eb b5                	jmp    80101b71 <writei+0xd1>
80101bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bc5:	eb ad                	jmp    80101b74 <writei+0xd4>
80101bc7:	89 f6                	mov    %esi,%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bd6:	6a 0e                	push   $0xe
80101bd8:	ff 75 0c             	pushl  0xc(%ebp)
80101bdb:	ff 75 08             	pushl  0x8(%ebp)
80101bde:	e8 ed 2f 00 00       	call   80104bd0 <strncmp>
}
80101be3:	c9                   	leave  
80101be4:	c3                   	ret    
80101be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 1c             	sub    $0x1c,%esp
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bfc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c01:	0f 85 85 00 00 00    	jne    80101c8c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c07:	8b 53 58             	mov    0x58(%ebx),%edx
80101c0a:	31 ff                	xor    %edi,%edi
80101c0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c0f:	85 d2                	test   %edx,%edx
80101c11:	74 3e                	je     80101c51 <dirlookup+0x61>
80101c13:	90                   	nop
80101c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c18:	6a 10                	push   $0x10
80101c1a:	57                   	push   %edi
80101c1b:	56                   	push   %esi
80101c1c:	53                   	push   %ebx
80101c1d:	e8 7e fd ff ff       	call   801019a0 <readi>
80101c22:	83 c4 10             	add    $0x10,%esp
80101c25:	83 f8 10             	cmp    $0x10,%eax
80101c28:	75 55                	jne    80101c7f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c2f:	74 18                	je     80101c49 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c31:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c34:	83 ec 04             	sub    $0x4,%esp
80101c37:	6a 0e                	push   $0xe
80101c39:	50                   	push   %eax
80101c3a:	ff 75 0c             	pushl  0xc(%ebp)
80101c3d:	e8 8e 2f 00 00       	call   80104bd0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c42:	83 c4 10             	add    $0x10,%esp
80101c45:	85 c0                	test   %eax,%eax
80101c47:	74 17                	je     80101c60 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c49:	83 c7 10             	add    $0x10,%edi
80101c4c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c4f:	72 c7                	jb     80101c18 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c51:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c54:	31 c0                	xor    %eax,%eax
}
80101c56:	5b                   	pop    %ebx
80101c57:	5e                   	pop    %esi
80101c58:	5f                   	pop    %edi
80101c59:	5d                   	pop    %ebp
80101c5a:	c3                   	ret    
80101c5b:	90                   	nop
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c60:	8b 45 10             	mov    0x10(%ebp),%eax
80101c63:	85 c0                	test   %eax,%eax
80101c65:	74 05                	je     80101c6c <dirlookup+0x7c>
        *poff = off;
80101c67:	8b 45 10             	mov    0x10(%ebp),%eax
80101c6a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c6c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c70:	8b 03                	mov    (%ebx),%eax
80101c72:	e8 59 f6 ff ff       	call   801012d0 <iget>
}
80101c77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7a:	5b                   	pop    %ebx
80101c7b:	5e                   	pop    %esi
80101c7c:	5f                   	pop    %edi
80101c7d:	5d                   	pop    %ebp
80101c7e:	c3                   	ret    
      panic("dirlookup read");
80101c7f:	83 ec 0c             	sub    $0xc,%esp
80101c82:	68 59 7e 10 80       	push   $0x80107e59
80101c87:	e8 04 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c8c:	83 ec 0c             	sub    $0xc,%esp
80101c8f:	68 47 7e 10 80       	push   $0x80107e47
80101c94:	e8 f7 e6 ff ff       	call   80100390 <panic>
80101c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ca0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	57                   	push   %edi
80101ca4:	56                   	push   %esi
80101ca5:	53                   	push   %ebx
80101ca6:	89 cf                	mov    %ecx,%edi
80101ca8:	89 c3                	mov    %eax,%ebx
80101caa:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cad:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101cb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101cb3:	0f 84 67 01 00 00    	je     80101e20 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101cb9:	e8 82 1f 00 00       	call   80103c40 <myproc>
  acquire(&icache.lock);
80101cbe:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101cc1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cc4:	68 20 3a 11 80       	push   $0x80113a20
80101cc9:	e8 d2 2c 00 00       	call   801049a0 <acquire>
  ip->ref++;
80101cce:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cd2:	c7 04 24 20 3a 11 80 	movl   $0x80113a20,(%esp)
80101cd9:	e8 82 2d 00 00       	call   80104a60 <release>
80101cde:	83 c4 10             	add    $0x10,%esp
80101ce1:	eb 08                	jmp    80101ceb <namex+0x4b>
80101ce3:	90                   	nop
80101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ce8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ceb:	0f b6 03             	movzbl (%ebx),%eax
80101cee:	3c 2f                	cmp    $0x2f,%al
80101cf0:	74 f6                	je     80101ce8 <namex+0x48>
  if(*path == 0)
80101cf2:	84 c0                	test   %al,%al
80101cf4:	0f 84 ee 00 00 00    	je     80101de8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cfa:	0f b6 03             	movzbl (%ebx),%eax
80101cfd:	3c 2f                	cmp    $0x2f,%al
80101cff:	0f 84 b3 00 00 00    	je     80101db8 <namex+0x118>
80101d05:	84 c0                	test   %al,%al
80101d07:	89 da                	mov    %ebx,%edx
80101d09:	75 09                	jne    80101d14 <namex+0x74>
80101d0b:	e9 a8 00 00 00       	jmp    80101db8 <namex+0x118>
80101d10:	84 c0                	test   %al,%al
80101d12:	74 0a                	je     80101d1e <namex+0x7e>
    path++;
80101d14:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d17:	0f b6 02             	movzbl (%edx),%eax
80101d1a:	3c 2f                	cmp    $0x2f,%al
80101d1c:	75 f2                	jne    80101d10 <namex+0x70>
80101d1e:	89 d1                	mov    %edx,%ecx
80101d20:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d22:	83 f9 0d             	cmp    $0xd,%ecx
80101d25:	0f 8e 91 00 00 00    	jle    80101dbc <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101d2b:	83 ec 04             	sub    $0x4,%esp
80101d2e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d31:	6a 0e                	push   $0xe
80101d33:	53                   	push   %ebx
80101d34:	57                   	push   %edi
80101d35:	e8 26 2e 00 00       	call   80104b60 <memmove>
    path++;
80101d3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d3d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d40:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d42:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d45:	75 11                	jne    80101d58 <namex+0xb8>
80101d47:	89 f6                	mov    %esi,%esi
80101d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d50:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d53:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d56:	74 f8                	je     80101d50 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d58:	83 ec 0c             	sub    $0xc,%esp
80101d5b:	56                   	push   %esi
80101d5c:	e8 5f f9 ff ff       	call   801016c0 <ilock>
    if(ip->type != T_DIR){
80101d61:	83 c4 10             	add    $0x10,%esp
80101d64:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d69:	0f 85 91 00 00 00    	jne    80101e00 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d72:	85 d2                	test   %edx,%edx
80101d74:	74 09                	je     80101d7f <namex+0xdf>
80101d76:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d79:	0f 84 b7 00 00 00    	je     80101e36 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d7f:	83 ec 04             	sub    $0x4,%esp
80101d82:	6a 00                	push   $0x0
80101d84:	57                   	push   %edi
80101d85:	56                   	push   %esi
80101d86:	e8 65 fe ff ff       	call   80101bf0 <dirlookup>
80101d8b:	83 c4 10             	add    $0x10,%esp
80101d8e:	85 c0                	test   %eax,%eax
80101d90:	74 6e                	je     80101e00 <namex+0x160>
  iunlock(ip);
80101d92:	83 ec 0c             	sub    $0xc,%esp
80101d95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d98:	56                   	push   %esi
80101d99:	e8 02 fa ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101d9e:	89 34 24             	mov    %esi,(%esp)
80101da1:	e8 4a fa ff ff       	call   801017f0 <iput>
80101da6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101da9:	83 c4 10             	add    $0x10,%esp
80101dac:	89 c6                	mov    %eax,%esi
80101dae:	e9 38 ff ff ff       	jmp    80101ceb <namex+0x4b>
80101db3:	90                   	nop
80101db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101db8:	89 da                	mov    %ebx,%edx
80101dba:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101dbc:	83 ec 04             	sub    $0x4,%esp
80101dbf:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dc2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101dc5:	51                   	push   %ecx
80101dc6:	53                   	push   %ebx
80101dc7:	57                   	push   %edi
80101dc8:	e8 93 2d 00 00       	call   80104b60 <memmove>
    name[len] = 0;
80101dcd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101dd0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dd3:	83 c4 10             	add    $0x10,%esp
80101dd6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dda:	89 d3                	mov    %edx,%ebx
80101ddc:	e9 61 ff ff ff       	jmp    80101d42 <namex+0xa2>
80101de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101de8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101deb:	85 c0                	test   %eax,%eax
80101ded:	75 5d                	jne    80101e4c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101def:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df2:	89 f0                	mov    %esi,%eax
80101df4:	5b                   	pop    %ebx
80101df5:	5e                   	pop    %esi
80101df6:	5f                   	pop    %edi
80101df7:	5d                   	pop    %ebp
80101df8:	c3                   	ret    
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e00:	83 ec 0c             	sub    $0xc,%esp
80101e03:	56                   	push   %esi
80101e04:	e8 97 f9 ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101e09:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e0c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e0e:	e8 dd f9 ff ff       	call   801017f0 <iput>
      return 0;
80101e13:	83 c4 10             	add    $0x10,%esp
}
80101e16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e19:	89 f0                	mov    %esi,%eax
80101e1b:	5b                   	pop    %ebx
80101e1c:	5e                   	pop    %esi
80101e1d:	5f                   	pop    %edi
80101e1e:	5d                   	pop    %ebp
80101e1f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e20:	ba 01 00 00 00       	mov    $0x1,%edx
80101e25:	b8 01 00 00 00       	mov    $0x1,%eax
80101e2a:	e8 a1 f4 ff ff       	call   801012d0 <iget>
80101e2f:	89 c6                	mov    %eax,%esi
80101e31:	e9 b5 fe ff ff       	jmp    80101ceb <namex+0x4b>
      iunlock(ip);
80101e36:	83 ec 0c             	sub    $0xc,%esp
80101e39:	56                   	push   %esi
80101e3a:	e8 61 f9 ff ff       	call   801017a0 <iunlock>
      return ip;
80101e3f:	83 c4 10             	add    $0x10,%esp
}
80101e42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e45:	89 f0                	mov    %esi,%eax
80101e47:	5b                   	pop    %ebx
80101e48:	5e                   	pop    %esi
80101e49:	5f                   	pop    %edi
80101e4a:	5d                   	pop    %ebp
80101e4b:	c3                   	ret    
    iput(ip);
80101e4c:	83 ec 0c             	sub    $0xc,%esp
80101e4f:	56                   	push   %esi
    return 0;
80101e50:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e52:	e8 99 f9 ff ff       	call   801017f0 <iput>
    return 0;
80101e57:	83 c4 10             	add    $0x10,%esp
80101e5a:	eb 93                	jmp    80101def <namex+0x14f>
80101e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e60 <dirlink>:
{
80101e60:	55                   	push   %ebp
80101e61:	89 e5                	mov    %esp,%ebp
80101e63:	57                   	push   %edi
80101e64:	56                   	push   %esi
80101e65:	53                   	push   %ebx
80101e66:	83 ec 20             	sub    $0x20,%esp
80101e69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e6c:	6a 00                	push   $0x0
80101e6e:	ff 75 0c             	pushl  0xc(%ebp)
80101e71:	53                   	push   %ebx
80101e72:	e8 79 fd ff ff       	call   80101bf0 <dirlookup>
80101e77:	83 c4 10             	add    $0x10,%esp
80101e7a:	85 c0                	test   %eax,%eax
80101e7c:	75 67                	jne    80101ee5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e7e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e81:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e84:	85 ff                	test   %edi,%edi
80101e86:	74 29                	je     80101eb1 <dirlink+0x51>
80101e88:	31 ff                	xor    %edi,%edi
80101e8a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e8d:	eb 09                	jmp    80101e98 <dirlink+0x38>
80101e8f:	90                   	nop
80101e90:	83 c7 10             	add    $0x10,%edi
80101e93:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e96:	73 19                	jae    80101eb1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e98:	6a 10                	push   $0x10
80101e9a:	57                   	push   %edi
80101e9b:	56                   	push   %esi
80101e9c:	53                   	push   %ebx
80101e9d:	e8 fe fa ff ff       	call   801019a0 <readi>
80101ea2:	83 c4 10             	add    $0x10,%esp
80101ea5:	83 f8 10             	cmp    $0x10,%eax
80101ea8:	75 4e                	jne    80101ef8 <dirlink+0x98>
    if(de.inum == 0)
80101eaa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101eaf:	75 df                	jne    80101e90 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101eb1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101eb4:	83 ec 04             	sub    $0x4,%esp
80101eb7:	6a 0e                	push   $0xe
80101eb9:	ff 75 0c             	pushl  0xc(%ebp)
80101ebc:	50                   	push   %eax
80101ebd:	e8 6e 2d 00 00       	call   80104c30 <strncpy>
  de.inum = inum;
80101ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ec5:	6a 10                	push   $0x10
80101ec7:	57                   	push   %edi
80101ec8:	56                   	push   %esi
80101ec9:	53                   	push   %ebx
  de.inum = inum;
80101eca:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ece:	e8 cd fb ff ff       	call   80101aa0 <writei>
80101ed3:	83 c4 20             	add    $0x20,%esp
80101ed6:	83 f8 10             	cmp    $0x10,%eax
80101ed9:	75 2a                	jne    80101f05 <dirlink+0xa5>
  return 0;
80101edb:	31 c0                	xor    %eax,%eax
}
80101edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ee0:	5b                   	pop    %ebx
80101ee1:	5e                   	pop    %esi
80101ee2:	5f                   	pop    %edi
80101ee3:	5d                   	pop    %ebp
80101ee4:	c3                   	ret    
    iput(ip);
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	50                   	push   %eax
80101ee9:	e8 02 f9 ff ff       	call   801017f0 <iput>
    return -1;
80101eee:	83 c4 10             	add    $0x10,%esp
80101ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ef6:	eb e5                	jmp    80101edd <dirlink+0x7d>
      panic("dirlink read");
80101ef8:	83 ec 0c             	sub    $0xc,%esp
80101efb:	68 68 7e 10 80       	push   $0x80107e68
80101f00:	e8 8b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101f05:	83 ec 0c             	sub    $0xc,%esp
80101f08:	68 0d 85 10 80       	push   $0x8010850d
80101f0d:	e8 7e e4 ff ff       	call   80100390 <panic>
80101f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <namei>:

struct inode*
namei(char *path)
{
80101f20:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f21:	31 d2                	xor    %edx,%edx
{
80101f23:	89 e5                	mov    %esp,%ebp
80101f25:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f28:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f2e:	e8 6d fd ff ff       	call   80101ca0 <namex>
}
80101f33:	c9                   	leave  
80101f34:	c3                   	ret    
80101f35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f40 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f40:	55                   	push   %ebp
  return namex(path, 1, name);
80101f41:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f46:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f48:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f4e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f4f:	e9 4c fd ff ff       	jmp    80101ca0 <namex>
80101f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101f60 <itoa>:

#include "fcntl.h"
#define DIGITS 14

char* itoa(int i, char b[]){
80101f60:	55                   	push   %ebp
    char const digit[] = "0123456789";
80101f61:	b8 38 39 00 00       	mov    $0x3938,%eax
char* itoa(int i, char b[]){
80101f66:	89 e5                	mov    %esp,%ebp
80101f68:	57                   	push   %edi
80101f69:	56                   	push   %esi
80101f6a:	53                   	push   %ebx
80101f6b:	83 ec 10             	sub    $0x10,%esp
80101f6e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80101f71:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80101f78:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
80101f7f:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
80101f83:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
80101f87:	8b 75 0c             	mov    0xc(%ebp),%esi
    char* p = b;
    if(i<0){
80101f8a:	85 c9                	test   %ecx,%ecx
80101f8c:	79 0a                	jns    80101f98 <itoa+0x38>
80101f8e:	89 f0                	mov    %esi,%eax
80101f90:	8d 76 01             	lea    0x1(%esi),%esi
        *p++ = '-';
        i *= -1;
80101f93:	f7 d9                	neg    %ecx
        *p++ = '-';
80101f95:	c6 00 2d             	movb   $0x2d,(%eax)
    }
    int shifter = i;
80101f98:	89 cb                	mov    %ecx,%ebx
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
80101f9a:	bf 67 66 66 66       	mov    $0x66666667,%edi
80101f9f:	90                   	nop
80101fa0:	89 d8                	mov    %ebx,%eax
80101fa2:	c1 fb 1f             	sar    $0x1f,%ebx
        ++p;
80101fa5:	83 c6 01             	add    $0x1,%esi
        shifter = shifter/10;
80101fa8:	f7 ef                	imul   %edi
80101faa:	c1 fa 02             	sar    $0x2,%edx
    }while(shifter);
80101fad:	29 da                	sub    %ebx,%edx
80101faf:	89 d3                	mov    %edx,%ebx
80101fb1:	75 ed                	jne    80101fa0 <itoa+0x40>
    *p = '\0';
80101fb3:	c6 06 00             	movb   $0x0,(%esi)
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
80101fb6:	bb 67 66 66 66       	mov    $0x66666667,%ebx
80101fbb:	90                   	nop
80101fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fc0:	89 c8                	mov    %ecx,%eax
80101fc2:	83 ee 01             	sub    $0x1,%esi
80101fc5:	f7 eb                	imul   %ebx
80101fc7:	89 c8                	mov    %ecx,%eax
80101fc9:	c1 f8 1f             	sar    $0x1f,%eax
80101fcc:	c1 fa 02             	sar    $0x2,%edx
80101fcf:	29 c2                	sub    %eax,%edx
80101fd1:	8d 04 92             	lea    (%edx,%edx,4),%eax
80101fd4:	01 c0                	add    %eax,%eax
80101fd6:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
80101fd8:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
80101fda:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
80101fdf:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
80101fe1:	88 06                	mov    %al,(%esi)
    }while(i);
80101fe3:	75 db                	jne    80101fc0 <itoa+0x60>
    return b;
}
80101fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
80101fe8:	83 c4 10             	add    $0x10,%esp
80101feb:	5b                   	pop    %ebx
80101fec:	5e                   	pop    %esi
80101fed:	5f                   	pop    %edi
80101fee:	5d                   	pop    %ebp
80101fef:	c3                   	ret    

80101ff0 <removeSwapFile>:
//remove swap file of proc p;
int
removeSwapFile(struct proc* p)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
  // cprintf("removeSp pid:%d\n", p->pid); // for debug Todo: delete
  //path of proccess
  char path[DIGITS];
  memmove(path,"/.swap", 6);
80101ff6:	8d 75 bc             	lea    -0x44(%ebp),%esi
{
80101ff9:	83 ec 40             	sub    $0x40,%esp
80101ffc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
80101fff:	6a 06                	push   $0x6
80102001:	68 75 7e 10 80       	push   $0x80107e75
80102006:	56                   	push   %esi
80102007:	e8 54 2b 00 00       	call   80104b60 <memmove>
  itoa(p->pid, path+ 6);
8010200c:	58                   	pop    %eax
8010200d:	8d 45 c2             	lea    -0x3e(%ebp),%eax
80102010:	5a                   	pop    %edx
80102011:	50                   	push   %eax
80102012:	ff 73 10             	pushl  0x10(%ebx)
80102015:	e8 46 ff ff ff       	call   80101f60 <itoa>
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ];
  uint off;

  if(0 == p->swapFile)
8010201a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010201d:	83 c4 10             	add    $0x10,%esp
80102020:	85 c0                	test   %eax,%eax
80102022:	0f 84 88 01 00 00    	je     801021b0 <removeSwapFile+0x1c0>
  {
    return -1;
  }
  fileclose(p->swapFile);
80102028:	83 ec 0c             	sub    $0xc,%esp
  return namex(path, 1, name);
8010202b:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  fileclose(p->swapFile);
8010202e:	50                   	push   %eax
8010202f:	e8 4c ee ff ff       	call   80100e80 <fileclose>

  begin_op();
80102034:	e8 47 0f 00 00       	call   80102f80 <begin_op>
  return namex(path, 1, name);
80102039:	89 f0                	mov    %esi,%eax
8010203b:	89 d9                	mov    %ebx,%ecx
8010203d:	ba 01 00 00 00       	mov    $0x1,%edx
80102042:	e8 59 fc ff ff       	call   80101ca0 <namex>
  if((dp = nameiparent(path, name)) == 0)
80102047:	83 c4 10             	add    $0x10,%esp
8010204a:	85 c0                	test   %eax,%eax
  return namex(path, 1, name);
8010204c:	89 c6                	mov    %eax,%esi
  if((dp = nameiparent(path, name)) == 0)
8010204e:	0f 84 66 01 00 00    	je     801021ba <removeSwapFile+0x1ca>
  {
    end_op();
    return -1;
  }

  ilock(dp);
80102054:	83 ec 0c             	sub    $0xc,%esp
80102057:	50                   	push   %eax
80102058:	e8 63 f6 ff ff       	call   801016c0 <ilock>
  return strncmp(s, t, DIRSIZ);
8010205d:	83 c4 0c             	add    $0xc,%esp
80102060:	6a 0e                	push   $0xe
80102062:	68 7d 7e 10 80       	push   $0x80107e7d
80102067:	53                   	push   %ebx
80102068:	e8 63 2b 00 00       	call   80104bd0 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010206d:	83 c4 10             	add    $0x10,%esp
80102070:	85 c0                	test   %eax,%eax
80102072:	0f 84 f8 00 00 00    	je     80102170 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
80102078:	83 ec 04             	sub    $0x4,%esp
8010207b:	6a 0e                	push   $0xe
8010207d:	68 7c 7e 10 80       	push   $0x80107e7c
80102082:	53                   	push   %ebx
80102083:	e8 48 2b 00 00       	call   80104bd0 <strncmp>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80102088:	83 c4 10             	add    $0x10,%esp
8010208b:	85 c0                	test   %eax,%eax
8010208d:	0f 84 dd 00 00 00    	je     80102170 <removeSwapFile+0x180>
     goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80102093:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102096:	83 ec 04             	sub    $0x4,%esp
80102099:	50                   	push   %eax
8010209a:	53                   	push   %ebx
8010209b:	56                   	push   %esi
8010209c:	e8 4f fb ff ff       	call   80101bf0 <dirlookup>
801020a1:	83 c4 10             	add    $0x10,%esp
801020a4:	85 c0                	test   %eax,%eax
801020a6:	89 c3                	mov    %eax,%ebx
801020a8:	0f 84 c2 00 00 00    	je     80102170 <removeSwapFile+0x180>
    goto bad;
  ilock(ip);
801020ae:	83 ec 0c             	sub    $0xc,%esp
801020b1:	50                   	push   %eax
801020b2:	e8 09 f6 ff ff       	call   801016c0 <ilock>

  if(ip->nlink < 1)
801020b7:	83 c4 10             	add    $0x10,%esp
801020ba:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801020bf:	0f 8e 11 01 00 00    	jle    801021d6 <removeSwapFile+0x1e6>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801020c5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801020ca:	74 74                	je     80102140 <removeSwapFile+0x150>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801020cc:	8d 7d d8             	lea    -0x28(%ebp),%edi
801020cf:	83 ec 04             	sub    $0x4,%esp
801020d2:	6a 10                	push   $0x10
801020d4:	6a 00                	push   $0x0
801020d6:	57                   	push   %edi
801020d7:	e8 d4 29 00 00       	call   80104ab0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020dc:	6a 10                	push   $0x10
801020de:	ff 75 b8             	pushl  -0x48(%ebp)
801020e1:	57                   	push   %edi
801020e2:	56                   	push   %esi
801020e3:	e8 b8 f9 ff ff       	call   80101aa0 <writei>
801020e8:	83 c4 20             	add    $0x20,%esp
801020eb:	83 f8 10             	cmp    $0x10,%eax
801020ee:	0f 85 d5 00 00 00    	jne    801021c9 <removeSwapFile+0x1d9>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801020f4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801020f9:	0f 84 91 00 00 00    	je     80102190 <removeSwapFile+0x1a0>
  iunlock(ip);
801020ff:	83 ec 0c             	sub    $0xc,%esp
80102102:	56                   	push   %esi
80102103:	e8 98 f6 ff ff       	call   801017a0 <iunlock>
  iput(ip);
80102108:	89 34 24             	mov    %esi,(%esp)
8010210b:	e8 e0 f6 ff ff       	call   801017f0 <iput>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
80102110:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80102115:	89 1c 24             	mov    %ebx,(%esp)
80102118:	e8 f3 f4 ff ff       	call   80101610 <iupdate>
  iunlock(ip);
8010211d:	89 1c 24             	mov    %ebx,(%esp)
80102120:	e8 7b f6 ff ff       	call   801017a0 <iunlock>
  iput(ip);
80102125:	89 1c 24             	mov    %ebx,(%esp)
80102128:	e8 c3 f6 ff ff       	call   801017f0 <iput>
  iunlockput(ip);

  end_op();
8010212d:	e8 be 0e 00 00       	call   80102ff0 <end_op>

  return 0;
80102132:	83 c4 10             	add    $0x10,%esp
80102135:	31 c0                	xor    %eax,%eax
  bad:
    iunlockput(dp);
    end_op();
    return -1;

}
80102137:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010213a:	5b                   	pop    %ebx
8010213b:	5e                   	pop    %esi
8010213c:	5f                   	pop    %edi
8010213d:	5d                   	pop    %ebp
8010213e:	c3                   	ret    
8010213f:	90                   	nop
  if(ip->type == T_DIR && !isdirempty(ip)){
80102140:	83 ec 0c             	sub    $0xc,%esp
80102143:	53                   	push   %ebx
80102144:	e8 47 31 00 00       	call   80105290 <isdirempty>
80102149:	83 c4 10             	add    $0x10,%esp
8010214c:	85 c0                	test   %eax,%eax
8010214e:	0f 85 78 ff ff ff    	jne    801020cc <removeSwapFile+0xdc>
  iunlock(ip);
80102154:	83 ec 0c             	sub    $0xc,%esp
80102157:	53                   	push   %ebx
80102158:	e8 43 f6 ff ff       	call   801017a0 <iunlock>
  iput(ip);
8010215d:	89 1c 24             	mov    %ebx,(%esp)
80102160:	e8 8b f6 ff ff       	call   801017f0 <iput>
80102165:	83 c4 10             	add    $0x10,%esp
80102168:	90                   	nop
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102170:	83 ec 0c             	sub    $0xc,%esp
80102173:	56                   	push   %esi
80102174:	e8 27 f6 ff ff       	call   801017a0 <iunlock>
  iput(ip);
80102179:	89 34 24             	mov    %esi,(%esp)
8010217c:	e8 6f f6 ff ff       	call   801017f0 <iput>
    end_op();
80102181:	e8 6a 0e 00 00       	call   80102ff0 <end_op>
    return -1;
80102186:	83 c4 10             	add    $0x10,%esp
80102189:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010218e:	eb a7                	jmp    80102137 <removeSwapFile+0x147>
    dp->nlink--;
80102190:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80102195:	83 ec 0c             	sub    $0xc,%esp
80102198:	56                   	push   %esi
80102199:	e8 72 f4 ff ff       	call   80101610 <iupdate>
8010219e:	83 c4 10             	add    $0x10,%esp
801021a1:	e9 59 ff ff ff       	jmp    801020ff <removeSwapFile+0x10f>
801021a6:	8d 76 00             	lea    0x0(%esi),%esi
801021a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801021b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021b5:	e9 7d ff ff ff       	jmp    80102137 <removeSwapFile+0x147>
    end_op();
801021ba:	e8 31 0e 00 00       	call   80102ff0 <end_op>
    return -1;
801021bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021c4:	e9 6e ff ff ff       	jmp    80102137 <removeSwapFile+0x147>
    panic("unlink: writei");
801021c9:	83 ec 0c             	sub    $0xc,%esp
801021cc:	68 91 7e 10 80       	push   $0x80107e91
801021d1:	e8 ba e1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801021d6:	83 ec 0c             	sub    $0xc,%esp
801021d9:	68 7f 7e 10 80       	push   $0x80107e7f
801021de:	e8 ad e1 ff ff       	call   80100390 <panic>
801021e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021f0 <createSwapFile>:


//return 0 on success
int
createSwapFile(struct proc* p)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	56                   	push   %esi
801021f4:	53                   	push   %ebx
  // cprintf("createSp pid:%d\n", p->pid); // for debug Todo: delete
  char path[DIGITS];
  memmove(path,"/.swap", 6);
801021f5:	8d 75 ea             	lea    -0x16(%ebp),%esi
{
801021f8:	83 ec 14             	sub    $0x14,%esp
801021fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
801021fe:	6a 06                	push   $0x6
80102200:	68 75 7e 10 80       	push   $0x80107e75
80102205:	56                   	push   %esi
80102206:	e8 55 29 00 00       	call   80104b60 <memmove>
  itoa(p->pid, path+ 6);
8010220b:	58                   	pop    %eax
8010220c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010220f:	5a                   	pop    %edx
80102210:	50                   	push   %eax
80102211:	ff 73 10             	pushl  0x10(%ebx)
80102214:	e8 47 fd ff ff       	call   80101f60 <itoa>

    begin_op();
80102219:	e8 62 0d 00 00       	call   80102f80 <begin_op>
    struct inode * in = create(path, T_FILE, 0, 0);
8010221e:	6a 00                	push   $0x0
80102220:	6a 00                	push   $0x0
80102222:	6a 02                	push   $0x2
80102224:	56                   	push   %esi
80102225:	e8 76 32 00 00       	call   801054a0 <create>
  iunlock(in);
8010222a:	83 c4 14             	add    $0x14,%esp
    struct inode * in = create(path, T_FILE, 0, 0);
8010222d:	89 c6                	mov    %eax,%esi
  iunlock(in);
8010222f:	50                   	push   %eax
80102230:	e8 6b f5 ff ff       	call   801017a0 <iunlock>

  p->swapFile = filealloc();
80102235:	e8 86 eb ff ff       	call   80100dc0 <filealloc>
  if (p->swapFile == 0)
8010223a:	83 c4 10             	add    $0x10,%esp
8010223d:	85 c0                	test   %eax,%eax
  p->swapFile = filealloc();
8010223f:	89 43 7c             	mov    %eax,0x7c(%ebx)
  if (p->swapFile == 0)
80102242:	74 32                	je     80102276 <createSwapFile+0x86>
    panic("no slot for files on /store");

  p->swapFile->ip = in;
80102244:	89 70 10             	mov    %esi,0x10(%eax)
  p->swapFile->type = FD_INODE;
80102247:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010224a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  p->swapFile->off = 0;
80102250:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102253:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  p->swapFile->readable = O_WRONLY;
8010225a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010225d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->swapFile->writable = O_RDWR;
80102261:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102264:	c6 40 09 02          	movb   $0x2,0x9(%eax)
    end_op();
80102268:	e8 83 0d 00 00       	call   80102ff0 <end_op>

    return 0;
}
8010226d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102270:	31 c0                	xor    %eax,%eax
80102272:	5b                   	pop    %ebx
80102273:	5e                   	pop    %esi
80102274:	5d                   	pop    %ebp
80102275:	c3                   	ret    
    panic("no slot for files on /store");
80102276:	83 ec 0c             	sub    $0xc,%esp
80102279:	68 a0 7e 10 80       	push   $0x80107ea0
8010227e:	e8 0d e1 ff ff       	call   80100390 <panic>
80102283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102290 <writeToSwapFile>:

//return as sys_write (-1 when error)
int
writeToSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	8b 45 08             	mov    0x8(%ebp),%eax
  // cprintf("writeToSp pid:%d\n", p->pid); // for debug Todo: delete

  p->swapFile->off = placeOnFile;
80102296:	8b 4d 10             	mov    0x10(%ebp),%ecx
80102299:	8b 50 7c             	mov    0x7c(%eax),%edx
8010229c:	89 4a 14             	mov    %ecx,0x14(%edx)

  return filewrite(p->swapFile, buffer, size);
8010229f:	8b 55 14             	mov    0x14(%ebp),%edx
801022a2:	89 55 10             	mov    %edx,0x10(%ebp)
801022a5:	8b 40 7c             	mov    0x7c(%eax),%eax
801022a8:	89 45 08             	mov    %eax,0x8(%ebp)

}
801022ab:	5d                   	pop    %ebp
  return filewrite(p->swapFile, buffer, size);
801022ac:	e9 7f ed ff ff       	jmp    80101030 <filewrite>
801022b1:	eb 0d                	jmp    801022c0 <readFromSwapFile>
801022b3:	90                   	nop
801022b4:	90                   	nop
801022b5:	90                   	nop
801022b6:	90                   	nop
801022b7:	90                   	nop
801022b8:	90                   	nop
801022b9:	90                   	nop
801022ba:	90                   	nop
801022bb:	90                   	nop
801022bc:	90                   	nop
801022bd:	90                   	nop
801022be:	90                   	nop
801022bf:	90                   	nop

801022c0 <readFromSwapFile>:

//return as sys_read (-1 when error)
int
readFromSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	8b 45 08             	mov    0x8(%ebp),%eax
  // cprintf("readFromSp pid:%d\n", p->pid); // for debug Todo: delete

  p->swapFile->off = placeOnFile;
801022c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801022c9:	8b 50 7c             	mov    0x7c(%eax),%edx
801022cc:	89 4a 14             	mov    %ecx,0x14(%edx)

  return fileread(p->swapFile, buffer,  size);
801022cf:	8b 55 14             	mov    0x14(%ebp),%edx
801022d2:	89 55 10             	mov    %edx,0x10(%ebp)
801022d5:	8b 40 7c             	mov    0x7c(%eax),%eax
801022d8:	89 45 08             	mov    %eax,0x8(%ebp)
}
801022db:	5d                   	pop    %ebp
  return fileread(p->swapFile, buffer,  size);
801022dc:	e9 bf ec ff ff       	jmp    80100fa0 <fileread>
801022e1:	66 90                	xchg   %ax,%ax
801022e3:	66 90                	xchg   %ax,%ax
801022e5:	66 90                	xchg   %ax,%ax
801022e7:	66 90                	xchg   %ax,%ax
801022e9:	66 90                	xchg   %ax,%ax
801022eb:	66 90                	xchg   %ax,%ax
801022ed:	66 90                	xchg   %ax,%ax
801022ef:	90                   	nop

801022f0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	57                   	push   %edi
801022f4:	56                   	push   %esi
801022f5:	53                   	push   %ebx
801022f6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801022f9:	85 c0                	test   %eax,%eax
801022fb:	0f 84 b4 00 00 00    	je     801023b5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102301:	8b 58 08             	mov    0x8(%eax),%ebx
80102304:	89 c6                	mov    %eax,%esi
80102306:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010230c:	0f 87 96 00 00 00    	ja     801023a8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102312:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102317:	89 f6                	mov    %esi,%esi
80102319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102320:	89 ca                	mov    %ecx,%edx
80102322:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102323:	83 e0 c0             	and    $0xffffffc0,%eax
80102326:	3c 40                	cmp    $0x40,%al
80102328:	75 f6                	jne    80102320 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010232a:	31 ff                	xor    %edi,%edi
8010232c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102331:	89 f8                	mov    %edi,%eax
80102333:	ee                   	out    %al,(%dx)
80102334:	b8 01 00 00 00       	mov    $0x1,%eax
80102339:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010233e:	ee                   	out    %al,(%dx)
8010233f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102344:	89 d8                	mov    %ebx,%eax
80102346:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102347:	89 d8                	mov    %ebx,%eax
80102349:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010234e:	c1 f8 08             	sar    $0x8,%eax
80102351:	ee                   	out    %al,(%dx)
80102352:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102357:	89 f8                	mov    %edi,%eax
80102359:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010235a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010235e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102363:	c1 e0 04             	shl    $0x4,%eax
80102366:	83 e0 10             	and    $0x10,%eax
80102369:	83 c8 e0             	or     $0xffffffe0,%eax
8010236c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010236d:	f6 06 04             	testb  $0x4,(%esi)
80102370:	75 16                	jne    80102388 <idestart+0x98>
80102372:	b8 20 00 00 00       	mov    $0x20,%eax
80102377:	89 ca                	mov    %ecx,%edx
80102379:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010237a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010237d:	5b                   	pop    %ebx
8010237e:	5e                   	pop    %esi
8010237f:	5f                   	pop    %edi
80102380:	5d                   	pop    %ebp
80102381:	c3                   	ret    
80102382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102388:	b8 30 00 00 00       	mov    $0x30,%eax
8010238d:	89 ca                	mov    %ecx,%edx
8010238f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102390:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102395:	83 c6 5c             	add    $0x5c,%esi
80102398:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010239d:	fc                   	cld    
8010239e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801023a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023a3:	5b                   	pop    %ebx
801023a4:	5e                   	pop    %esi
801023a5:	5f                   	pop    %edi
801023a6:	5d                   	pop    %ebp
801023a7:	c3                   	ret    
    panic("incorrect blockno");
801023a8:	83 ec 0c             	sub    $0xc,%esp
801023ab:	68 18 7f 10 80       	push   $0x80107f18
801023b0:	e8 db df ff ff       	call   80100390 <panic>
    panic("idestart");
801023b5:	83 ec 0c             	sub    $0xc,%esp
801023b8:	68 0f 7f 10 80       	push   $0x80107f0f
801023bd:	e8 ce df ff ff       	call   80100390 <panic>
801023c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023d0 <ideinit>:
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801023d6:	68 2a 7f 10 80       	push   $0x80107f2a
801023db:	68 80 b5 10 80       	push   $0x8010b580
801023e0:	e8 7b 24 00 00       	call   80104860 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801023e5:	58                   	pop    %eax
801023e6:	a1 40 5d 11 80       	mov    0x80115d40,%eax
801023eb:	5a                   	pop    %edx
801023ec:	83 e8 01             	sub    $0x1,%eax
801023ef:	50                   	push   %eax
801023f0:	6a 0e                	push   $0xe
801023f2:	e8 a9 02 00 00       	call   801026a0 <ioapicenable>
801023f7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023fa:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023ff:	90                   	nop
80102400:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102401:	83 e0 c0             	and    $0xffffffc0,%eax
80102404:	3c 40                	cmp    $0x40,%al
80102406:	75 f8                	jne    80102400 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102408:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010240d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102412:	ee                   	out    %al,(%dx)
80102413:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102418:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010241d:	eb 06                	jmp    80102425 <ideinit+0x55>
8010241f:	90                   	nop
  for(i=0; i<1000; i++){
80102420:	83 e9 01             	sub    $0x1,%ecx
80102423:	74 0f                	je     80102434 <ideinit+0x64>
80102425:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102426:	84 c0                	test   %al,%al
80102428:	74 f6                	je     80102420 <ideinit+0x50>
      havedisk1 = 1;
8010242a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102431:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102434:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102439:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010243e:	ee                   	out    %al,(%dx)
}
8010243f:	c9                   	leave  
80102440:	c3                   	ret    
80102441:	eb 0d                	jmp    80102450 <ideintr>
80102443:	90                   	nop
80102444:	90                   	nop
80102445:	90                   	nop
80102446:	90                   	nop
80102447:	90                   	nop
80102448:	90                   	nop
80102449:	90                   	nop
8010244a:	90                   	nop
8010244b:	90                   	nop
8010244c:	90                   	nop
8010244d:	90                   	nop
8010244e:	90                   	nop
8010244f:	90                   	nop

80102450 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	57                   	push   %edi
80102454:	56                   	push   %esi
80102455:	53                   	push   %ebx
80102456:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102459:	68 80 b5 10 80       	push   $0x8010b580
8010245e:	e8 3d 25 00 00       	call   801049a0 <acquire>

  if((b = idequeue) == 0){
80102463:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102469:	83 c4 10             	add    $0x10,%esp
8010246c:	85 db                	test   %ebx,%ebx
8010246e:	74 67                	je     801024d7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102470:	8b 43 58             	mov    0x58(%ebx),%eax
80102473:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102478:	8b 3b                	mov    (%ebx),%edi
8010247a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102480:	75 31                	jne    801024b3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102482:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102487:	89 f6                	mov    %esi,%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102490:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102491:	89 c6                	mov    %eax,%esi
80102493:	83 e6 c0             	and    $0xffffffc0,%esi
80102496:	89 f1                	mov    %esi,%ecx
80102498:	80 f9 40             	cmp    $0x40,%cl
8010249b:	75 f3                	jne    80102490 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010249d:	a8 21                	test   $0x21,%al
8010249f:	75 12                	jne    801024b3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801024a1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801024a4:	b9 80 00 00 00       	mov    $0x80,%ecx
801024a9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024ae:	fc                   	cld    
801024af:	f3 6d                	rep insl (%dx),%es:(%edi)
801024b1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801024b3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801024b6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801024b9:	89 f9                	mov    %edi,%ecx
801024bb:	83 c9 02             	or     $0x2,%ecx
801024be:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801024c0:	53                   	push   %ebx
801024c1:	e8 ca 1f 00 00       	call   80104490 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801024c6:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801024cb:	83 c4 10             	add    $0x10,%esp
801024ce:	85 c0                	test   %eax,%eax
801024d0:	74 05                	je     801024d7 <ideintr+0x87>
    idestart(idequeue);
801024d2:	e8 19 fe ff ff       	call   801022f0 <idestart>
    release(&idelock);
801024d7:	83 ec 0c             	sub    $0xc,%esp
801024da:	68 80 b5 10 80       	push   $0x8010b580
801024df:	e8 7c 25 00 00       	call   80104a60 <release>

  release(&idelock);
}
801024e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024e7:	5b                   	pop    %ebx
801024e8:	5e                   	pop    %esi
801024e9:	5f                   	pop    %edi
801024ea:	5d                   	pop    %ebp
801024eb:	c3                   	ret    
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	53                   	push   %ebx
801024f4:	83 ec 10             	sub    $0x10,%esp
801024f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801024fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801024fd:	50                   	push   %eax
801024fe:	e8 0d 23 00 00       	call   80104810 <holdingsleep>
80102503:	83 c4 10             	add    $0x10,%esp
80102506:	85 c0                	test   %eax,%eax
80102508:	0f 84 c6 00 00 00    	je     801025d4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010250e:	8b 03                	mov    (%ebx),%eax
80102510:	83 e0 06             	and    $0x6,%eax
80102513:	83 f8 02             	cmp    $0x2,%eax
80102516:	0f 84 ab 00 00 00    	je     801025c7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010251c:	8b 53 04             	mov    0x4(%ebx),%edx
8010251f:	85 d2                	test   %edx,%edx
80102521:	74 0d                	je     80102530 <iderw+0x40>
80102523:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102528:	85 c0                	test   %eax,%eax
8010252a:	0f 84 b1 00 00 00    	je     801025e1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102530:	83 ec 0c             	sub    $0xc,%esp
80102533:	68 80 b5 10 80       	push   $0x8010b580
80102538:	e8 63 24 00 00       	call   801049a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010253d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
80102543:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102546:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010254d:	85 d2                	test   %edx,%edx
8010254f:	75 09                	jne    8010255a <iderw+0x6a>
80102551:	eb 6d                	jmp    801025c0 <iderw+0xd0>
80102553:	90                   	nop
80102554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102558:	89 c2                	mov    %eax,%edx
8010255a:	8b 42 58             	mov    0x58(%edx),%eax
8010255d:	85 c0                	test   %eax,%eax
8010255f:	75 f7                	jne    80102558 <iderw+0x68>
80102561:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102564:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102566:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
8010256c:	74 42                	je     801025b0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010256e:	8b 03                	mov    (%ebx),%eax
80102570:	83 e0 06             	and    $0x6,%eax
80102573:	83 f8 02             	cmp    $0x2,%eax
80102576:	74 23                	je     8010259b <iderw+0xab>
80102578:	90                   	nop
80102579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102580:	83 ec 08             	sub    $0x8,%esp
80102583:	68 80 b5 10 80       	push   $0x8010b580
80102588:	53                   	push   %ebx
80102589:	e8 42 1d 00 00       	call   801042d0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010258e:	8b 03                	mov    (%ebx),%eax
80102590:	83 c4 10             	add    $0x10,%esp
80102593:	83 e0 06             	and    $0x6,%eax
80102596:	83 f8 02             	cmp    $0x2,%eax
80102599:	75 e5                	jne    80102580 <iderw+0x90>
  }


  release(&idelock);
8010259b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801025a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025a5:	c9                   	leave  
  release(&idelock);
801025a6:	e9 b5 24 00 00       	jmp    80104a60 <release>
801025ab:	90                   	nop
801025ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801025b0:	89 d8                	mov    %ebx,%eax
801025b2:	e8 39 fd ff ff       	call   801022f0 <idestart>
801025b7:	eb b5                	jmp    8010256e <iderw+0x7e>
801025b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801025c0:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801025c5:	eb 9d                	jmp    80102564 <iderw+0x74>
    panic("iderw: nothing to do");
801025c7:	83 ec 0c             	sub    $0xc,%esp
801025ca:	68 44 7f 10 80       	push   $0x80107f44
801025cf:	e8 bc dd ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801025d4:	83 ec 0c             	sub    $0xc,%esp
801025d7:	68 2e 7f 10 80       	push   $0x80107f2e
801025dc:	e8 af dd ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801025e1:	83 ec 0c             	sub    $0xc,%esp
801025e4:	68 59 7f 10 80       	push   $0x80107f59
801025e9:	e8 a2 dd ff ff       	call   80100390 <panic>
801025ee:	66 90                	xchg   %ax,%ax

801025f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801025f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801025f1:	c7 05 74 56 11 80 00 	movl   $0xfec00000,0x80115674
801025f8:	00 c0 fe 
{
801025fb:	89 e5                	mov    %esp,%ebp
801025fd:	56                   	push   %esi
801025fe:	53                   	push   %ebx
  ioapic->reg = reg;
801025ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102606:	00 00 00 
  return ioapic->data;
80102609:	a1 74 56 11 80       	mov    0x80115674,%eax
8010260e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102611:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102617:	8b 0d 74 56 11 80    	mov    0x80115674,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010261d:	0f b6 15 a0 57 11 80 	movzbl 0x801157a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102624:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102627:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010262a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010262d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102630:	39 c2                	cmp    %eax,%edx
80102632:	74 16                	je     8010264a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102634:	83 ec 0c             	sub    $0xc,%esp
80102637:	68 78 7f 10 80       	push   $0x80107f78
8010263c:	e8 1f e0 ff ff       	call   80100660 <cprintf>
80102641:	8b 0d 74 56 11 80    	mov    0x80115674,%ecx
80102647:	83 c4 10             	add    $0x10,%esp
8010264a:	83 c3 21             	add    $0x21,%ebx
{
8010264d:	ba 10 00 00 00       	mov    $0x10,%edx
80102652:	b8 20 00 00 00       	mov    $0x20,%eax
80102657:	89 f6                	mov    %esi,%esi
80102659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102660:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102662:	8b 0d 74 56 11 80    	mov    0x80115674,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102668:	89 c6                	mov    %eax,%esi
8010266a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102670:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102673:	89 71 10             	mov    %esi,0x10(%ecx)
80102676:	8d 72 01             	lea    0x1(%edx),%esi
80102679:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010267c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010267e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102680:	8b 0d 74 56 11 80    	mov    0x80115674,%ecx
80102686:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010268d:	75 d1                	jne    80102660 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010268f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102692:	5b                   	pop    %ebx
80102693:	5e                   	pop    %esi
80102694:	5d                   	pop    %ebp
80102695:	c3                   	ret    
80102696:	8d 76 00             	lea    0x0(%esi),%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801026a0:	55                   	push   %ebp
  ioapic->reg = reg;
801026a1:	8b 0d 74 56 11 80    	mov    0x80115674,%ecx
{
801026a7:	89 e5                	mov    %esp,%ebp
801026a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801026ac:	8d 50 20             	lea    0x20(%eax),%edx
801026af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801026b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801026b5:	8b 0d 74 56 11 80    	mov    0x80115674,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801026be:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801026c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801026c6:	a1 74 56 11 80       	mov    0x80115674,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026cb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801026ce:	89 50 10             	mov    %edx,0x10(%eax)
}
801026d1:	5d                   	pop    %ebp
801026d2:	c3                   	ret    
801026d3:	66 90                	xchg   %ax,%ax
801026d5:	66 90                	xchg   %ax,%ax
801026d7:	66 90                	xchg   %ax,%ax
801026d9:	66 90                	xchg   %ax,%ax
801026db:	66 90                	xchg   %ax,%ax
801026dd:	66 90                	xchg   %ax,%ax
801026df:	90                   	nop

801026e0 <get_first_run>:
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
} kmem;

struct run* get_first_run(){
801026e0:	55                   	push   %ebp
  return kmem.freelist;
}
801026e1:	a1 b8 56 11 80       	mov    0x801156b8,%eax
struct run* get_first_run(){
801026e6:	89 e5                	mov    %esp,%ebp
}
801026e8:	5d                   	pop    %ebp
801026e9:	c3                   	ret    
801026ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801026f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	53                   	push   %ebx
801026f4:	83 ec 04             	sub    $0x4,%esp
801026f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801026fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102700:	75 70                	jne    80102772 <kfree+0x82>
80102702:	81 fb e8 07 12 80    	cmp    $0x801207e8,%ebx
80102708:	72 68                	jb     80102772 <kfree+0x82>
8010270a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102710:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102715:	77 5b                	ja     80102772 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102717:	83 ec 04             	sub    $0x4,%esp
8010271a:	68 00 10 00 00       	push   $0x1000
8010271f:	6a 01                	push   $0x1
80102721:	53                   	push   %ebx
80102722:	e8 89 23 00 00       	call   80104ab0 <memset>

  if(kmem.use_lock)
80102727:	8b 15 b4 56 11 80    	mov    0x801156b4,%edx
8010272d:	83 c4 10             	add    $0x10,%esp
80102730:	85 d2                	test   %edx,%edx
80102732:	75 2c                	jne    80102760 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102734:	a1 b8 56 11 80       	mov    0x801156b8,%eax
80102739:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010273b:	a1 b4 56 11 80       	mov    0x801156b4,%eax
  kmem.freelist = r;
80102740:	89 1d b8 56 11 80    	mov    %ebx,0x801156b8
  if(kmem.use_lock)
80102746:	85 c0                	test   %eax,%eax
80102748:	75 06                	jne    80102750 <kfree+0x60>
    release(&kmem.lock);
}
8010274a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010274d:	c9                   	leave  
8010274e:	c3                   	ret    
8010274f:	90                   	nop
    release(&kmem.lock);
80102750:	c7 45 08 80 56 11 80 	movl   $0x80115680,0x8(%ebp)
}
80102757:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010275a:	c9                   	leave  
    release(&kmem.lock);
8010275b:	e9 00 23 00 00       	jmp    80104a60 <release>
    acquire(&kmem.lock);
80102760:	83 ec 0c             	sub    $0xc,%esp
80102763:	68 80 56 11 80       	push   $0x80115680
80102768:	e8 33 22 00 00       	call   801049a0 <acquire>
8010276d:	83 c4 10             	add    $0x10,%esp
80102770:	eb c2                	jmp    80102734 <kfree+0x44>
    panic("kfree");
80102772:	83 ec 0c             	sub    $0xc,%esp
80102775:	68 aa 7f 10 80       	push   $0x80107faa
8010277a:	e8 11 dc ff ff       	call   80100390 <panic>
8010277f:	90                   	nop

80102780 <freerange>:
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	56                   	push   %esi
80102784:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102785:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102788:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010278b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102791:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102797:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010279d:	39 de                	cmp    %ebx,%esi
8010279f:	72 23                	jb     801027c4 <freerange+0x44>
801027a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801027a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801027ae:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027b7:	50                   	push   %eax
801027b8:	e8 33 ff ff ff       	call   801026f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027bd:	83 c4 10             	add    $0x10,%esp
801027c0:	39 f3                	cmp    %esi,%ebx
801027c2:	76 e4                	jbe    801027a8 <freerange+0x28>
}
801027c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027c7:	5b                   	pop    %ebx
801027c8:	5e                   	pop    %esi
801027c9:	5d                   	pop    %ebp
801027ca:	c3                   	ret    
801027cb:	90                   	nop
801027cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027d0 <kinit1>:
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	56                   	push   %esi
801027d4:	53                   	push   %ebx
801027d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801027d8:	83 ec 08             	sub    $0x8,%esp
801027db:	68 b0 7f 10 80       	push   $0x80107fb0
801027e0:	68 80 56 11 80       	push   $0x80115680
801027e5:	e8 76 20 00 00       	call   80104860 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801027ea:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027ed:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801027f0:	c7 05 b4 56 11 80 00 	movl   $0x0,0x801156b4
801027f7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801027fa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102800:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102806:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010280c:	39 de                	cmp    %ebx,%esi
8010280e:	72 1c                	jb     8010282c <kinit1+0x5c>
    kfree(p);
80102810:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102816:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102819:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010281f:	50                   	push   %eax
80102820:	e8 cb fe ff ff       	call   801026f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102825:	83 c4 10             	add    $0x10,%esp
80102828:	39 de                	cmp    %ebx,%esi
8010282a:	73 e4                	jae    80102810 <kinit1+0x40>
}
8010282c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010282f:	5b                   	pop    %ebx
80102830:	5e                   	pop    %esi
80102831:	5d                   	pop    %ebp
80102832:	c3                   	ret    
80102833:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102840 <kinit2>:
{
80102840:	55                   	push   %ebp
80102841:	89 e5                	mov    %esp,%ebp
80102843:	56                   	push   %esi
80102844:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102845:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102848:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010284b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102851:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102857:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010285d:	39 de                	cmp    %ebx,%esi
8010285f:	72 23                	jb     80102884 <kinit2+0x44>
80102861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102868:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010286e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102871:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102877:	50                   	push   %eax
80102878:	e8 73 fe ff ff       	call   801026f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010287d:	83 c4 10             	add    $0x10,%esp
80102880:	39 de                	cmp    %ebx,%esi
80102882:	73 e4                	jae    80102868 <kinit2+0x28>
  kmem.use_lock = 1;
80102884:	c7 05 b4 56 11 80 01 	movl   $0x1,0x801156b4
8010288b:	00 00 00 
}
8010288e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102891:	5b                   	pop    %ebx
80102892:	5e                   	pop    %esi
80102893:	5d                   	pop    %ebp
80102894:	c3                   	ret    
80102895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028a0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801028a0:	a1 b4 56 11 80       	mov    0x801156b4,%eax
801028a5:	85 c0                	test   %eax,%eax
801028a7:	75 1f                	jne    801028c8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801028a9:	a1 b8 56 11 80       	mov    0x801156b8,%eax
  if(r)
801028ae:	85 c0                	test   %eax,%eax
801028b0:	74 0e                	je     801028c0 <kalloc+0x20>
    kmem.freelist = r->next;
801028b2:	8b 10                	mov    (%eax),%edx
801028b4:	89 15 b8 56 11 80    	mov    %edx,0x801156b8
801028ba:	c3                   	ret    
801028bb:	90                   	nop
801028bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801028c0:	f3 c3                	repz ret 
801028c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801028c8:	55                   	push   %ebp
801028c9:	89 e5                	mov    %esp,%ebp
801028cb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801028ce:	68 80 56 11 80       	push   $0x80115680
801028d3:	e8 c8 20 00 00       	call   801049a0 <acquire>
  r = kmem.freelist;
801028d8:	a1 b8 56 11 80       	mov    0x801156b8,%eax
  if(r)
801028dd:	83 c4 10             	add    $0x10,%esp
801028e0:	8b 15 b4 56 11 80    	mov    0x801156b4,%edx
801028e6:	85 c0                	test   %eax,%eax
801028e8:	74 08                	je     801028f2 <kalloc+0x52>
    kmem.freelist = r->next;
801028ea:	8b 08                	mov    (%eax),%ecx
801028ec:	89 0d b8 56 11 80    	mov    %ecx,0x801156b8
  if(kmem.use_lock)
801028f2:	85 d2                	test   %edx,%edx
801028f4:	74 16                	je     8010290c <kalloc+0x6c>
    release(&kmem.lock);
801028f6:	83 ec 0c             	sub    $0xc,%esp
801028f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028fc:	68 80 56 11 80       	push   $0x80115680
80102901:	e8 5a 21 00 00       	call   80104a60 <release>
  return (char*)r;
80102906:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102909:	83 c4 10             	add    $0x10,%esp
}
8010290c:	c9                   	leave  
8010290d:	c3                   	ret    
8010290e:	66 90                	xchg   %ax,%ax

80102910 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102910:	ba 64 00 00 00       	mov    $0x64,%edx
80102915:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102916:	a8 01                	test   $0x1,%al
80102918:	0f 84 c2 00 00 00    	je     801029e0 <kbdgetc+0xd0>
8010291e:	ba 60 00 00 00       	mov    $0x60,%edx
80102923:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102924:	0f b6 d0             	movzbl %al,%edx
80102927:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
8010292d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102933:	0f 84 7f 00 00 00    	je     801029b8 <kbdgetc+0xa8>
{
80102939:	55                   	push   %ebp
8010293a:	89 e5                	mov    %esp,%ebp
8010293c:	53                   	push   %ebx
8010293d:	89 cb                	mov    %ecx,%ebx
8010293f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102942:	84 c0                	test   %al,%al
80102944:	78 4a                	js     80102990 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102946:	85 db                	test   %ebx,%ebx
80102948:	74 09                	je     80102953 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010294a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010294d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102950:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102953:	0f b6 82 e0 80 10 80 	movzbl -0x7fef7f20(%edx),%eax
8010295a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010295c:	0f b6 82 e0 7f 10 80 	movzbl -0x7fef8020(%edx),%eax
80102963:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102965:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102967:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010296d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102970:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102973:	8b 04 85 c0 7f 10 80 	mov    -0x7fef8040(,%eax,4),%eax
8010297a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010297e:	74 31                	je     801029b1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102980:	8d 50 9f             	lea    -0x61(%eax),%edx
80102983:	83 fa 19             	cmp    $0x19,%edx
80102986:	77 40                	ja     801029c8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102988:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010298b:	5b                   	pop    %ebx
8010298c:	5d                   	pop    %ebp
8010298d:	c3                   	ret    
8010298e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102990:	83 e0 7f             	and    $0x7f,%eax
80102993:	85 db                	test   %ebx,%ebx
80102995:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102998:	0f b6 82 e0 80 10 80 	movzbl -0x7fef7f20(%edx),%eax
8010299f:	83 c8 40             	or     $0x40,%eax
801029a2:	0f b6 c0             	movzbl %al,%eax
801029a5:	f7 d0                	not    %eax
801029a7:	21 c1                	and    %eax,%ecx
    return 0;
801029a9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801029ab:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
801029b1:	5b                   	pop    %ebx
801029b2:	5d                   	pop    %ebp
801029b3:	c3                   	ret    
801029b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801029b8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801029bb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801029bd:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
801029c3:	c3                   	ret    
801029c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801029c8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801029cb:	8d 50 20             	lea    0x20(%eax),%edx
}
801029ce:	5b                   	pop    %ebx
      c += 'a' - 'A';
801029cf:	83 f9 1a             	cmp    $0x1a,%ecx
801029d2:	0f 42 c2             	cmovb  %edx,%eax
}
801029d5:	5d                   	pop    %ebp
801029d6:	c3                   	ret    
801029d7:	89 f6                	mov    %esi,%esi
801029d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801029e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801029e5:	c3                   	ret    
801029e6:	8d 76 00             	lea    0x0(%esi),%esi
801029e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801029f0 <kbdintr>:

void
kbdintr(void)
{
801029f0:	55                   	push   %ebp
801029f1:	89 e5                	mov    %esp,%ebp
801029f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801029f6:	68 10 29 10 80       	push   $0x80102910
801029fb:	e8 10 de ff ff       	call   80100810 <consoleintr>
}
80102a00:	83 c4 10             	add    $0x10,%esp
80102a03:	c9                   	leave  
80102a04:	c3                   	ret    
80102a05:	66 90                	xchg   %ax,%ax
80102a07:	66 90                	xchg   %ax,%ax
80102a09:	66 90                	xchg   %ax,%ax
80102a0b:	66 90                	xchg   %ax,%ax
80102a0d:	66 90                	xchg   %ax,%ax
80102a0f:	90                   	nop

80102a10 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102a10:	a1 bc 56 11 80       	mov    0x801156bc,%eax
{
80102a15:	55                   	push   %ebp
80102a16:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102a18:	85 c0                	test   %eax,%eax
80102a1a:	0f 84 c8 00 00 00    	je     80102ae8 <lapicinit+0xd8>
  lapic[index] = value;
80102a20:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102a27:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a2a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a2d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102a34:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a37:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a3a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102a41:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102a44:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a47:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102a4e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102a51:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a54:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102a5b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a5e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a61:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a68:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a6b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a6e:	8b 50 30             	mov    0x30(%eax),%edx
80102a71:	c1 ea 10             	shr    $0x10,%edx
80102a74:	80 fa 03             	cmp    $0x3,%dl
80102a77:	77 77                	ja     80102af0 <lapicinit+0xe0>
  lapic[index] = value;
80102a79:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a80:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a83:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a86:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a8d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a90:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a93:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a9a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a9d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aa0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102aa7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aaa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aad:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102ab4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aba:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102ac1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102ac4:	8b 50 20             	mov    0x20(%eax),%edx
80102ac7:	89 f6                	mov    %esi,%esi
80102ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102ad0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102ad6:	80 e6 10             	and    $0x10,%dh
80102ad9:	75 f5                	jne    80102ad0 <lapicinit+0xc0>
  lapic[index] = value;
80102adb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102ae2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ae5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102ae8:	5d                   	pop    %ebp
80102ae9:	c3                   	ret    
80102aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102af0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102af7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102afa:	8b 50 20             	mov    0x20(%eax),%edx
80102afd:	e9 77 ff ff ff       	jmp    80102a79 <lapicinit+0x69>
80102b02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b10 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102b10:	8b 15 bc 56 11 80    	mov    0x801156bc,%edx
{
80102b16:	55                   	push   %ebp
80102b17:	31 c0                	xor    %eax,%eax
80102b19:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102b1b:	85 d2                	test   %edx,%edx
80102b1d:	74 06                	je     80102b25 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102b1f:	8b 42 20             	mov    0x20(%edx),%eax
80102b22:	c1 e8 18             	shr    $0x18,%eax
}
80102b25:	5d                   	pop    %ebp
80102b26:	c3                   	ret    
80102b27:	89 f6                	mov    %esi,%esi
80102b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b30 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102b30:	a1 bc 56 11 80       	mov    0x801156bc,%eax
{
80102b35:	55                   	push   %ebp
80102b36:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102b38:	85 c0                	test   %eax,%eax
80102b3a:	74 0d                	je     80102b49 <lapiceoi+0x19>
  lapic[index] = value;
80102b3c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b43:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b46:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102b49:	5d                   	pop    %ebp
80102b4a:	c3                   	ret    
80102b4b:	90                   	nop
80102b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b50 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
}
80102b53:	5d                   	pop    %ebp
80102b54:	c3                   	ret    
80102b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b60 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b60:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b61:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b66:	ba 70 00 00 00       	mov    $0x70,%edx
80102b6b:	89 e5                	mov    %esp,%ebp
80102b6d:	53                   	push   %ebx
80102b6e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b71:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b74:	ee                   	out    %al,(%dx)
80102b75:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b7a:	ba 71 00 00 00       	mov    $0x71,%edx
80102b7f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b80:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102b82:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102b85:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b8b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b8d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102b90:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102b93:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b95:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b98:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b9e:	a1 bc 56 11 80       	mov    0x801156bc,%eax
80102ba3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ba9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bac:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102bb3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bb6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bb9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102bc0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bc3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bc6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bcc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bcf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bd5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bd8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bde:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102be1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102be7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102bea:	5b                   	pop    %ebx
80102beb:	5d                   	pop    %ebp
80102bec:	c3                   	ret    
80102bed:	8d 76 00             	lea    0x0(%esi),%esi

80102bf0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102bf0:	55                   	push   %ebp
80102bf1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102bf6:	ba 70 00 00 00       	mov    $0x70,%edx
80102bfb:	89 e5                	mov    %esp,%ebp
80102bfd:	57                   	push   %edi
80102bfe:	56                   	push   %esi
80102bff:	53                   	push   %ebx
80102c00:	83 ec 4c             	sub    $0x4c,%esp
80102c03:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c04:	ba 71 00 00 00       	mov    $0x71,%edx
80102c09:	ec                   	in     (%dx),%al
80102c0a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c0d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102c12:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102c15:	8d 76 00             	lea    0x0(%esi),%esi
80102c18:	31 c0                	xor    %eax,%eax
80102c1a:	89 da                	mov    %ebx,%edx
80102c1c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c1d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102c22:	89 ca                	mov    %ecx,%edx
80102c24:	ec                   	in     (%dx),%al
80102c25:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c28:	89 da                	mov    %ebx,%edx
80102c2a:	b8 02 00 00 00       	mov    $0x2,%eax
80102c2f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c30:	89 ca                	mov    %ecx,%edx
80102c32:	ec                   	in     (%dx),%al
80102c33:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c36:	89 da                	mov    %ebx,%edx
80102c38:	b8 04 00 00 00       	mov    $0x4,%eax
80102c3d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c3e:	89 ca                	mov    %ecx,%edx
80102c40:	ec                   	in     (%dx),%al
80102c41:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c44:	89 da                	mov    %ebx,%edx
80102c46:	b8 07 00 00 00       	mov    $0x7,%eax
80102c4b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4c:	89 ca                	mov    %ecx,%edx
80102c4e:	ec                   	in     (%dx),%al
80102c4f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c52:	89 da                	mov    %ebx,%edx
80102c54:	b8 08 00 00 00       	mov    $0x8,%eax
80102c59:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5a:	89 ca                	mov    %ecx,%edx
80102c5c:	ec                   	in     (%dx),%al
80102c5d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c5f:	89 da                	mov    %ebx,%edx
80102c61:	b8 09 00 00 00       	mov    $0x9,%eax
80102c66:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c67:	89 ca                	mov    %ecx,%edx
80102c69:	ec                   	in     (%dx),%al
80102c6a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c6c:	89 da                	mov    %ebx,%edx
80102c6e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c73:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c74:	89 ca                	mov    %ecx,%edx
80102c76:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c77:	84 c0                	test   %al,%al
80102c79:	78 9d                	js     80102c18 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102c7b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102c7f:	89 fa                	mov    %edi,%edx
80102c81:	0f b6 fa             	movzbl %dl,%edi
80102c84:	89 f2                	mov    %esi,%edx
80102c86:	0f b6 f2             	movzbl %dl,%esi
80102c89:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c8c:	89 da                	mov    %ebx,%edx
80102c8e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102c91:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c94:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102c98:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102c9b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102c9f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ca2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102ca6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102ca9:	31 c0                	xor    %eax,%eax
80102cab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cac:	89 ca                	mov    %ecx,%edx
80102cae:	ec                   	in     (%dx),%al
80102caf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cb2:	89 da                	mov    %ebx,%edx
80102cb4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102cb7:	b8 02 00 00 00       	mov    $0x2,%eax
80102cbc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cbd:	89 ca                	mov    %ecx,%edx
80102cbf:	ec                   	in     (%dx),%al
80102cc0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cc3:	89 da                	mov    %ebx,%edx
80102cc5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102cc8:	b8 04 00 00 00       	mov    $0x4,%eax
80102ccd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cce:	89 ca                	mov    %ecx,%edx
80102cd0:	ec                   	in     (%dx),%al
80102cd1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cd4:	89 da                	mov    %ebx,%edx
80102cd6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102cd9:	b8 07 00 00 00       	mov    $0x7,%eax
80102cde:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cdf:	89 ca                	mov    %ecx,%edx
80102ce1:	ec                   	in     (%dx),%al
80102ce2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ce5:	89 da                	mov    %ebx,%edx
80102ce7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102cea:	b8 08 00 00 00       	mov    $0x8,%eax
80102cef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cf0:	89 ca                	mov    %ecx,%edx
80102cf2:	ec                   	in     (%dx),%al
80102cf3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cf6:	89 da                	mov    %ebx,%edx
80102cf8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102cfb:	b8 09 00 00 00       	mov    $0x9,%eax
80102d00:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d01:	89 ca                	mov    %ecx,%edx
80102d03:	ec                   	in     (%dx),%al
80102d04:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d07:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102d0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d0d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102d10:	6a 18                	push   $0x18
80102d12:	50                   	push   %eax
80102d13:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102d16:	50                   	push   %eax
80102d17:	e8 e4 1d 00 00       	call   80104b00 <memcmp>
80102d1c:	83 c4 10             	add    $0x10,%esp
80102d1f:	85 c0                	test   %eax,%eax
80102d21:	0f 85 f1 fe ff ff    	jne    80102c18 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102d27:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102d2b:	75 78                	jne    80102da5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102d2d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d30:	89 c2                	mov    %eax,%edx
80102d32:	83 e0 0f             	and    $0xf,%eax
80102d35:	c1 ea 04             	shr    $0x4,%edx
80102d38:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d3b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d3e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102d41:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d44:	89 c2                	mov    %eax,%edx
80102d46:	83 e0 0f             	and    $0xf,%eax
80102d49:	c1 ea 04             	shr    $0x4,%edx
80102d4c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d4f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d52:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102d55:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d58:	89 c2                	mov    %eax,%edx
80102d5a:	83 e0 0f             	and    $0xf,%eax
80102d5d:	c1 ea 04             	shr    $0x4,%edx
80102d60:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d63:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d66:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d69:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d6c:	89 c2                	mov    %eax,%edx
80102d6e:	83 e0 0f             	and    $0xf,%eax
80102d71:	c1 ea 04             	shr    $0x4,%edx
80102d74:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d77:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d7a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d7d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d80:	89 c2                	mov    %eax,%edx
80102d82:	83 e0 0f             	and    $0xf,%eax
80102d85:	c1 ea 04             	shr    $0x4,%edx
80102d88:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d8b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d8e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d91:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d94:	89 c2                	mov    %eax,%edx
80102d96:	83 e0 0f             	and    $0xf,%eax
80102d99:	c1 ea 04             	shr    $0x4,%edx
80102d9c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d9f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102da2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102da5:	8b 75 08             	mov    0x8(%ebp),%esi
80102da8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102dab:	89 06                	mov    %eax,(%esi)
80102dad:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102db0:	89 46 04             	mov    %eax,0x4(%esi)
80102db3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102db6:	89 46 08             	mov    %eax,0x8(%esi)
80102db9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102dbc:	89 46 0c             	mov    %eax,0xc(%esi)
80102dbf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102dc2:	89 46 10             	mov    %eax,0x10(%esi)
80102dc5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102dc8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102dcb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102dd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dd5:	5b                   	pop    %ebx
80102dd6:	5e                   	pop    %esi
80102dd7:	5f                   	pop    %edi
80102dd8:	5d                   	pop    %ebp
80102dd9:	c3                   	ret    
80102dda:	66 90                	xchg   %ax,%ax
80102ddc:	66 90                	xchg   %ax,%ax
80102dde:	66 90                	xchg   %ax,%ax

80102de0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102de0:	8b 0d 08 57 11 80    	mov    0x80115708,%ecx
80102de6:	85 c9                	test   %ecx,%ecx
80102de8:	0f 8e 8a 00 00 00    	jle    80102e78 <install_trans+0x98>
{
80102dee:	55                   	push   %ebp
80102def:	89 e5                	mov    %esp,%ebp
80102df1:	57                   	push   %edi
80102df2:	56                   	push   %esi
80102df3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102df4:	31 db                	xor    %ebx,%ebx
{
80102df6:	83 ec 0c             	sub    $0xc,%esp
80102df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102e00:	a1 f4 56 11 80       	mov    0x801156f4,%eax
80102e05:	83 ec 08             	sub    $0x8,%esp
80102e08:	01 d8                	add    %ebx,%eax
80102e0a:	83 c0 01             	add    $0x1,%eax
80102e0d:	50                   	push   %eax
80102e0e:	ff 35 04 57 11 80    	pushl  0x80115704
80102e14:	e8 b7 d2 ff ff       	call   801000d0 <bread>
80102e19:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e1b:	58                   	pop    %eax
80102e1c:	5a                   	pop    %edx
80102e1d:	ff 34 9d 0c 57 11 80 	pushl  -0x7feea8f4(,%ebx,4)
80102e24:	ff 35 04 57 11 80    	pushl  0x80115704
  for (tail = 0; tail < log.lh.n; tail++) {
80102e2a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e2d:	e8 9e d2 ff ff       	call   801000d0 <bread>
80102e32:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e34:	8d 47 5c             	lea    0x5c(%edi),%eax
80102e37:	83 c4 0c             	add    $0xc,%esp
80102e3a:	68 00 02 00 00       	push   $0x200
80102e3f:	50                   	push   %eax
80102e40:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e43:	50                   	push   %eax
80102e44:	e8 17 1d 00 00       	call   80104b60 <memmove>
    bwrite(dbuf);  // write dst to disk
80102e49:	89 34 24             	mov    %esi,(%esp)
80102e4c:	e8 4f d3 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102e51:	89 3c 24             	mov    %edi,(%esp)
80102e54:	e8 87 d3 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102e59:	89 34 24             	mov    %esi,(%esp)
80102e5c:	e8 7f d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e61:	83 c4 10             	add    $0x10,%esp
80102e64:	39 1d 08 57 11 80    	cmp    %ebx,0x80115708
80102e6a:	7f 94                	jg     80102e00 <install_trans+0x20>
  }
}
80102e6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e6f:	5b                   	pop    %ebx
80102e70:	5e                   	pop    %esi
80102e71:	5f                   	pop    %edi
80102e72:	5d                   	pop    %ebp
80102e73:	c3                   	ret    
80102e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e78:	f3 c3                	repz ret 
80102e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	56                   	push   %esi
80102e84:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102e85:	83 ec 08             	sub    $0x8,%esp
80102e88:	ff 35 f4 56 11 80    	pushl  0x801156f4
80102e8e:	ff 35 04 57 11 80    	pushl  0x80115704
80102e94:	e8 37 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102e99:	8b 1d 08 57 11 80    	mov    0x80115708,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102e9f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ea2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ea4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ea6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ea9:	7e 16                	jle    80102ec1 <write_head+0x41>
80102eab:	c1 e3 02             	shl    $0x2,%ebx
80102eae:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102eb0:	8b 8a 0c 57 11 80    	mov    -0x7feea8f4(%edx),%ecx
80102eb6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102eba:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102ebd:	39 da                	cmp    %ebx,%edx
80102ebf:	75 ef                	jne    80102eb0 <write_head+0x30>
  }
  bwrite(buf);
80102ec1:	83 ec 0c             	sub    $0xc,%esp
80102ec4:	56                   	push   %esi
80102ec5:	e8 d6 d2 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102eca:	89 34 24             	mov    %esi,(%esp)
80102ecd:	e8 0e d3 ff ff       	call   801001e0 <brelse>
}
80102ed2:	83 c4 10             	add    $0x10,%esp
80102ed5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ed8:	5b                   	pop    %ebx
80102ed9:	5e                   	pop    %esi
80102eda:	5d                   	pop    %ebp
80102edb:	c3                   	ret    
80102edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ee0 <initlog>:
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	53                   	push   %ebx
80102ee4:	83 ec 2c             	sub    $0x2c,%esp
80102ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102eea:	68 e0 81 10 80       	push   $0x801081e0
80102eef:	68 c0 56 11 80       	push   $0x801156c0
80102ef4:	e8 67 19 00 00       	call   80104860 <initlock>
  readsb(dev, &sb);
80102ef9:	58                   	pop    %eax
80102efa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102efd:	5a                   	pop    %edx
80102efe:	50                   	push   %eax
80102eff:	53                   	push   %ebx
80102f00:	e8 7b e5 ff ff       	call   80101480 <readsb>
  log.size = sb.nlog;
80102f05:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102f08:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102f0b:	59                   	pop    %ecx
  log.dev = dev;
80102f0c:	89 1d 04 57 11 80    	mov    %ebx,0x80115704
  log.size = sb.nlog;
80102f12:	89 15 f8 56 11 80    	mov    %edx,0x801156f8
  log.start = sb.logstart;
80102f18:	a3 f4 56 11 80       	mov    %eax,0x801156f4
  struct buf *buf = bread(log.dev, log.start);
80102f1d:	5a                   	pop    %edx
80102f1e:	50                   	push   %eax
80102f1f:	53                   	push   %ebx
80102f20:	e8 ab d1 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102f25:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102f28:	83 c4 10             	add    $0x10,%esp
80102f2b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102f2d:	89 1d 08 57 11 80    	mov    %ebx,0x80115708
  for (i = 0; i < log.lh.n; i++) {
80102f33:	7e 1c                	jle    80102f51 <initlog+0x71>
80102f35:	c1 e3 02             	shl    $0x2,%ebx
80102f38:	31 d2                	xor    %edx,%edx
80102f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102f40:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102f44:	83 c2 04             	add    $0x4,%edx
80102f47:	89 8a 08 57 11 80    	mov    %ecx,-0x7feea8f8(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102f4d:	39 d3                	cmp    %edx,%ebx
80102f4f:	75 ef                	jne    80102f40 <initlog+0x60>
  brelse(buf);
80102f51:	83 ec 0c             	sub    $0xc,%esp
80102f54:	50                   	push   %eax
80102f55:	e8 86 d2 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102f5a:	e8 81 fe ff ff       	call   80102de0 <install_trans>
  log.lh.n = 0;
80102f5f:	c7 05 08 57 11 80 00 	movl   $0x0,0x80115708
80102f66:	00 00 00 
  write_head(); // clear the log
80102f69:	e8 12 ff ff ff       	call   80102e80 <write_head>
}
80102f6e:	83 c4 10             	add    $0x10,%esp
80102f71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f74:	c9                   	leave  
80102f75:	c3                   	ret    
80102f76:	8d 76 00             	lea    0x0(%esi),%esi
80102f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f80:	55                   	push   %ebp
80102f81:	89 e5                	mov    %esp,%ebp
80102f83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f86:	68 c0 56 11 80       	push   $0x801156c0
80102f8b:	e8 10 1a 00 00       	call   801049a0 <acquire>
80102f90:	83 c4 10             	add    $0x10,%esp
80102f93:	eb 18                	jmp    80102fad <begin_op+0x2d>
80102f95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f98:	83 ec 08             	sub    $0x8,%esp
80102f9b:	68 c0 56 11 80       	push   $0x801156c0
80102fa0:	68 c0 56 11 80       	push   $0x801156c0
80102fa5:	e8 26 13 00 00       	call   801042d0 <sleep>
80102faa:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102fad:	a1 00 57 11 80       	mov    0x80115700,%eax
80102fb2:	85 c0                	test   %eax,%eax
80102fb4:	75 e2                	jne    80102f98 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102fb6:	a1 fc 56 11 80       	mov    0x801156fc,%eax
80102fbb:	8b 15 08 57 11 80    	mov    0x80115708,%edx
80102fc1:	83 c0 01             	add    $0x1,%eax
80102fc4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102fc7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102fca:	83 fa 1e             	cmp    $0x1e,%edx
80102fcd:	7f c9                	jg     80102f98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102fcf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102fd2:	a3 fc 56 11 80       	mov    %eax,0x801156fc
      release(&log.lock);
80102fd7:	68 c0 56 11 80       	push   $0x801156c0
80102fdc:	e8 7f 1a 00 00       	call   80104a60 <release>
      break;
    }
  }
}
80102fe1:	83 c4 10             	add    $0x10,%esp
80102fe4:	c9                   	leave  
80102fe5:	c3                   	ret    
80102fe6:	8d 76 00             	lea    0x0(%esi),%esi
80102fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ff0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	57                   	push   %edi
80102ff4:	56                   	push   %esi
80102ff5:	53                   	push   %ebx
80102ff6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ff9:	68 c0 56 11 80       	push   $0x801156c0
80102ffe:	e8 9d 19 00 00       	call   801049a0 <acquire>
  log.outstanding -= 1;
80103003:	a1 fc 56 11 80       	mov    0x801156fc,%eax
  if(log.committing)
80103008:	8b 35 00 57 11 80    	mov    0x80115700,%esi
8010300e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103011:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103014:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103016:	89 1d fc 56 11 80    	mov    %ebx,0x801156fc
  if(log.committing)
8010301c:	0f 85 1a 01 00 00    	jne    8010313c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103022:	85 db                	test   %ebx,%ebx
80103024:	0f 85 ee 00 00 00    	jne    80103118 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010302a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010302d:	c7 05 00 57 11 80 01 	movl   $0x1,0x80115700
80103034:	00 00 00 
  release(&log.lock);
80103037:	68 c0 56 11 80       	push   $0x801156c0
8010303c:	e8 1f 1a 00 00       	call   80104a60 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103041:	8b 0d 08 57 11 80    	mov    0x80115708,%ecx
80103047:	83 c4 10             	add    $0x10,%esp
8010304a:	85 c9                	test   %ecx,%ecx
8010304c:	0f 8e 85 00 00 00    	jle    801030d7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103052:	a1 f4 56 11 80       	mov    0x801156f4,%eax
80103057:	83 ec 08             	sub    $0x8,%esp
8010305a:	01 d8                	add    %ebx,%eax
8010305c:	83 c0 01             	add    $0x1,%eax
8010305f:	50                   	push   %eax
80103060:	ff 35 04 57 11 80    	pushl  0x80115704
80103066:	e8 65 d0 ff ff       	call   801000d0 <bread>
8010306b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010306d:	58                   	pop    %eax
8010306e:	5a                   	pop    %edx
8010306f:	ff 34 9d 0c 57 11 80 	pushl  -0x7feea8f4(,%ebx,4)
80103076:	ff 35 04 57 11 80    	pushl  0x80115704
  for (tail = 0; tail < log.lh.n; tail++) {
8010307c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010307f:	e8 4c d0 ff ff       	call   801000d0 <bread>
80103084:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103086:	8d 40 5c             	lea    0x5c(%eax),%eax
80103089:	83 c4 0c             	add    $0xc,%esp
8010308c:	68 00 02 00 00       	push   $0x200
80103091:	50                   	push   %eax
80103092:	8d 46 5c             	lea    0x5c(%esi),%eax
80103095:	50                   	push   %eax
80103096:	e8 c5 1a 00 00       	call   80104b60 <memmove>
    bwrite(to);  // write the log
8010309b:	89 34 24             	mov    %esi,(%esp)
8010309e:	e8 fd d0 ff ff       	call   801001a0 <bwrite>
    brelse(from);
801030a3:	89 3c 24             	mov    %edi,(%esp)
801030a6:	e8 35 d1 ff ff       	call   801001e0 <brelse>
    brelse(to);
801030ab:	89 34 24             	mov    %esi,(%esp)
801030ae:	e8 2d d1 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801030b3:	83 c4 10             	add    $0x10,%esp
801030b6:	3b 1d 08 57 11 80    	cmp    0x80115708,%ebx
801030bc:	7c 94                	jl     80103052 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801030be:	e8 bd fd ff ff       	call   80102e80 <write_head>
    install_trans(); // Now install writes to home locations
801030c3:	e8 18 fd ff ff       	call   80102de0 <install_trans>
    log.lh.n = 0;
801030c8:	c7 05 08 57 11 80 00 	movl   $0x0,0x80115708
801030cf:	00 00 00 
    write_head();    // Erase the transaction from the log
801030d2:	e8 a9 fd ff ff       	call   80102e80 <write_head>
    acquire(&log.lock);
801030d7:	83 ec 0c             	sub    $0xc,%esp
801030da:	68 c0 56 11 80       	push   $0x801156c0
801030df:	e8 bc 18 00 00       	call   801049a0 <acquire>
    wakeup(&log);
801030e4:	c7 04 24 c0 56 11 80 	movl   $0x801156c0,(%esp)
    log.committing = 0;
801030eb:	c7 05 00 57 11 80 00 	movl   $0x0,0x80115700
801030f2:	00 00 00 
    wakeup(&log);
801030f5:	e8 96 13 00 00       	call   80104490 <wakeup>
    release(&log.lock);
801030fa:	c7 04 24 c0 56 11 80 	movl   $0x801156c0,(%esp)
80103101:	e8 5a 19 00 00       	call   80104a60 <release>
80103106:	83 c4 10             	add    $0x10,%esp
}
80103109:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010310c:	5b                   	pop    %ebx
8010310d:	5e                   	pop    %esi
8010310e:	5f                   	pop    %edi
8010310f:	5d                   	pop    %ebp
80103110:	c3                   	ret    
80103111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103118:	83 ec 0c             	sub    $0xc,%esp
8010311b:	68 c0 56 11 80       	push   $0x801156c0
80103120:	e8 6b 13 00 00       	call   80104490 <wakeup>
  release(&log.lock);
80103125:	c7 04 24 c0 56 11 80 	movl   $0x801156c0,(%esp)
8010312c:	e8 2f 19 00 00       	call   80104a60 <release>
80103131:	83 c4 10             	add    $0x10,%esp
}
80103134:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103137:	5b                   	pop    %ebx
80103138:	5e                   	pop    %esi
80103139:	5f                   	pop    %edi
8010313a:	5d                   	pop    %ebp
8010313b:	c3                   	ret    
    panic("log.committing");
8010313c:	83 ec 0c             	sub    $0xc,%esp
8010313f:	68 e4 81 10 80       	push   $0x801081e4
80103144:	e8 47 d2 ff ff       	call   80100390 <panic>
80103149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103150 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103150:	55                   	push   %ebp
80103151:	89 e5                	mov    %esp,%ebp
80103153:	53                   	push   %ebx
80103154:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103157:	8b 15 08 57 11 80    	mov    0x80115708,%edx
{
8010315d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103160:	83 fa 1d             	cmp    $0x1d,%edx
80103163:	0f 8f 9d 00 00 00    	jg     80103206 <log_write+0xb6>
80103169:	a1 f8 56 11 80       	mov    0x801156f8,%eax
8010316e:	83 e8 01             	sub    $0x1,%eax
80103171:	39 c2                	cmp    %eax,%edx
80103173:	0f 8d 8d 00 00 00    	jge    80103206 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103179:	a1 fc 56 11 80       	mov    0x801156fc,%eax
8010317e:	85 c0                	test   %eax,%eax
80103180:	0f 8e 8d 00 00 00    	jle    80103213 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103186:	83 ec 0c             	sub    $0xc,%esp
80103189:	68 c0 56 11 80       	push   $0x801156c0
8010318e:	e8 0d 18 00 00       	call   801049a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103193:	8b 0d 08 57 11 80    	mov    0x80115708,%ecx
80103199:	83 c4 10             	add    $0x10,%esp
8010319c:	83 f9 00             	cmp    $0x0,%ecx
8010319f:	7e 57                	jle    801031f8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031a1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801031a4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031a6:	3b 15 0c 57 11 80    	cmp    0x8011570c,%edx
801031ac:	75 0b                	jne    801031b9 <log_write+0x69>
801031ae:	eb 38                	jmp    801031e8 <log_write+0x98>
801031b0:	39 14 85 0c 57 11 80 	cmp    %edx,-0x7feea8f4(,%eax,4)
801031b7:	74 2f                	je     801031e8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801031b9:	83 c0 01             	add    $0x1,%eax
801031bc:	39 c1                	cmp    %eax,%ecx
801031be:	75 f0                	jne    801031b0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801031c0:	89 14 85 0c 57 11 80 	mov    %edx,-0x7feea8f4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801031c7:	83 c0 01             	add    $0x1,%eax
801031ca:	a3 08 57 11 80       	mov    %eax,0x80115708
  b->flags |= B_DIRTY; // prevent eviction
801031cf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801031d2:	c7 45 08 c0 56 11 80 	movl   $0x801156c0,0x8(%ebp)
}
801031d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031dc:	c9                   	leave  
  release(&log.lock);
801031dd:	e9 7e 18 00 00       	jmp    80104a60 <release>
801031e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801031e8:	89 14 85 0c 57 11 80 	mov    %edx,-0x7feea8f4(,%eax,4)
801031ef:	eb de                	jmp    801031cf <log_write+0x7f>
801031f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031f8:	8b 43 08             	mov    0x8(%ebx),%eax
801031fb:	a3 0c 57 11 80       	mov    %eax,0x8011570c
  if (i == log.lh.n)
80103200:	75 cd                	jne    801031cf <log_write+0x7f>
80103202:	31 c0                	xor    %eax,%eax
80103204:	eb c1                	jmp    801031c7 <log_write+0x77>
    panic("too big a transaction");
80103206:	83 ec 0c             	sub    $0xc,%esp
80103209:	68 f3 81 10 80       	push   $0x801081f3
8010320e:	e8 7d d1 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103213:	83 ec 0c             	sub    $0xc,%esp
80103216:	68 09 82 10 80       	push   $0x80108209
8010321b:	e8 70 d1 ff ff       	call   80100390 <panic>

80103220 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103220:	55                   	push   %ebp
80103221:	89 e5                	mov    %esp,%ebp
80103223:	53                   	push   %ebx
80103224:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103227:	e8 f4 09 00 00       	call   80103c20 <cpuid>
8010322c:	89 c3                	mov    %eax,%ebx
8010322e:	e8 ed 09 00 00       	call   80103c20 <cpuid>
80103233:	83 ec 04             	sub    $0x4,%esp
80103236:	53                   	push   %ebx
80103237:	50                   	push   %eax
80103238:	68 24 82 10 80       	push   $0x80108224
8010323d:	e8 1e d4 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103242:	e8 29 2b 00 00       	call   80105d70 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103247:	e8 54 09 00 00       	call   80103ba0 <mycpu>
8010324c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010324e:	b8 01 00 00 00       	mov    $0x1,%eax
80103253:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010325a:	e8 71 0d 00 00       	call   80103fd0 <scheduler>
8010325f:	90                   	nop

80103260 <mpenter>:
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103266:	e8 75 3c 00 00       	call   80106ee0 <switchkvm>
  seginit();
8010326b:	e8 e0 3b 00 00       	call   80106e50 <seginit>
  lapicinit();
80103270:	e8 9b f7 ff ff       	call   80102a10 <lapicinit>
  mpmain();
80103275:	e8 a6 ff ff ff       	call   80103220 <mpmain>
8010327a:	66 90                	xchg   %ax,%ax
8010327c:	66 90                	xchg   %ax,%ax
8010327e:	66 90                	xchg   %ax,%ax

80103280 <main>:
{
80103280:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103284:	83 e4 f0             	and    $0xfffffff0,%esp
80103287:	ff 71 fc             	pushl  -0x4(%ecx)
8010328a:	55                   	push   %ebp
8010328b:	89 e5                	mov    %esp,%ebp
8010328d:	53                   	push   %ebx
8010328e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010328f:	83 ec 08             	sub    $0x8,%esp
80103292:	68 00 00 40 80       	push   $0x80400000
80103297:	68 e8 07 12 80       	push   $0x801207e8
8010329c:	e8 2f f5 ff ff       	call   801027d0 <kinit1>
  kvmalloc();      // kernel page table
801032a1:	e8 9a 47 00 00       	call   80107a40 <kvmalloc>
  mpinit();        // detect other processors
801032a6:	e8 75 01 00 00       	call   80103420 <mpinit>
  lapicinit();     // interrupt controller
801032ab:	e8 60 f7 ff ff       	call   80102a10 <lapicinit>
  seginit();       // segment descriptors
801032b0:	e8 9b 3b 00 00       	call   80106e50 <seginit>
  picinit();       // disable pic
801032b5:	e8 46 03 00 00       	call   80103600 <picinit>
  ioapicinit();    // another interrupt controller
801032ba:	e8 31 f3 ff ff       	call   801025f0 <ioapicinit>
  consoleinit();   // console hardware
801032bf:	e8 fc d6 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801032c4:	e8 d7 2d 00 00       	call   801060a0 <uartinit>
  pinit();         // process table
801032c9:	e8 b2 08 00 00       	call   80103b80 <pinit>
  tvinit();        // trap vectors
801032ce:	e8 1d 2a 00 00       	call   80105cf0 <tvinit>
  binit();         // buffer cache
801032d3:	e8 68 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
801032d8:	e8 c3 da ff ff       	call   80100da0 <fileinit>
  ideinit();       // disk 
801032dd:	e8 ee f0 ff ff       	call   801023d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801032e2:	83 c4 0c             	add    $0xc,%esp
801032e5:	68 8a 00 00 00       	push   $0x8a
801032ea:	68 8c b4 10 80       	push   $0x8010b48c
801032ef:	68 00 70 00 80       	push   $0x80007000
801032f4:	e8 67 18 00 00       	call   80104b60 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801032f9:	69 05 40 5d 11 80 b0 	imul   $0xb0,0x80115d40,%eax
80103300:	00 00 00 
80103303:	83 c4 10             	add    $0x10,%esp
80103306:	05 c0 57 11 80       	add    $0x801157c0,%eax
8010330b:	3d c0 57 11 80       	cmp    $0x801157c0,%eax
80103310:	76 71                	jbe    80103383 <main+0x103>
80103312:	bb c0 57 11 80       	mov    $0x801157c0,%ebx
80103317:	89 f6                	mov    %esi,%esi
80103319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103320:	e8 7b 08 00 00       	call   80103ba0 <mycpu>
80103325:	39 d8                	cmp    %ebx,%eax
80103327:	74 41                	je     8010336a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103329:	e8 72 f5 ff ff       	call   801028a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010332e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103333:	c7 05 f8 6f 00 80 60 	movl   $0x80103260,0x80006ff8
8010333a:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010333d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103344:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103347:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010334c:	0f b6 03             	movzbl (%ebx),%eax
8010334f:	83 ec 08             	sub    $0x8,%esp
80103352:	68 00 70 00 00       	push   $0x7000
80103357:	50                   	push   %eax
80103358:	e8 03 f8 ff ff       	call   80102b60 <lapicstartap>
8010335d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103360:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103366:	85 c0                	test   %eax,%eax
80103368:	74 f6                	je     80103360 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010336a:	69 05 40 5d 11 80 b0 	imul   $0xb0,0x80115d40,%eax
80103371:	00 00 00 
80103374:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010337a:	05 c0 57 11 80       	add    $0x801157c0,%eax
8010337f:	39 c3                	cmp    %eax,%ebx
80103381:	72 9d                	jb     80103320 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103383:	83 ec 08             	sub    $0x8,%esp
80103386:	68 00 00 00 8e       	push   $0x8e000000
8010338b:	68 00 00 40 80       	push   $0x80400000
80103390:	e8 ab f4 ff ff       	call   80102840 <kinit2>
  userinit();      // first user process
80103395:	e8 d6 08 00 00       	call   80103c70 <userinit>
  mpmain();        // finish this processor's setup
8010339a:	e8 81 fe ff ff       	call   80103220 <mpmain>
8010339f:	90                   	nop

801033a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	57                   	push   %edi
801033a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801033a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801033ab:	53                   	push   %ebx
  e = addr+len;
801033ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801033af:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801033b2:	39 de                	cmp    %ebx,%esi
801033b4:	72 10                	jb     801033c6 <mpsearch1+0x26>
801033b6:	eb 50                	jmp    80103408 <mpsearch1+0x68>
801033b8:	90                   	nop
801033b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033c0:	39 fb                	cmp    %edi,%ebx
801033c2:	89 fe                	mov    %edi,%esi
801033c4:	76 42                	jbe    80103408 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033c6:	83 ec 04             	sub    $0x4,%esp
801033c9:	8d 7e 10             	lea    0x10(%esi),%edi
801033cc:	6a 04                	push   $0x4
801033ce:	68 38 82 10 80       	push   $0x80108238
801033d3:	56                   	push   %esi
801033d4:	e8 27 17 00 00       	call   80104b00 <memcmp>
801033d9:	83 c4 10             	add    $0x10,%esp
801033dc:	85 c0                	test   %eax,%eax
801033de:	75 e0                	jne    801033c0 <mpsearch1+0x20>
801033e0:	89 f1                	mov    %esi,%ecx
801033e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801033e8:	0f b6 11             	movzbl (%ecx),%edx
801033eb:	83 c1 01             	add    $0x1,%ecx
801033ee:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801033f0:	39 f9                	cmp    %edi,%ecx
801033f2:	75 f4                	jne    801033e8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033f4:	84 c0                	test   %al,%al
801033f6:	75 c8                	jne    801033c0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801033f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033fb:	89 f0                	mov    %esi,%eax
801033fd:	5b                   	pop    %ebx
801033fe:	5e                   	pop    %esi
801033ff:	5f                   	pop    %edi
80103400:	5d                   	pop    %ebp
80103401:	c3                   	ret    
80103402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103408:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010340b:	31 f6                	xor    %esi,%esi
}
8010340d:	89 f0                	mov    %esi,%eax
8010340f:	5b                   	pop    %ebx
80103410:	5e                   	pop    %esi
80103411:	5f                   	pop    %edi
80103412:	5d                   	pop    %ebp
80103413:	c3                   	ret    
80103414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010341a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103420 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	57                   	push   %edi
80103424:	56                   	push   %esi
80103425:	53                   	push   %ebx
80103426:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103429:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103430:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103437:	c1 e0 08             	shl    $0x8,%eax
8010343a:	09 d0                	or     %edx,%eax
8010343c:	c1 e0 04             	shl    $0x4,%eax
8010343f:	85 c0                	test   %eax,%eax
80103441:	75 1b                	jne    8010345e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103443:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010344a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103451:	c1 e0 08             	shl    $0x8,%eax
80103454:	09 d0                	or     %edx,%eax
80103456:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103459:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010345e:	ba 00 04 00 00       	mov    $0x400,%edx
80103463:	e8 38 ff ff ff       	call   801033a0 <mpsearch1>
80103468:	85 c0                	test   %eax,%eax
8010346a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010346d:	0f 84 3d 01 00 00    	je     801035b0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103473:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103476:	8b 58 04             	mov    0x4(%eax),%ebx
80103479:	85 db                	test   %ebx,%ebx
8010347b:	0f 84 4f 01 00 00    	je     801035d0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103481:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103487:	83 ec 04             	sub    $0x4,%esp
8010348a:	6a 04                	push   $0x4
8010348c:	68 55 82 10 80       	push   $0x80108255
80103491:	56                   	push   %esi
80103492:	e8 69 16 00 00       	call   80104b00 <memcmp>
80103497:	83 c4 10             	add    $0x10,%esp
8010349a:	85 c0                	test   %eax,%eax
8010349c:	0f 85 2e 01 00 00    	jne    801035d0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801034a2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801034a9:	3c 01                	cmp    $0x1,%al
801034ab:	0f 95 c2             	setne  %dl
801034ae:	3c 04                	cmp    $0x4,%al
801034b0:	0f 95 c0             	setne  %al
801034b3:	20 c2                	and    %al,%dl
801034b5:	0f 85 15 01 00 00    	jne    801035d0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801034bb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801034c2:	66 85 ff             	test   %di,%di
801034c5:	74 1a                	je     801034e1 <mpinit+0xc1>
801034c7:	89 f0                	mov    %esi,%eax
801034c9:	01 f7                	add    %esi,%edi
  sum = 0;
801034cb:	31 d2                	xor    %edx,%edx
801034cd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801034d0:	0f b6 08             	movzbl (%eax),%ecx
801034d3:	83 c0 01             	add    $0x1,%eax
801034d6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801034d8:	39 c7                	cmp    %eax,%edi
801034da:	75 f4                	jne    801034d0 <mpinit+0xb0>
801034dc:	84 d2                	test   %dl,%dl
801034de:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801034e1:	85 f6                	test   %esi,%esi
801034e3:	0f 84 e7 00 00 00    	je     801035d0 <mpinit+0x1b0>
801034e9:	84 d2                	test   %dl,%dl
801034eb:	0f 85 df 00 00 00    	jne    801035d0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801034f1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801034f7:	a3 bc 56 11 80       	mov    %eax,0x801156bc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034fc:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103503:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103509:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010350e:	01 d6                	add    %edx,%esi
80103510:	39 c6                	cmp    %eax,%esi
80103512:	76 23                	jbe    80103537 <mpinit+0x117>
    switch(*p){
80103514:	0f b6 10             	movzbl (%eax),%edx
80103517:	80 fa 04             	cmp    $0x4,%dl
8010351a:	0f 87 ca 00 00 00    	ja     801035ea <mpinit+0x1ca>
80103520:	ff 24 95 7c 82 10 80 	jmp    *-0x7fef7d84(,%edx,4)
80103527:	89 f6                	mov    %esi,%esi
80103529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103530:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103533:	39 c6                	cmp    %eax,%esi
80103535:	77 dd                	ja     80103514 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103537:	85 db                	test   %ebx,%ebx
80103539:	0f 84 9e 00 00 00    	je     801035dd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010353f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103542:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103546:	74 15                	je     8010355d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103548:	b8 70 00 00 00       	mov    $0x70,%eax
8010354d:	ba 22 00 00 00       	mov    $0x22,%edx
80103552:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103553:	ba 23 00 00 00       	mov    $0x23,%edx
80103558:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103559:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010355c:	ee                   	out    %al,(%dx)
  }
}
8010355d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103560:	5b                   	pop    %ebx
80103561:	5e                   	pop    %esi
80103562:	5f                   	pop    %edi
80103563:	5d                   	pop    %ebp
80103564:	c3                   	ret    
80103565:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103568:	8b 0d 40 5d 11 80    	mov    0x80115d40,%ecx
8010356e:	83 f9 07             	cmp    $0x7,%ecx
80103571:	7f 19                	jg     8010358c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103573:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103577:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010357d:	83 c1 01             	add    $0x1,%ecx
80103580:	89 0d 40 5d 11 80    	mov    %ecx,0x80115d40
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103586:	88 97 c0 57 11 80    	mov    %dl,-0x7feea840(%edi)
      p += sizeof(struct mpproc);
8010358c:	83 c0 14             	add    $0x14,%eax
      continue;
8010358f:	e9 7c ff ff ff       	jmp    80103510 <mpinit+0xf0>
80103594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103598:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010359c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010359f:	88 15 a0 57 11 80    	mov    %dl,0x801157a0
      continue;
801035a5:	e9 66 ff ff ff       	jmp    80103510 <mpinit+0xf0>
801035aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801035b0:	ba 00 00 01 00       	mov    $0x10000,%edx
801035b5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801035ba:	e8 e1 fd ff ff       	call   801033a0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035bf:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801035c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035c4:	0f 85 a9 fe ff ff    	jne    80103473 <mpinit+0x53>
801035ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801035d0:	83 ec 0c             	sub    $0xc,%esp
801035d3:	68 3d 82 10 80       	push   $0x8010823d
801035d8:	e8 b3 cd ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801035dd:	83 ec 0c             	sub    $0xc,%esp
801035e0:	68 5c 82 10 80       	push   $0x8010825c
801035e5:	e8 a6 cd ff ff       	call   80100390 <panic>
      ismp = 0;
801035ea:	31 db                	xor    %ebx,%ebx
801035ec:	e9 26 ff ff ff       	jmp    80103517 <mpinit+0xf7>
801035f1:	66 90                	xchg   %ax,%ax
801035f3:	66 90                	xchg   %ax,%ax
801035f5:	66 90                	xchg   %ax,%ax
801035f7:	66 90                	xchg   %ax,%ax
801035f9:	66 90                	xchg   %ax,%ax
801035fb:	66 90                	xchg   %ax,%ax
801035fd:	66 90                	xchg   %ax,%ax
801035ff:	90                   	nop

80103600 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103600:	55                   	push   %ebp
80103601:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103606:	ba 21 00 00 00       	mov    $0x21,%edx
8010360b:	89 e5                	mov    %esp,%ebp
8010360d:	ee                   	out    %al,(%dx)
8010360e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103613:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103614:	5d                   	pop    %ebp
80103615:	c3                   	ret    
80103616:	66 90                	xchg   %ax,%ax
80103618:	66 90                	xchg   %ax,%ax
8010361a:	66 90                	xchg   %ax,%ax
8010361c:	66 90                	xchg   %ax,%ax
8010361e:	66 90                	xchg   %ax,%ax

80103620 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	57                   	push   %edi
80103624:	56                   	push   %esi
80103625:	53                   	push   %ebx
80103626:	83 ec 0c             	sub    $0xc,%esp
80103629:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010362c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010362f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103635:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010363b:	e8 80 d7 ff ff       	call   80100dc0 <filealloc>
80103640:	85 c0                	test   %eax,%eax
80103642:	89 03                	mov    %eax,(%ebx)
80103644:	74 22                	je     80103668 <pipealloc+0x48>
80103646:	e8 75 d7 ff ff       	call   80100dc0 <filealloc>
8010364b:	85 c0                	test   %eax,%eax
8010364d:	89 06                	mov    %eax,(%esi)
8010364f:	74 3f                	je     80103690 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103651:	e8 4a f2 ff ff       	call   801028a0 <kalloc>
80103656:	85 c0                	test   %eax,%eax
80103658:	89 c7                	mov    %eax,%edi
8010365a:	75 54                	jne    801036b0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010365c:	8b 03                	mov    (%ebx),%eax
8010365e:	85 c0                	test   %eax,%eax
80103660:	75 34                	jne    80103696 <pipealloc+0x76>
80103662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103668:	8b 06                	mov    (%esi),%eax
8010366a:	85 c0                	test   %eax,%eax
8010366c:	74 0c                	je     8010367a <pipealloc+0x5a>
    fileclose(*f1);
8010366e:	83 ec 0c             	sub    $0xc,%esp
80103671:	50                   	push   %eax
80103672:	e8 09 d8 ff ff       	call   80100e80 <fileclose>
80103677:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010367a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010367d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103682:	5b                   	pop    %ebx
80103683:	5e                   	pop    %esi
80103684:	5f                   	pop    %edi
80103685:	5d                   	pop    %ebp
80103686:	c3                   	ret    
80103687:	89 f6                	mov    %esi,%esi
80103689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103690:	8b 03                	mov    (%ebx),%eax
80103692:	85 c0                	test   %eax,%eax
80103694:	74 e4                	je     8010367a <pipealloc+0x5a>
    fileclose(*f0);
80103696:	83 ec 0c             	sub    $0xc,%esp
80103699:	50                   	push   %eax
8010369a:	e8 e1 d7 ff ff       	call   80100e80 <fileclose>
  if(*f1)
8010369f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801036a1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036a4:	85 c0                	test   %eax,%eax
801036a6:	75 c6                	jne    8010366e <pipealloc+0x4e>
801036a8:	eb d0                	jmp    8010367a <pipealloc+0x5a>
801036aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801036b0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801036b3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801036ba:	00 00 00 
  p->writeopen = 1;
801036bd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801036c4:	00 00 00 
  p->nwrite = 0;
801036c7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801036ce:	00 00 00 
  p->nread = 0;
801036d1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801036d8:	00 00 00 
  initlock(&p->lock, "pipe");
801036db:	68 90 82 10 80       	push   $0x80108290
801036e0:	50                   	push   %eax
801036e1:	e8 7a 11 00 00       	call   80104860 <initlock>
  (*f0)->type = FD_PIPE;
801036e6:	8b 03                	mov    (%ebx),%eax
  return 0;
801036e8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801036eb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801036f1:	8b 03                	mov    (%ebx),%eax
801036f3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801036f7:	8b 03                	mov    (%ebx),%eax
801036f9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801036fd:	8b 03                	mov    (%ebx),%eax
801036ff:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103702:	8b 06                	mov    (%esi),%eax
80103704:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010370a:	8b 06                	mov    (%esi),%eax
8010370c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103710:	8b 06                	mov    (%esi),%eax
80103712:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103716:	8b 06                	mov    (%esi),%eax
80103718:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010371b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010371e:	31 c0                	xor    %eax,%eax
}
80103720:	5b                   	pop    %ebx
80103721:	5e                   	pop    %esi
80103722:	5f                   	pop    %edi
80103723:	5d                   	pop    %ebp
80103724:	c3                   	ret    
80103725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103730 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	56                   	push   %esi
80103734:	53                   	push   %ebx
80103735:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103738:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010373b:	83 ec 0c             	sub    $0xc,%esp
8010373e:	53                   	push   %ebx
8010373f:	e8 5c 12 00 00       	call   801049a0 <acquire>
  if(writable){
80103744:	83 c4 10             	add    $0x10,%esp
80103747:	85 f6                	test   %esi,%esi
80103749:	74 45                	je     80103790 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010374b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103751:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103754:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010375b:	00 00 00 
    wakeup(&p->nread);
8010375e:	50                   	push   %eax
8010375f:	e8 2c 0d 00 00       	call   80104490 <wakeup>
80103764:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103767:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010376d:	85 d2                	test   %edx,%edx
8010376f:	75 0a                	jne    8010377b <pipeclose+0x4b>
80103771:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103777:	85 c0                	test   %eax,%eax
80103779:	74 35                	je     801037b0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010377b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010377e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103781:	5b                   	pop    %ebx
80103782:	5e                   	pop    %esi
80103783:	5d                   	pop    %ebp
    release(&p->lock);
80103784:	e9 d7 12 00 00       	jmp    80104a60 <release>
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103790:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103796:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103799:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801037a0:	00 00 00 
    wakeup(&p->nwrite);
801037a3:	50                   	push   %eax
801037a4:	e8 e7 0c 00 00       	call   80104490 <wakeup>
801037a9:	83 c4 10             	add    $0x10,%esp
801037ac:	eb b9                	jmp    80103767 <pipeclose+0x37>
801037ae:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801037b0:	83 ec 0c             	sub    $0xc,%esp
801037b3:	53                   	push   %ebx
801037b4:	e8 a7 12 00 00       	call   80104a60 <release>
    kfree((char*)p);
801037b9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801037bc:	83 c4 10             	add    $0x10,%esp
}
801037bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037c2:	5b                   	pop    %ebx
801037c3:	5e                   	pop    %esi
801037c4:	5d                   	pop    %ebp
    kfree((char*)p);
801037c5:	e9 26 ef ff ff       	jmp    801026f0 <kfree>
801037ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037d0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	57                   	push   %edi
801037d4:	56                   	push   %esi
801037d5:	53                   	push   %ebx
801037d6:	83 ec 28             	sub    $0x28,%esp
801037d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801037dc:	53                   	push   %ebx
801037dd:	e8 be 11 00 00       	call   801049a0 <acquire>
  for(i = 0; i < n; i++){
801037e2:	8b 45 10             	mov    0x10(%ebp),%eax
801037e5:	83 c4 10             	add    $0x10,%esp
801037e8:	85 c0                	test   %eax,%eax
801037ea:	0f 8e c9 00 00 00    	jle    801038b9 <pipewrite+0xe9>
801037f0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801037f3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801037f9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801037ff:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103802:	03 4d 10             	add    0x10(%ebp),%ecx
80103805:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103808:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010380e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103814:	39 d0                	cmp    %edx,%eax
80103816:	75 71                	jne    80103889 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103818:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010381e:	85 c0                	test   %eax,%eax
80103820:	74 4e                	je     80103870 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103822:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103828:	eb 3a                	jmp    80103864 <pipewrite+0x94>
8010382a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103830:	83 ec 0c             	sub    $0xc,%esp
80103833:	57                   	push   %edi
80103834:	e8 57 0c 00 00       	call   80104490 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103839:	5a                   	pop    %edx
8010383a:	59                   	pop    %ecx
8010383b:	53                   	push   %ebx
8010383c:	56                   	push   %esi
8010383d:	e8 8e 0a 00 00       	call   801042d0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103842:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103848:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010384e:	83 c4 10             	add    $0x10,%esp
80103851:	05 00 02 00 00       	add    $0x200,%eax
80103856:	39 c2                	cmp    %eax,%edx
80103858:	75 36                	jne    80103890 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010385a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103860:	85 c0                	test   %eax,%eax
80103862:	74 0c                	je     80103870 <pipewrite+0xa0>
80103864:	e8 d7 03 00 00       	call   80103c40 <myproc>
80103869:	8b 40 24             	mov    0x24(%eax),%eax
8010386c:	85 c0                	test   %eax,%eax
8010386e:	74 c0                	je     80103830 <pipewrite+0x60>
        release(&p->lock);
80103870:	83 ec 0c             	sub    $0xc,%esp
80103873:	53                   	push   %ebx
80103874:	e8 e7 11 00 00       	call   80104a60 <release>
        return -1;
80103879:	83 c4 10             	add    $0x10,%esp
8010387c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103881:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103884:	5b                   	pop    %ebx
80103885:	5e                   	pop    %esi
80103886:	5f                   	pop    %edi
80103887:	5d                   	pop    %ebp
80103888:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103889:	89 c2                	mov    %eax,%edx
8010388b:	90                   	nop
8010388c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103890:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103893:	8d 42 01             	lea    0x1(%edx),%eax
80103896:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010389c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801038a2:	83 c6 01             	add    $0x1,%esi
801038a5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801038a9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801038ac:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038af:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801038b3:	0f 85 4f ff ff ff    	jne    80103808 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801038b9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801038bf:	83 ec 0c             	sub    $0xc,%esp
801038c2:	50                   	push   %eax
801038c3:	e8 c8 0b 00 00       	call   80104490 <wakeup>
  release(&p->lock);
801038c8:	89 1c 24             	mov    %ebx,(%esp)
801038cb:	e8 90 11 00 00       	call   80104a60 <release>
  return n;
801038d0:	83 c4 10             	add    $0x10,%esp
801038d3:	8b 45 10             	mov    0x10(%ebp),%eax
801038d6:	eb a9                	jmp    80103881 <pipewrite+0xb1>
801038d8:	90                   	nop
801038d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	57                   	push   %edi
801038e4:	56                   	push   %esi
801038e5:	53                   	push   %ebx
801038e6:	83 ec 18             	sub    $0x18,%esp
801038e9:	8b 75 08             	mov    0x8(%ebp),%esi
801038ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801038ef:	56                   	push   %esi
801038f0:	e8 ab 10 00 00       	call   801049a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038f5:	83 c4 10             	add    $0x10,%esp
801038f8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801038fe:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103904:	75 6a                	jne    80103970 <piperead+0x90>
80103906:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010390c:	85 db                	test   %ebx,%ebx
8010390e:	0f 84 c4 00 00 00    	je     801039d8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103914:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010391a:	eb 2d                	jmp    80103949 <piperead+0x69>
8010391c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103920:	83 ec 08             	sub    $0x8,%esp
80103923:	56                   	push   %esi
80103924:	53                   	push   %ebx
80103925:	e8 a6 09 00 00       	call   801042d0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010392a:	83 c4 10             	add    $0x10,%esp
8010392d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103933:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103939:	75 35                	jne    80103970 <piperead+0x90>
8010393b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103941:	85 d2                	test   %edx,%edx
80103943:	0f 84 8f 00 00 00    	je     801039d8 <piperead+0xf8>
    if(myproc()->killed){
80103949:	e8 f2 02 00 00       	call   80103c40 <myproc>
8010394e:	8b 48 24             	mov    0x24(%eax),%ecx
80103951:	85 c9                	test   %ecx,%ecx
80103953:	74 cb                	je     80103920 <piperead+0x40>
      release(&p->lock);
80103955:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103958:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010395d:	56                   	push   %esi
8010395e:	e8 fd 10 00 00       	call   80104a60 <release>
      return -1;
80103963:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103966:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103969:	89 d8                	mov    %ebx,%eax
8010396b:	5b                   	pop    %ebx
8010396c:	5e                   	pop    %esi
8010396d:	5f                   	pop    %edi
8010396e:	5d                   	pop    %ebp
8010396f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103970:	8b 45 10             	mov    0x10(%ebp),%eax
80103973:	85 c0                	test   %eax,%eax
80103975:	7e 61                	jle    801039d8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103977:	31 db                	xor    %ebx,%ebx
80103979:	eb 13                	jmp    8010398e <piperead+0xae>
8010397b:	90                   	nop
8010397c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103980:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103986:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010398c:	74 1f                	je     801039ad <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010398e:	8d 41 01             	lea    0x1(%ecx),%eax
80103991:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103997:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010399d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801039a2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039a5:	83 c3 01             	add    $0x1,%ebx
801039a8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801039ab:	75 d3                	jne    80103980 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801039ad:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801039b3:	83 ec 0c             	sub    $0xc,%esp
801039b6:	50                   	push   %eax
801039b7:	e8 d4 0a 00 00       	call   80104490 <wakeup>
  release(&p->lock);
801039bc:	89 34 24             	mov    %esi,(%esp)
801039bf:	e8 9c 10 00 00       	call   80104a60 <release>
  return i;
801039c4:	83 c4 10             	add    $0x10,%esp
}
801039c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039ca:	89 d8                	mov    %ebx,%eax
801039cc:	5b                   	pop    %ebx
801039cd:	5e                   	pop    %esi
801039ce:	5f                   	pop    %edi
801039cf:	5d                   	pop    %ebp
801039d0:	c3                   	ret    
801039d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039d8:	31 db                	xor    %ebx,%ebx
801039da:	eb d1                	jmp    801039ad <piperead+0xcd>
801039dc:	66 90                	xchg   %ax,%ax
801039de:	66 90                	xchg   %ax,%ax

801039e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	57                   	push   %edi
801039e4:	56                   	push   %esi
801039e5:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039e6:	bb 94 5d 11 80       	mov    $0x80115d94,%ebx
{
801039eb:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
801039ee:	68 60 5d 11 80       	push   $0x80115d60
801039f3:	e8 a8 0f 00 00       	call   801049a0 <acquire>
801039f8:	83 c4 10             	add    $0x10,%esp
801039fb:	eb 15                	jmp    80103a12 <allocproc+0x32>
801039fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a00:	81 c3 88 02 00 00    	add    $0x288,%ebx
80103a06:	81 fb 94 ff 11 80    	cmp    $0x8011ff94,%ebx
80103a0c:	0f 83 ee 00 00 00    	jae    80103b00 <allocproc+0x120>
    if(p->state == UNUSED)
80103a12:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a15:	85 c0                	test   %eax,%eax
80103a17:	75 e7                	jne    80103a00 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a19:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  p->page_fault_counter = 0;
  p->swaps_out_counter = 0;
  release(&ptable.lock);
80103a1e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a21:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->page_fault_counter = 0;
80103a28:	c7 83 80 02 00 00 00 	movl   $0x0,0x280(%ebx)
80103a2f:	00 00 00 
  p->swaps_out_counter = 0;
80103a32:	c7 83 84 02 00 00 00 	movl   $0x0,0x284(%ebx)
80103a39:	00 00 00 
  p->pid = nextpid++;
80103a3c:	8d 50 01             	lea    0x1(%eax),%edx
80103a3f:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103a42:	68 60 5d 11 80       	push   $0x80115d60
  p->pid = nextpid++;
80103a47:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103a4d:	e8 0e 10 00 00       	call   80104a60 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a52:	e8 49 ee ff ff       	call   801028a0 <kalloc>
80103a57:	83 c4 10             	add    $0x10,%esp
80103a5a:	85 c0                	test   %eax,%eax
80103a5c:	89 43 08             	mov    %eax,0x8(%ebx)
80103a5f:	0f 84 b7 00 00 00    	je     80103b1c <allocproc+0x13c>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a65:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a6b:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a6e:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a73:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a76:	c7 40 14 e2 5c 10 80 	movl   $0x80105ce2,0x14(%eax)
  p->context = (struct context*)sp;
80103a7d:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a80:	6a 14                	push   $0x14
80103a82:	6a 00                	push   $0x0
80103a84:	50                   	push   %eax
80103a85:	e8 26 10 00 00       	call   80104ab0 <memset>
  p->context->eip = (uint)forkret;
80103a8a:	8b 43 1c             	mov    0x1c(%ebx),%eax

  //set up Swap file
  if(p->pid>2){
80103a8d:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a90:	c7 40 10 30 3b 10 80 	movl   $0x80103b30,0x10(%eax)
  if(p->pid>2){
80103a97:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
80103a9b:	7f 43                	jg     80103ae0 <allocproc+0x100>
80103a9d:	8d b3 80 00 00 00    	lea    0x80(%ebx),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103aa3:	31 ff                	xor    %edi,%edi
80103aa5:	8d 76 00             	lea    0x0(%esi),%esi
  }

  //alloc the proc pages
  for(int i = 0; i < 16; i++){
    p->main_mem_pages[i].state_used=0;
    ResetPageCounter(p, i);
80103aa8:	83 ec 08             	sub    $0x8,%esp
    p->main_mem_pages[i].state_used=0;
80103aab:	c6 06 00             	movb   $0x0,(%esi)
80103aae:	83 c6 10             	add    $0x10,%esi
    ResetPageCounter(p, i);
80103ab1:	57                   	push   %edi
80103ab2:	53                   	push   %ebx
  for(int i = 0; i < 16; i++){
80103ab3:	83 c7 01             	add    $0x1,%edi
    ResetPageCounter(p, i);
80103ab6:	e8 95 36 00 00       	call   80107150 <ResetPageCounter>
    p->swap_file_pages[i].state_used=0;
80103abb:	c6 86 f0 00 00 00 00 	movb   $0x0,0xf0(%esi)
    p->swap_file_pages[i].counter =0;
80103ac2:	c7 86 fc 00 00 00 00 	movl   $0x0,0xfc(%esi)
80103ac9:	00 00 00 
  for(int i = 0; i < 16; i++){
80103acc:	83 c4 10             	add    $0x10,%esp
80103acf:	83 ff 10             	cmp    $0x10,%edi
80103ad2:	75 d4                	jne    80103aa8 <allocproc+0xc8>
  }

  return p;
}
80103ad4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ad7:	89 d8                	mov    %ebx,%eax
80103ad9:	5b                   	pop    %ebx
80103ada:	5e                   	pop    %esi
80103adb:	5f                   	pop    %edi
80103adc:	5d                   	pop    %ebp
80103add:	c3                   	ret    
80103ade:	66 90                	xchg   %ax,%ax
    if(createSwapFile(p)){
80103ae0:	83 ec 0c             	sub    $0xc,%esp
80103ae3:	53                   	push   %ebx
80103ae4:	e8 07 e7 ff ff       	call   801021f0 <createSwapFile>
80103ae9:	83 c4 10             	add    $0x10,%esp
80103aec:	85 c0                	test   %eax,%eax
80103aee:	74 ad                	je     80103a9d <allocproc+0xbd>
      panic("failed create Swap file");
80103af0:	83 ec 0c             	sub    $0xc,%esp
80103af3:	68 95 82 10 80       	push   $0x80108295
80103af8:	e8 93 c8 ff ff       	call   80100390 <panic>
80103afd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103b00:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103b03:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103b05:	68 60 5d 11 80       	push   $0x80115d60
80103b0a:	e8 51 0f 00 00       	call   80104a60 <release>
  return 0;
80103b0f:	83 c4 10             	add    $0x10,%esp
}
80103b12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b15:	89 d8                	mov    %ebx,%eax
80103b17:	5b                   	pop    %ebx
80103b18:	5e                   	pop    %esi
80103b19:	5f                   	pop    %edi
80103b1a:	5d                   	pop    %ebp
80103b1b:	c3                   	ret    
    p->state = UNUSED;
80103b1c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103b23:	31 db                	xor    %ebx,%ebx
80103b25:	eb ad                	jmp    80103ad4 <allocproc+0xf4>
80103b27:	89 f6                	mov    %esi,%esi
80103b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b30 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103b30:	55                   	push   %ebp
80103b31:	89 e5                	mov    %esp,%ebp
80103b33:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103b36:	68 60 5d 11 80       	push   $0x80115d60
80103b3b:	e8 20 0f 00 00       	call   80104a60 <release>

  if (first) {
80103b40:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103b45:	83 c4 10             	add    $0x10,%esp
80103b48:	85 c0                	test   %eax,%eax
80103b4a:	75 04                	jne    80103b50 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103b4c:	c9                   	leave  
80103b4d:	c3                   	ret    
80103b4e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103b50:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103b53:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103b5a:	00 00 00 
    iinit(ROOTDEV);
80103b5d:	6a 01                	push   $0x1
80103b5f:	e8 5c d9 ff ff       	call   801014c0 <iinit>
    initlog(ROOTDEV);
80103b64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b6b:	e8 70 f3 ff ff       	call   80102ee0 <initlog>
80103b70:	83 c4 10             	add    $0x10,%esp
}
80103b73:	c9                   	leave  
80103b74:	c3                   	ret    
80103b75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b80 <pinit>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103b86:	68 ad 82 10 80       	push   $0x801082ad
80103b8b:	68 60 5d 11 80       	push   $0x80115d60
80103b90:	e8 cb 0c 00 00       	call   80104860 <initlock>
}
80103b95:	83 c4 10             	add    $0x10,%esp
80103b98:	c9                   	leave  
80103b99:	c3                   	ret    
80103b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ba0 <mycpu>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	56                   	push   %esi
80103ba4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ba5:	9c                   	pushf  
80103ba6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ba7:	f6 c4 02             	test   $0x2,%ah
80103baa:	75 5e                	jne    80103c0a <mycpu+0x6a>
  apicid = lapicid();
80103bac:	e8 5f ef ff ff       	call   80102b10 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103bb1:	8b 35 40 5d 11 80    	mov    0x80115d40,%esi
80103bb7:	85 f6                	test   %esi,%esi
80103bb9:	7e 42                	jle    80103bfd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103bbb:	0f b6 15 c0 57 11 80 	movzbl 0x801157c0,%edx
80103bc2:	39 d0                	cmp    %edx,%eax
80103bc4:	74 30                	je     80103bf6 <mycpu+0x56>
80103bc6:	b9 70 58 11 80       	mov    $0x80115870,%ecx
  for (i = 0; i < ncpu; ++i) {
80103bcb:	31 d2                	xor    %edx,%edx
80103bcd:	8d 76 00             	lea    0x0(%esi),%esi
80103bd0:	83 c2 01             	add    $0x1,%edx
80103bd3:	39 f2                	cmp    %esi,%edx
80103bd5:	74 26                	je     80103bfd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103bd7:	0f b6 19             	movzbl (%ecx),%ebx
80103bda:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103be0:	39 c3                	cmp    %eax,%ebx
80103be2:	75 ec                	jne    80103bd0 <mycpu+0x30>
80103be4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103bea:	05 c0 57 11 80       	add    $0x801157c0,%eax
}
80103bef:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bf2:	5b                   	pop    %ebx
80103bf3:	5e                   	pop    %esi
80103bf4:	5d                   	pop    %ebp
80103bf5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103bf6:	b8 c0 57 11 80       	mov    $0x801157c0,%eax
      return &cpus[i];
80103bfb:	eb f2                	jmp    80103bef <mycpu+0x4f>
  panic("unknown apicid\n");
80103bfd:	83 ec 0c             	sub    $0xc,%esp
80103c00:	68 b4 82 10 80       	push   $0x801082b4
80103c05:	e8 86 c7 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103c0a:	83 ec 0c             	sub    $0xc,%esp
80103c0d:	68 88 83 10 80       	push   $0x80108388
80103c12:	e8 79 c7 ff ff       	call   80100390 <panic>
80103c17:	89 f6                	mov    %esi,%esi
80103c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c20 <cpuid>:
cpuid() {
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103c26:	e8 75 ff ff ff       	call   80103ba0 <mycpu>
80103c2b:	2d c0 57 11 80       	sub    $0x801157c0,%eax
}
80103c30:	c9                   	leave  
  return mycpu()-cpus;
80103c31:	c1 f8 04             	sar    $0x4,%eax
80103c34:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103c3a:	c3                   	ret    
80103c3b:	90                   	nop
80103c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103c40 <myproc>:
myproc(void) {
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	53                   	push   %ebx
80103c44:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103c47:	e8 84 0c 00 00       	call   801048d0 <pushcli>
  c = mycpu();
80103c4c:	e8 4f ff ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80103c51:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c57:	e8 b4 0c 00 00       	call   80104910 <popcli>
}
80103c5c:	83 c4 04             	add    $0x4,%esp
80103c5f:	89 d8                	mov    %ebx,%eax
80103c61:	5b                   	pop    %ebx
80103c62:	5d                   	pop    %ebp
80103c63:	c3                   	ret    
80103c64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c70 <userinit>:
{
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	53                   	push   %ebx
80103c74:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103c77:	e8 64 fd ff ff       	call   801039e0 <allocproc>
80103c7c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103c7e:	a3 c4 b5 10 80       	mov    %eax,0x8010b5c4
  if((p->pgdir = setupkvm()) == 0)
80103c83:	e8 38 3d 00 00       	call   801079c0 <setupkvm>
80103c88:	85 c0                	test   %eax,%eax
80103c8a:	89 43 04             	mov    %eax,0x4(%ebx)
80103c8d:	0f 84 bd 00 00 00    	je     80103d50 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103c93:	83 ec 04             	sub    $0x4,%esp
80103c96:	68 2c 00 00 00       	push   $0x2c
80103c9b:	68 60 b4 10 80       	push   $0x8010b460
80103ca0:	50                   	push   %eax
80103ca1:	e8 6a 33 00 00       	call   80107010 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ca6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ca9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103caf:	6a 4c                	push   $0x4c
80103cb1:	6a 00                	push   $0x0
80103cb3:	ff 73 18             	pushl  0x18(%ebx)
80103cb6:	e8 f5 0d 00 00       	call   80104ab0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103cbb:	8b 43 18             	mov    0x18(%ebx),%eax
80103cbe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103cc3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103cc8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103ccb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ccf:	8b 43 18             	mov    0x18(%ebx),%eax
80103cd2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103cd6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cd9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103cdd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103ce1:	8b 43 18             	mov    0x18(%ebx),%eax
80103ce4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ce8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103cec:	8b 43 18             	mov    0x18(%ebx),%eax
80103cef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103cf6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cf9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103d00:	8b 43 18             	mov    0x18(%ebx),%eax
80103d03:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d0a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d0d:	6a 10                	push   $0x10
80103d0f:	68 dd 82 10 80       	push   $0x801082dd
80103d14:	50                   	push   %eax
80103d15:	e8 76 0f 00 00       	call   80104c90 <safestrcpy>
  p->cwd = namei("/");
80103d1a:	c7 04 24 e6 82 10 80 	movl   $0x801082e6,(%esp)
80103d21:	e8 fa e1 ff ff       	call   80101f20 <namei>
80103d26:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103d29:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80103d30:	e8 6b 0c 00 00       	call   801049a0 <acquire>
  p->state = RUNNABLE;
80103d35:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103d3c:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80103d43:	e8 18 0d 00 00       	call   80104a60 <release>
}
80103d48:	83 c4 10             	add    $0x10,%esp
80103d4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d4e:	c9                   	leave  
80103d4f:	c3                   	ret    
    panic("userinit: out of memory?");
80103d50:	83 ec 0c             	sub    $0xc,%esp
80103d53:	68 c4 82 10 80       	push   $0x801082c4
80103d58:	e8 33 c6 ff ff       	call   80100390 <panic>
80103d5d:	8d 76 00             	lea    0x0(%esi),%esi

80103d60 <growproc>:
{
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	56                   	push   %esi
80103d64:	53                   	push   %ebx
80103d65:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103d68:	e8 63 0b 00 00       	call   801048d0 <pushcli>
  c = mycpu();
80103d6d:	e8 2e fe ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80103d72:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d78:	e8 93 0b 00 00       	call   80104910 <popcli>
  if(n > 0){
80103d7d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103d80:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103d82:	7f 1c                	jg     80103da0 <growproc+0x40>
  } else if(n < 0){
80103d84:	75 3a                	jne    80103dc0 <growproc+0x60>
  switchuvm(curproc);
80103d86:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103d89:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103d8b:	53                   	push   %ebx
80103d8c:	e8 6f 31 00 00       	call   80106f00 <switchuvm>
  return 0;
80103d91:	83 c4 10             	add    $0x10,%esp
80103d94:	31 c0                	xor    %eax,%eax
}
80103d96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d99:	5b                   	pop    %ebx
80103d9a:	5e                   	pop    %esi
80103d9b:	5d                   	pop    %ebp
80103d9c:	c3                   	ret    
80103d9d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103da0:	83 ec 04             	sub    $0x4,%esp
80103da3:	01 c6                	add    %eax,%esi
80103da5:	56                   	push   %esi
80103da6:	50                   	push   %eax
80103da7:	ff 73 04             	pushl  0x4(%ebx)
80103daa:	e8 81 37 00 00       	call   80107530 <allocuvm>
80103daf:	83 c4 10             	add    $0x10,%esp
80103db2:	85 c0                	test   %eax,%eax
80103db4:	75 d0                	jne    80103d86 <growproc+0x26>
      return -1;
80103db6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103dbb:	eb d9                	jmp    80103d96 <growproc+0x36>
80103dbd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103dc0:	83 ec 04             	sub    $0x4,%esp
80103dc3:	01 c6                	add    %eax,%esi
80103dc5:	56                   	push   %esi
80103dc6:	50                   	push   %eax
80103dc7:	ff 73 04             	pushl  0x4(%ebx)
80103dca:	e8 41 3b 00 00       	call   80107910 <deallocuvm>
80103dcf:	83 c4 10             	add    $0x10,%esp
80103dd2:	85 c0                	test   %eax,%eax
80103dd4:	75 b0                	jne    80103d86 <growproc+0x26>
80103dd6:	eb de                	jmp    80103db6 <growproc+0x56>
80103dd8:	90                   	nop
80103dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103de0 <fork>:
{
80103de0:	55                   	push   %ebp
80103de1:	89 e5                	mov    %esp,%ebp
80103de3:	57                   	push   %edi
80103de4:	56                   	push   %esi
80103de5:	53                   	push   %ebx
80103de6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103de9:	e8 e2 0a 00 00       	call   801048d0 <pushcli>
  c = mycpu();
80103dee:	e8 ad fd ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80103df3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103df9:	e8 12 0b 00 00       	call   80104910 <popcli>
  if((np = allocproc()) == 0){
80103dfe:	e8 dd fb ff ff       	call   801039e0 <allocproc>
80103e03:	85 c0                	test   %eax,%eax
80103e05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e08:	0f 84 5f 01 00 00    	je     80103f6d <fork+0x18d>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103e0e:	83 ec 08             	sub    $0x8,%esp
80103e11:	ff 33                	pushl  (%ebx)
80103e13:	ff 73 04             	pushl  0x4(%ebx)
80103e16:	89 c7                	mov    %eax,%edi
80103e18:	e8 73 3c 00 00       	call   80107a90 <copyuvm>
80103e1d:	83 c4 10             	add    $0x10,%esp
80103e20:	85 c0                	test   %eax,%eax
80103e22:	89 47 04             	mov    %eax,0x4(%edi)
80103e25:	0f 84 4c 01 00 00    	je     80103f77 <fork+0x197>
  if(curproc->pid>2){
80103e2b:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
80103e2f:	0f 8f a3 00 00 00    	jg     80103ed8 <fork+0xf8>
  np->sz = curproc->sz;
80103e35:	8b 03                	mov    (%ebx),%eax
80103e37:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103e3a:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103e3c:	89 59 14             	mov    %ebx,0x14(%ecx)
80103e3f:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103e41:	8b 79 18             	mov    0x18(%ecx),%edi
80103e44:	8b 73 18             	mov    0x18(%ebx),%esi
80103e47:	b9 13 00 00 00       	mov    $0x13,%ecx
80103e4c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103e4e:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103e50:	8b 40 18             	mov    0x18(%eax),%eax
80103e53:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
80103e60:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103e64:	85 c0                	test   %eax,%eax
80103e66:	74 13                	je     80103e7b <fork+0x9b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103e68:	83 ec 0c             	sub    $0xc,%esp
80103e6b:	50                   	push   %eax
80103e6c:	e8 bf cf ff ff       	call   80100e30 <filedup>
80103e71:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103e74:	83 c4 10             	add    $0x10,%esp
80103e77:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103e7b:	83 c6 01             	add    $0x1,%esi
80103e7e:	83 fe 10             	cmp    $0x10,%esi
80103e81:	75 dd                	jne    80103e60 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103e83:	83 ec 0c             	sub    $0xc,%esp
80103e86:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e89:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103e8c:	e8 ff d7 ff ff       	call   80101690 <idup>
80103e91:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e94:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103e97:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e9a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103e9d:	6a 10                	push   $0x10
80103e9f:	53                   	push   %ebx
80103ea0:	50                   	push   %eax
80103ea1:	e8 ea 0d 00 00       	call   80104c90 <safestrcpy>
  pid = np->pid;
80103ea6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ea9:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80103eb0:	e8 eb 0a 00 00       	call   801049a0 <acquire>
  np->state = RUNNABLE;
80103eb5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103ebc:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
80103ec3:	e8 98 0b 00 00       	call   80104a60 <release>
  return pid;
80103ec8:	83 c4 10             	add    $0x10,%esp
}
80103ecb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ece:	89 d8                	mov    %ebx,%eax
80103ed0:	5b                   	pop    %ebx
80103ed1:	5e                   	pop    %esi
80103ed2:	5f                   	pop    %edi
80103ed3:	5d                   	pop    %ebp
80103ed4:	c3                   	ret    
80103ed5:	8d 76 00             	lea    0x0(%esi),%esi
80103ed8:	31 f6                	xor    %esi,%esi
80103eda:	eb 0f                	jmp    80103eeb <fork+0x10b>
80103edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ee0:	83 c6 10             	add    $0x10,%esi
    for(int i=0;i<16;i++){
80103ee3:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80103ee9:	74 41                	je     80103f2c <fork+0x14c>
      if (curproc->swap_file_pages[i].state_used){
80103eeb:	80 bc 33 80 01 00 00 	cmpb   $0x0,0x180(%ebx,%esi,1)
80103ef2:	00 
80103ef3:	74 eb                	je     80103ee0 <fork+0x100>
80103ef5:	89 f7                	mov    %esi,%edi
        readFromSwapFile(curproc,buffer,i*PGSIZE, PGSIZE);
80103ef7:	68 00 10 00 00       	push   $0x1000
80103efc:	83 c6 10             	add    $0x10,%esi
80103eff:	c1 e7 08             	shl    $0x8,%edi
80103f02:	57                   	push   %edi
80103f03:	68 e0 b5 10 80       	push   $0x8010b5e0
80103f08:	53                   	push   %ebx
80103f09:	e8 b2 e3 ff ff       	call   801022c0 <readFromSwapFile>
        writeToSwapFile(np,buffer,i*PGSIZE, PGSIZE);
80103f0e:	68 00 10 00 00       	push   $0x1000
80103f13:	57                   	push   %edi
80103f14:	68 e0 b5 10 80       	push   $0x8010b5e0
80103f19:	ff 75 e4             	pushl  -0x1c(%ebp)
80103f1c:	e8 6f e3 ff ff       	call   80102290 <writeToSwapFile>
80103f21:	83 c4 20             	add    $0x20,%esp
    for(int i=0;i<16;i++){
80103f24:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80103f2a:	75 bf                	jne    80103eeb <fork+0x10b>
    memmove(curproc->main_mem_pages, np->main_mem_pages, sizeof(struct page)*16);// TODO: check address correctness
80103f2c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103f2f:	83 ec 04             	sub    $0x4,%esp
80103f32:	68 00 01 00 00       	push   $0x100
80103f37:	8d 87 80 00 00 00    	lea    0x80(%edi),%eax
80103f3d:	50                   	push   %eax
80103f3e:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax
80103f44:	50                   	push   %eax
80103f45:	e8 16 0c 00 00       	call   80104b60 <memmove>
    memmove(curproc->swap_file_pages, np->swap_file_pages, sizeof(struct page)*16);// TODO: check address correctness
80103f4a:	8d 87 80 01 00 00    	lea    0x180(%edi),%eax
80103f50:	83 c4 0c             	add    $0xc,%esp
80103f53:	68 00 01 00 00       	push   $0x100
80103f58:	50                   	push   %eax
80103f59:	8d 83 80 01 00 00    	lea    0x180(%ebx),%eax
80103f5f:	50                   	push   %eax
80103f60:	e8 fb 0b 00 00       	call   80104b60 <memmove>
80103f65:	83 c4 10             	add    $0x10,%esp
80103f68:	e9 c8 fe ff ff       	jmp    80103e35 <fork+0x55>
    return -1;
80103f6d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f72:	e9 54 ff ff ff       	jmp    80103ecb <fork+0xeb>
    kfree(np->kstack);
80103f77:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103f7a:	83 ec 0c             	sub    $0xc,%esp
80103f7d:	ff 73 08             	pushl  0x8(%ebx)
80103f80:	e8 6b e7 ff ff       	call   801026f0 <kfree>
    np->kstack = 0;
80103f85:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103f8c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103f93:	83 c4 10             	add    $0x10,%esp
80103f96:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f9b:	e9 2b ff ff ff       	jmp    80103ecb <fork+0xeb>

80103fa0 <get_num_of_free_pages>:
int get_num_of_free_pages(){
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	83 ec 08             	sub    $0x8,%esp
  struct run *r = get_first_run();
80103fa6:	e8 35 e7 ff ff       	call   801026e0 <get_first_run>
  while((*r).next != 0){
80103fab:	8b 10                	mov    (%eax),%edx
  int counter = 0;
80103fad:	31 c0                	xor    %eax,%eax
  while((*r).next != 0){
80103faf:	85 d2                	test   %edx,%edx
80103fb1:	74 0e                	je     80103fc1 <get_num_of_free_pages+0x21>
80103fb3:	90                   	nop
80103fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fb8:	8b 12                	mov    (%edx),%edx
    counter++;
80103fba:	83 c0 01             	add    $0x1,%eax
  while((*r).next != 0){
80103fbd:	85 d2                	test   %edx,%edx
80103fbf:	75 f7                	jne    80103fb8 <get_num_of_free_pages+0x18>
}
80103fc1:	c9                   	leave  
80103fc2:	c3                   	ret    
80103fc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fd0 <scheduler>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	57                   	push   %edi
80103fd4:	56                   	push   %esi
80103fd5:	53                   	push   %ebx
80103fd6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103fd9:	e8 c2 fb ff ff       	call   80103ba0 <mycpu>
  c->proc = 0;
80103fde:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103fe5:	00 00 00 
  struct cpu *c = mycpu();
80103fe8:	89 c6                	mov    %eax,%esi
  struct run *r = get_first_run();
80103fea:	e8 f1 e6 ff ff       	call   801026e0 <get_first_run>
  while((*r).next != 0){
80103fef:	8b 10                	mov    (%eax),%edx
  int counter = 0;
80103ff1:	31 c0                	xor    %eax,%eax
  while((*r).next != 0){
80103ff3:	85 d2                	test   %edx,%edx
80103ff5:	74 09                	je     80104000 <scheduler+0x30>
80103ff7:	8b 12                	mov    (%edx),%edx
    counter++;
80103ff9:	83 c0 01             	add    $0x1,%eax
  while((*r).next != 0){
80103ffc:	85 d2                	test   %edx,%edx
80103ffe:	75 f7                	jne    80103ff7 <scheduler+0x27>
80104000:	8d 7e 04             	lea    0x4(%esi),%edi
  num_of_free_pages_after_kernel_load = get_num_of_free_pages(); //TODO: done per processor, check if matter
80104003:	a3 c0 b5 10 80       	mov    %eax,0x8010b5c0
80104008:	90                   	nop
80104009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80104010:	fb                   	sti    
    acquire(&ptable.lock);
80104011:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104014:	bb 94 5d 11 80       	mov    $0x80115d94,%ebx
    acquire(&ptable.lock);
80104019:	68 60 5d 11 80       	push   $0x80115d60
8010401e:	e8 7d 09 00 00       	call   801049a0 <acquire>
80104023:	83 c4 10             	add    $0x10,%esp
80104026:	8d 76 00             	lea    0x0(%esi),%esi
80104029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80104030:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104034:	75 33                	jne    80104069 <scheduler+0x99>
      switchuvm(p);
80104036:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104039:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010403f:	53                   	push   %ebx
80104040:	e8 bb 2e 00 00       	call   80106f00 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104045:	58                   	pop    %eax
80104046:	5a                   	pop    %edx
80104047:	ff 73 1c             	pushl  0x1c(%ebx)
8010404a:	57                   	push   %edi
      p->state = RUNNING;
8010404b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104052:	e8 94 0c 00 00       	call   80104ceb <swtch>
      switchkvm();
80104057:	e8 84 2e 00 00       	call   80106ee0 <switchkvm>
      c->proc = 0;
8010405c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104063:	00 00 00 
80104066:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104069:	81 c3 88 02 00 00    	add    $0x288,%ebx
8010406f:	81 fb 94 ff 11 80    	cmp    $0x8011ff94,%ebx
80104075:	72 b9                	jb     80104030 <scheduler+0x60>
    release(&ptable.lock);
80104077:	83 ec 0c             	sub    $0xc,%esp
8010407a:	68 60 5d 11 80       	push   $0x80115d60
8010407f:	e8 dc 09 00 00       	call   80104a60 <release>
    sti();
80104084:	83 c4 10             	add    $0x10,%esp
80104087:	eb 87                	jmp    80104010 <scheduler+0x40>
80104089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104090 <sched>:
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	56                   	push   %esi
80104094:	53                   	push   %ebx
  pushcli();
80104095:	e8 36 08 00 00       	call   801048d0 <pushcli>
  c = mycpu();
8010409a:	e8 01 fb ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
8010409f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040a5:	e8 66 08 00 00       	call   80104910 <popcli>
  if(!holding(&ptable.lock))
801040aa:	83 ec 0c             	sub    $0xc,%esp
801040ad:	68 60 5d 11 80       	push   $0x80115d60
801040b2:	e8 b9 08 00 00       	call   80104970 <holding>
801040b7:	83 c4 10             	add    $0x10,%esp
801040ba:	85 c0                	test   %eax,%eax
801040bc:	74 4f                	je     8010410d <sched+0x7d>
  if(mycpu()->ncli != 1)
801040be:	e8 dd fa ff ff       	call   80103ba0 <mycpu>
801040c3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801040ca:	75 68                	jne    80104134 <sched+0xa4>
  if(p->state == RUNNING)
801040cc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801040d0:	74 55                	je     80104127 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801040d2:	9c                   	pushf  
801040d3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801040d4:	f6 c4 02             	test   $0x2,%ah
801040d7:	75 41                	jne    8010411a <sched+0x8a>
  intena = mycpu()->intena;
801040d9:	e8 c2 fa ff ff       	call   80103ba0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801040de:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801040e1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801040e7:	e8 b4 fa ff ff       	call   80103ba0 <mycpu>
801040ec:	83 ec 08             	sub    $0x8,%esp
801040ef:	ff 70 04             	pushl  0x4(%eax)
801040f2:	53                   	push   %ebx
801040f3:	e8 f3 0b 00 00       	call   80104ceb <swtch>
  mycpu()->intena = intena;
801040f8:	e8 a3 fa ff ff       	call   80103ba0 <mycpu>
}
801040fd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104100:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104106:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104109:	5b                   	pop    %ebx
8010410a:	5e                   	pop    %esi
8010410b:	5d                   	pop    %ebp
8010410c:	c3                   	ret    
    panic("sched ptable.lock");
8010410d:	83 ec 0c             	sub    $0xc,%esp
80104110:	68 e8 82 10 80       	push   $0x801082e8
80104115:	e8 76 c2 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010411a:	83 ec 0c             	sub    $0xc,%esp
8010411d:	68 14 83 10 80       	push   $0x80108314
80104122:	e8 69 c2 ff ff       	call   80100390 <panic>
    panic("sched running");
80104127:	83 ec 0c             	sub    $0xc,%esp
8010412a:	68 06 83 10 80       	push   $0x80108306
8010412f:	e8 5c c2 ff ff       	call   80100390 <panic>
    panic("sched locks");
80104134:	83 ec 0c             	sub    $0xc,%esp
80104137:	68 fa 82 10 80       	push   $0x801082fa
8010413c:	e8 4f c2 ff ff       	call   80100390 <panic>
80104141:	eb 0d                	jmp    80104150 <exit>
80104143:	90                   	nop
80104144:	90                   	nop
80104145:	90                   	nop
80104146:	90                   	nop
80104147:	90                   	nop
80104148:	90                   	nop
80104149:	90                   	nop
8010414a:	90                   	nop
8010414b:	90                   	nop
8010414c:	90                   	nop
8010414d:	90                   	nop
8010414e:	90                   	nop
8010414f:	90                   	nop

80104150 <exit>:
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	57                   	push   %edi
80104154:	56                   	push   %esi
80104155:	53                   	push   %ebx
80104156:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104159:	e8 72 07 00 00       	call   801048d0 <pushcli>
  c = mycpu();
8010415e:	e8 3d fa ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
80104163:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104169:	e8 a2 07 00 00       	call   80104910 <popcli>
  if(curproc == initproc)
8010416e:	39 35 c4 b5 10 80    	cmp    %esi,0x8010b5c4
80104174:	8d 5e 28             	lea    0x28(%esi),%ebx
80104177:	8d 7e 68             	lea    0x68(%esi),%edi
8010417a:	0f 84 f1 00 00 00    	je     80104271 <exit+0x121>
    if(curproc->ofile[fd]){
80104180:	8b 03                	mov    (%ebx),%eax
80104182:	85 c0                	test   %eax,%eax
80104184:	74 12                	je     80104198 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104186:	83 ec 0c             	sub    $0xc,%esp
80104189:	50                   	push   %eax
8010418a:	e8 f1 cc ff ff       	call   80100e80 <fileclose>
      curproc->ofile[fd] = 0;
8010418f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104195:	83 c4 10             	add    $0x10,%esp
80104198:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
8010419b:	39 fb                	cmp    %edi,%ebx
8010419d:	75 e1                	jne    80104180 <exit+0x30>
  begin_op();
8010419f:	e8 dc ed ff ff       	call   80102f80 <begin_op>
  iput(curproc->cwd);
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	ff 76 68             	pushl  0x68(%esi)
801041aa:	e8 41 d6 ff ff       	call   801017f0 <iput>
  end_op();
801041af:	e8 3c ee ff ff       	call   80102ff0 <end_op>
  curproc->cwd = 0;
801041b4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801041bb:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
801041c2:	e8 d9 07 00 00       	call   801049a0 <acquire>
  wakeup1(curproc->parent);
801041c7:	8b 56 14             	mov    0x14(%esi),%edx
801041ca:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041cd:	b8 94 5d 11 80       	mov    $0x80115d94,%eax
801041d2:	eb 10                	jmp    801041e4 <exit+0x94>
801041d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041d8:	05 88 02 00 00       	add    $0x288,%eax
801041dd:	3d 94 ff 11 80       	cmp    $0x8011ff94,%eax
801041e2:	73 1e                	jae    80104202 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
801041e4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041e8:	75 ee                	jne    801041d8 <exit+0x88>
801041ea:	3b 50 20             	cmp    0x20(%eax),%edx
801041ed:	75 e9                	jne    801041d8 <exit+0x88>
      p->state = RUNNABLE;
801041ef:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041f6:	05 88 02 00 00       	add    $0x288,%eax
801041fb:	3d 94 ff 11 80       	cmp    $0x8011ff94,%eax
80104200:	72 e2                	jb     801041e4 <exit+0x94>
      p->parent = initproc;
80104202:	8b 0d c4 b5 10 80    	mov    0x8010b5c4,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104208:	ba 94 5d 11 80       	mov    $0x80115d94,%edx
8010420d:	eb 0f                	jmp    8010421e <exit+0xce>
8010420f:	90                   	nop
80104210:	81 c2 88 02 00 00    	add    $0x288,%edx
80104216:	81 fa 94 ff 11 80    	cmp    $0x8011ff94,%edx
8010421c:	73 3a                	jae    80104258 <exit+0x108>
    if(p->parent == curproc){
8010421e:	39 72 14             	cmp    %esi,0x14(%edx)
80104221:	75 ed                	jne    80104210 <exit+0xc0>
      if(p->state == ZOMBIE)
80104223:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104227:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010422a:	75 e4                	jne    80104210 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010422c:	b8 94 5d 11 80       	mov    $0x80115d94,%eax
80104231:	eb 11                	jmp    80104244 <exit+0xf4>
80104233:	90                   	nop
80104234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104238:	05 88 02 00 00       	add    $0x288,%eax
8010423d:	3d 94 ff 11 80       	cmp    $0x8011ff94,%eax
80104242:	73 cc                	jae    80104210 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104244:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104248:	75 ee                	jne    80104238 <exit+0xe8>
8010424a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010424d:	75 e9                	jne    80104238 <exit+0xe8>
      p->state = RUNNABLE;
8010424f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104256:	eb e0                	jmp    80104238 <exit+0xe8>
  curproc->state = ZOMBIE;
80104258:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010425f:	e8 2c fe ff ff       	call   80104090 <sched>
  panic("zombie exit");
80104264:	83 ec 0c             	sub    $0xc,%esp
80104267:	68 35 83 10 80       	push   $0x80108335
8010426c:	e8 1f c1 ff ff       	call   80100390 <panic>
    panic("init exiting");
80104271:	83 ec 0c             	sub    $0xc,%esp
80104274:	68 28 83 10 80       	push   $0x80108328
80104279:	e8 12 c1 ff ff       	call   80100390 <panic>
8010427e:	66 90                	xchg   %ax,%ax

80104280 <yield>:
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	53                   	push   %ebx
80104284:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104287:	68 60 5d 11 80       	push   $0x80115d60
8010428c:	e8 0f 07 00 00       	call   801049a0 <acquire>
  pushcli();
80104291:	e8 3a 06 00 00       	call   801048d0 <pushcli>
  c = mycpu();
80104296:	e8 05 f9 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
8010429b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042a1:	e8 6a 06 00 00       	call   80104910 <popcli>
  myproc()->state = RUNNABLE;
801042a6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801042ad:	e8 de fd ff ff       	call   80104090 <sched>
  release(&ptable.lock);
801042b2:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
801042b9:	e8 a2 07 00 00       	call   80104a60 <release>
}
801042be:	83 c4 10             	add    $0x10,%esp
801042c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042c4:	c9                   	leave  
801042c5:	c3                   	ret    
801042c6:	8d 76 00             	lea    0x0(%esi),%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042d0 <sleep>:
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	57                   	push   %edi
801042d4:	56                   	push   %esi
801042d5:	53                   	push   %ebx
801042d6:	83 ec 0c             	sub    $0xc,%esp
801042d9:	8b 7d 08             	mov    0x8(%ebp),%edi
801042dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801042df:	e8 ec 05 00 00       	call   801048d0 <pushcli>
  c = mycpu();
801042e4:	e8 b7 f8 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
801042e9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042ef:	e8 1c 06 00 00       	call   80104910 <popcli>
  if(p == 0)
801042f4:	85 db                	test   %ebx,%ebx
801042f6:	0f 84 87 00 00 00    	je     80104383 <sleep+0xb3>
  if(lk == 0)
801042fc:	85 f6                	test   %esi,%esi
801042fe:	74 76                	je     80104376 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104300:	81 fe 60 5d 11 80    	cmp    $0x80115d60,%esi
80104306:	74 50                	je     80104358 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104308:	83 ec 0c             	sub    $0xc,%esp
8010430b:	68 60 5d 11 80       	push   $0x80115d60
80104310:	e8 8b 06 00 00       	call   801049a0 <acquire>
    release(lk);
80104315:	89 34 24             	mov    %esi,(%esp)
80104318:	e8 43 07 00 00       	call   80104a60 <release>
  p->chan = chan;
8010431d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104320:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104327:	e8 64 fd ff ff       	call   80104090 <sched>
  p->chan = 0;
8010432c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104333:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
8010433a:	e8 21 07 00 00       	call   80104a60 <release>
    acquire(lk);
8010433f:	89 75 08             	mov    %esi,0x8(%ebp)
80104342:	83 c4 10             	add    $0x10,%esp
}
80104345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104348:	5b                   	pop    %ebx
80104349:	5e                   	pop    %esi
8010434a:	5f                   	pop    %edi
8010434b:	5d                   	pop    %ebp
    acquire(lk);
8010434c:	e9 4f 06 00 00       	jmp    801049a0 <acquire>
80104351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104358:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010435b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104362:	e8 29 fd ff ff       	call   80104090 <sched>
  p->chan = 0;
80104367:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010436e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104371:	5b                   	pop    %ebx
80104372:	5e                   	pop    %esi
80104373:	5f                   	pop    %edi
80104374:	5d                   	pop    %ebp
80104375:	c3                   	ret    
    panic("sleep without lk");
80104376:	83 ec 0c             	sub    $0xc,%esp
80104379:	68 47 83 10 80       	push   $0x80108347
8010437e:	e8 0d c0 ff ff       	call   80100390 <panic>
    panic("sleep");
80104383:	83 ec 0c             	sub    $0xc,%esp
80104386:	68 41 83 10 80       	push   $0x80108341
8010438b:	e8 00 c0 ff ff       	call   80100390 <panic>

80104390 <wait>:
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
  pushcli();
80104395:	e8 36 05 00 00       	call   801048d0 <pushcli>
  c = mycpu();
8010439a:	e8 01 f8 ff ff       	call   80103ba0 <mycpu>
  p = c->proc;
8010439f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043a5:	e8 66 05 00 00       	call   80104910 <popcli>
  acquire(&ptable.lock);
801043aa:	83 ec 0c             	sub    $0xc,%esp
801043ad:	68 60 5d 11 80       	push   $0x80115d60
801043b2:	e8 e9 05 00 00       	call   801049a0 <acquire>
801043b7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801043ba:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043bc:	bb 94 5d 11 80       	mov    $0x80115d94,%ebx
801043c1:	eb 13                	jmp    801043d6 <wait+0x46>
801043c3:	90                   	nop
801043c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043c8:	81 c3 88 02 00 00    	add    $0x288,%ebx
801043ce:	81 fb 94 ff 11 80    	cmp    $0x8011ff94,%ebx
801043d4:	73 1e                	jae    801043f4 <wait+0x64>
      if(p->parent != curproc)
801043d6:	39 73 14             	cmp    %esi,0x14(%ebx)
801043d9:	75 ed                	jne    801043c8 <wait+0x38>
      if(p->state == ZOMBIE){
801043db:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801043df:	74 37                	je     80104418 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043e1:	81 c3 88 02 00 00    	add    $0x288,%ebx
      havekids = 1;
801043e7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043ec:	81 fb 94 ff 11 80    	cmp    $0x8011ff94,%ebx
801043f2:	72 e2                	jb     801043d6 <wait+0x46>
    if(!havekids || curproc->killed){
801043f4:	85 c0                	test   %eax,%eax
801043f6:	74 76                	je     8010446e <wait+0xde>
801043f8:	8b 46 24             	mov    0x24(%esi),%eax
801043fb:	85 c0                	test   %eax,%eax
801043fd:	75 6f                	jne    8010446e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801043ff:	83 ec 08             	sub    $0x8,%esp
80104402:	68 60 5d 11 80       	push   $0x80115d60
80104407:	56                   	push   %esi
80104408:	e8 c3 fe ff ff       	call   801042d0 <sleep>
    havekids = 0;
8010440d:	83 c4 10             	add    $0x10,%esp
80104410:	eb a8                	jmp    801043ba <wait+0x2a>
80104412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104418:	83 ec 0c             	sub    $0xc,%esp
8010441b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010441e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104421:	e8 ca e2 ff ff       	call   801026f0 <kfree>
        freevm(p->pgdir);
80104426:	5a                   	pop    %edx
80104427:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010442a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104431:	e8 0a 35 00 00       	call   80107940 <freevm>
        release(&ptable.lock);
80104436:	c7 04 24 60 5d 11 80 	movl   $0x80115d60,(%esp)
        p->pid = 0;
8010443d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104444:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010444b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010444f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104456:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010445d:	e8 fe 05 00 00       	call   80104a60 <release>
        return pid;
80104462:	83 c4 10             	add    $0x10,%esp
}
80104465:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104468:	89 f0                	mov    %esi,%eax
8010446a:	5b                   	pop    %ebx
8010446b:	5e                   	pop    %esi
8010446c:	5d                   	pop    %ebp
8010446d:	c3                   	ret    
      release(&ptable.lock);
8010446e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104471:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104476:	68 60 5d 11 80       	push   $0x80115d60
8010447b:	e8 e0 05 00 00       	call   80104a60 <release>
      return -1;
80104480:	83 c4 10             	add    $0x10,%esp
80104483:	eb e0                	jmp    80104465 <wait+0xd5>
80104485:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104490 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 10             	sub    $0x10,%esp
80104497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010449a:	68 60 5d 11 80       	push   $0x80115d60
8010449f:	e8 fc 04 00 00       	call   801049a0 <acquire>
801044a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044a7:	b8 94 5d 11 80       	mov    $0x80115d94,%eax
801044ac:	eb 0e                	jmp    801044bc <wakeup+0x2c>
801044ae:	66 90                	xchg   %ax,%ax
801044b0:	05 88 02 00 00       	add    $0x288,%eax
801044b5:	3d 94 ff 11 80       	cmp    $0x8011ff94,%eax
801044ba:	73 1e                	jae    801044da <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801044bc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044c0:	75 ee                	jne    801044b0 <wakeup+0x20>
801044c2:	3b 58 20             	cmp    0x20(%eax),%ebx
801044c5:	75 e9                	jne    801044b0 <wakeup+0x20>
      p->state = RUNNABLE;
801044c7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044ce:	05 88 02 00 00       	add    $0x288,%eax
801044d3:	3d 94 ff 11 80       	cmp    $0x8011ff94,%eax
801044d8:	72 e2                	jb     801044bc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801044da:	c7 45 08 60 5d 11 80 	movl   $0x80115d60,0x8(%ebp)
}
801044e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044e4:	c9                   	leave  
  release(&ptable.lock);
801044e5:	e9 76 05 00 00       	jmp    80104a60 <release>
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044f0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
801044f4:	83 ec 10             	sub    $0x10,%esp
801044f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801044fa:	68 60 5d 11 80       	push   $0x80115d60
801044ff:	e8 9c 04 00 00       	call   801049a0 <acquire>
80104504:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104507:	b8 94 5d 11 80       	mov    $0x80115d94,%eax
8010450c:	eb 0e                	jmp    8010451c <kill+0x2c>
8010450e:	66 90                	xchg   %ax,%ax
80104510:	05 88 02 00 00       	add    $0x288,%eax
80104515:	3d 94 ff 11 80       	cmp    $0x8011ff94,%eax
8010451a:	73 34                	jae    80104550 <kill+0x60>
    if(p->pid == pid){
8010451c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010451f:	75 ef                	jne    80104510 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104521:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104525:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010452c:	75 07                	jne    80104535 <kill+0x45>
        p->state = RUNNABLE;
8010452e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104535:	83 ec 0c             	sub    $0xc,%esp
80104538:	68 60 5d 11 80       	push   $0x80115d60
8010453d:	e8 1e 05 00 00       	call   80104a60 <release>
      return 0;
80104542:	83 c4 10             	add    $0x10,%esp
80104545:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104547:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010454a:	c9                   	leave  
8010454b:	c3                   	ret    
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104550:	83 ec 0c             	sub    $0xc,%esp
80104553:	68 60 5d 11 80       	push   $0x80115d60
80104558:	e8 03 05 00 00       	call   80104a60 <release>
  return -1;
8010455d:	83 c4 10             	add    $0x10,%esp
80104560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104565:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104568:	c9                   	leave  
80104569:	c3                   	ret    
8010456a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104570 <get_number_of_used_pages_in_array>:

int get_number_of_used_pages_in_array(struct page *pages_array, int size){
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  int counter = 0;
  for (int i = 0; i < size; i++){
80104576:	85 c9                	test   %ecx,%ecx
80104578:	7e 26                	jle    801045a0 <get_number_of_used_pages_in_array+0x30>
8010457a:	8b 55 08             	mov    0x8(%ebp),%edx
8010457d:	c1 e1 04             	shl    $0x4,%ecx
  int counter = 0;
80104580:	31 c0                	xor    %eax,%eax
80104582:	01 d1                	add    %edx,%ecx
80104584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pages_array[i].state_used){
      counter++;
80104588:	80 3a 01             	cmpb   $0x1,(%edx)
8010458b:	83 d8 ff             	sbb    $0xffffffff,%eax
8010458e:	83 c2 10             	add    $0x10,%edx
  for (int i = 0; i < size; i++){
80104591:	39 ca                	cmp    %ecx,%edx
80104593:	75 f3                	jne    80104588 <get_number_of_used_pages_in_array+0x18>
    }
  }
  return counter;
}
80104595:	5d                   	pop    %ebp
80104596:	c3                   	ret    
80104597:	89 f6                	mov    %esi,%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int counter = 0;
801045a0:	31 c0                	xor    %eax,%eax
}
801045a2:	5d                   	pop    %ebp
801045a3:	c3                   	ret    
801045a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801045b0 <get_number_of_allocated_memory_pages>:

int get_number_of_allocated_memory_pages(struct proc *p){
801045b0:	55                   	push   %ebp
  int counter = 0;
801045b1:	31 c0                	xor    %eax,%eax
int get_number_of_allocated_memory_pages(struct proc *p){
801045b3:	89 e5                	mov    %esp,%ebp
801045b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  return get_number_of_used_pages_in_array(p->main_mem_pages, MAX_PSYC_PAGES);
801045b8:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
801045be:	81 c1 80 01 00 00    	add    $0x180,%ecx
801045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      counter++;
801045c8:	80 3a 01             	cmpb   $0x1,(%edx)
801045cb:	83 d8 ff             	sbb    $0xffffffff,%eax
801045ce:	83 c2 10             	add    $0x10,%edx
  for (int i = 0; i < size; i++){
801045d1:	39 ca                	cmp    %ecx,%edx
801045d3:	75 f3                	jne    801045c8 <get_number_of_allocated_memory_pages+0x18>
}
801045d5:	5d                   	pop    %ebp
801045d6:	c3                   	ret    
801045d7:	89 f6                	mov    %esi,%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045e0 <get_number_of_swaped_out_pages>:

int get_number_of_swaped_out_pages(struct proc *p){
801045e0:	55                   	push   %ebp
  int counter = 0;
801045e1:	31 c0                	xor    %eax,%eax
int get_number_of_swaped_out_pages(struct proc *p){
801045e3:	89 e5                	mov    %esp,%ebp
801045e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  return get_number_of_used_pages_in_array(p->swap_file_pages, MAX_PSYC_PAGES);
801045e8:	8d 91 80 01 00 00    	lea    0x180(%ecx),%edx
801045ee:	81 c1 80 02 00 00    	add    $0x280,%ecx
801045f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      counter++;
801045f8:	80 3a 01             	cmpb   $0x1,(%edx)
801045fb:	83 d8 ff             	sbb    $0xffffffff,%eax
801045fe:	83 c2 10             	add    $0x10,%edx
  for (int i = 0; i < size; i++){
80104601:	39 ca                	cmp    %ecx,%edx
80104603:	75 f3                	jne    801045f8 <get_number_of_swaped_out_pages+0x18>
}
80104605:	5d                   	pop    %ebp
80104606:	c3                   	ret    
80104607:	89 f6                	mov    %esi,%esi
80104609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104610 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	57                   	push   %edi
80104614:	56                   	push   %esi
80104615:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc+2; p < &ptable.proc[NPROC]; p++){ //TODO: remove "+2" it is for debug
80104616:	be a4 62 11 80       	mov    $0x801162a4,%esi
{
8010461b:	83 ec 4c             	sub    $0x4c,%esp
8010461e:	66 90                	xchg   %ax,%ax
    if(p->state == UNUSED)
80104620:	8b 46 0c             	mov    0xc(%esi),%eax
80104623:	85 c0                	test   %eax,%eax
80104625:	0f 84 9c 00 00 00    	je     801046c7 <procdump+0xb7>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010462b:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???"; // TODO: prints 0 pages for sh,init...
8010462e:	bb 58 83 10 80       	mov    $0x80108358,%ebx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104633:	77 11                	ja     80104646 <procdump+0x36>
80104635:	8b 1c 85 0c 84 10 80 	mov    -0x7fef7bf4(,%eax,4),%ebx
      state = "???"; // TODO: prints 0 pages for sh,init...
8010463c:	b8 58 83 10 80       	mov    $0x80108358,%eax
80104641:	85 db                	test   %ebx,%ebx
80104643:	0f 44 d8             	cmove  %eax,%ebx
80104646:	8d 46 6c             	lea    0x6c(%esi),%eax
80104649:	8d 8e 80 01 00 00    	lea    0x180(%esi),%ecx
8010464f:	8d be 80 02 00 00    	lea    0x280(%esi),%edi
  int counter = 0;
80104655:	31 d2                	xor    %edx,%edx
80104657:	89 45 ac             	mov    %eax,-0x54(%ebp)
    cprintf("%d %s <allocated memory pages %d> <paged out %d> <page faults %d> <total paged out %d> %s\n", p->pid, state, 
8010465a:	8b 86 84 02 00 00    	mov    0x284(%esi),%eax
80104660:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104663:	8b 86 80 02 00 00    	mov    0x280(%esi),%eax
80104669:	89 45 b0             	mov    %eax,-0x50(%ebp)
8010466c:	89 c8                	mov    %ecx,%eax
8010466e:	66 90                	xchg   %ax,%ax
      counter++;
80104670:	80 38 01             	cmpb   $0x1,(%eax)
80104673:	83 da ff             	sbb    $0xffffffff,%edx
80104676:	83 c0 10             	add    $0x10,%eax
  for (int i = 0; i < size; i++){
80104679:	39 f8                	cmp    %edi,%eax
8010467b:	75 f3                	jne    80104670 <procdump+0x60>
8010467d:	8d 86 80 00 00 00    	lea    0x80(%esi),%eax
  int counter = 0;
80104683:	31 ff                	xor    %edi,%edi
80104685:	8d 76 00             	lea    0x0(%esi),%esi
      counter++;
80104688:	80 38 01             	cmpb   $0x1,(%eax)
8010468b:	83 df ff             	sbb    $0xffffffff,%edi
8010468e:	83 c0 10             	add    $0x10,%eax
  for (int i = 0; i < size; i++){
80104691:	39 c8                	cmp    %ecx,%eax
80104693:	75 f3                	jne    80104688 <procdump+0x78>
    cprintf("%d %s <allocated memory pages %d> <paged out %d> <page faults %d> <total paged out %d> %s\n", p->pid, state, 
80104695:	ff 75 ac             	pushl  -0x54(%ebp)
80104698:	ff 75 b4             	pushl  -0x4c(%ebp)
8010469b:	ff 75 b0             	pushl  -0x50(%ebp)
8010469e:	52                   	push   %edx
8010469f:	57                   	push   %edi
801046a0:	53                   	push   %ebx
801046a1:	ff 76 10             	pushl  0x10(%esi)
801046a4:	68 b0 83 10 80       	push   $0x801083b0
801046a9:	e8 b2 bf ff ff       	call   80100660 <cprintf>
      get_number_of_allocated_memory_pages(p), get_number_of_swaped_out_pages(p), p->page_fault_counter,
      p->swaps_out_counter, p->name);
    if(p->state == SLEEPING){
801046ae:	83 c4 20             	add    $0x20,%esp
801046b1:	83 7e 0c 02          	cmpl   $0x2,0xc(%esi)
801046b5:	74 2a                	je     801046e1 <procdump+0xd1>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801046b7:	83 ec 0c             	sub    $0xc,%esp
801046ba:	68 23 87 10 80       	push   $0x80108723
801046bf:	e8 9c bf ff ff       	call   80100660 <cprintf>
801046c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc+2; p < &ptable.proc[NPROC]; p++){ //TODO: remove "+2" it is for debug
801046c7:	81 c6 88 02 00 00    	add    $0x288,%esi
801046cd:	81 fe 94 ff 11 80    	cmp    $0x8011ff94,%esi
801046d3:	0f 82 47 ff ff ff    	jb     80104620 <procdump+0x10>
  }
}
801046d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046dc:	5b                   	pop    %ebx
801046dd:	5e                   	pop    %esi
801046de:	5f                   	pop    %edi
801046df:	5d                   	pop    %ebp
801046e0:	c3                   	ret    
      getcallerpcs((uint*)p->context->ebp+2, pc);
801046e1:	8d 45 c0             	lea    -0x40(%ebp),%eax
801046e4:	83 ec 08             	sub    $0x8,%esp
801046e7:	8d 5d c0             	lea    -0x40(%ebp),%ebx
801046ea:	50                   	push   %eax
801046eb:	8b 46 1c             	mov    0x1c(%esi),%eax
801046ee:	8b 40 0c             	mov    0xc(%eax),%eax
801046f1:	83 c0 08             	add    $0x8,%eax
801046f4:	50                   	push   %eax
801046f5:	e8 86 01 00 00       	call   80104880 <getcallerpcs>
801046fa:	83 c4 10             	add    $0x10,%esp
801046fd:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104700:	8b 03                	mov    (%ebx),%eax
80104702:	85 c0                	test   %eax,%eax
80104704:	74 b1                	je     801046b7 <procdump+0xa7>
        cprintf(" %p", pc[i]);
80104706:	83 ec 08             	sub    $0x8,%esp
80104709:	83 c3 04             	add    $0x4,%ebx
8010470c:	50                   	push   %eax
8010470d:	68 41 7d 10 80       	push   $0x80107d41
80104712:	e8 49 bf ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104717:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010471a:	83 c4 10             	add    $0x10,%esp
8010471d:	39 d8                	cmp    %ebx,%eax
8010471f:	75 df                	jne    80104700 <procdump+0xf0>
80104721:	eb 94                	jmp    801046b7 <procdump+0xa7>
80104723:	66 90                	xchg   %ax,%ax
80104725:	66 90                	xchg   %ax,%ax
80104727:	66 90                	xchg   %ax,%ax
80104729:	66 90                	xchg   %ax,%ax
8010472b:	66 90                	xchg   %ax,%ax
8010472d:	66 90                	xchg   %ax,%ax
8010472f:	90                   	nop

80104730 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	53                   	push   %ebx
80104734:	83 ec 0c             	sub    $0xc,%esp
80104737:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010473a:	68 24 84 10 80       	push   $0x80108424
8010473f:	8d 43 04             	lea    0x4(%ebx),%eax
80104742:	50                   	push   %eax
80104743:	e8 18 01 00 00       	call   80104860 <initlock>
  lk->name = name;
80104748:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010474b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104751:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104754:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010475b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010475e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104761:	c9                   	leave  
80104762:	c3                   	ret    
80104763:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104770 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	56                   	push   %esi
80104774:	53                   	push   %ebx
80104775:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104778:	83 ec 0c             	sub    $0xc,%esp
8010477b:	8d 73 04             	lea    0x4(%ebx),%esi
8010477e:	56                   	push   %esi
8010477f:	e8 1c 02 00 00       	call   801049a0 <acquire>
  while (lk->locked) {
80104784:	8b 13                	mov    (%ebx),%edx
80104786:	83 c4 10             	add    $0x10,%esp
80104789:	85 d2                	test   %edx,%edx
8010478b:	74 16                	je     801047a3 <acquiresleep+0x33>
8010478d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104790:	83 ec 08             	sub    $0x8,%esp
80104793:	56                   	push   %esi
80104794:	53                   	push   %ebx
80104795:	e8 36 fb ff ff       	call   801042d0 <sleep>
  while (lk->locked) {
8010479a:	8b 03                	mov    (%ebx),%eax
8010479c:	83 c4 10             	add    $0x10,%esp
8010479f:	85 c0                	test   %eax,%eax
801047a1:	75 ed                	jne    80104790 <acquiresleep+0x20>
  }
  lk->locked = 1;
801047a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801047a9:	e8 92 f4 ff ff       	call   80103c40 <myproc>
801047ae:	8b 40 10             	mov    0x10(%eax),%eax
801047b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801047b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801047b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047ba:	5b                   	pop    %ebx
801047bb:	5e                   	pop    %esi
801047bc:	5d                   	pop    %ebp
  release(&lk->lk);
801047bd:	e9 9e 02 00 00       	jmp    80104a60 <release>
801047c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047d0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	56                   	push   %esi
801047d4:	53                   	push   %ebx
801047d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801047d8:	83 ec 0c             	sub    $0xc,%esp
801047db:	8d 73 04             	lea    0x4(%ebx),%esi
801047de:	56                   	push   %esi
801047df:	e8 bc 01 00 00       	call   801049a0 <acquire>
  lk->locked = 0;
801047e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801047ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801047f1:	89 1c 24             	mov    %ebx,(%esp)
801047f4:	e8 97 fc ff ff       	call   80104490 <wakeup>
  release(&lk->lk);
801047f9:	89 75 08             	mov    %esi,0x8(%ebp)
801047fc:	83 c4 10             	add    $0x10,%esp
}
801047ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104802:	5b                   	pop    %ebx
80104803:	5e                   	pop    %esi
80104804:	5d                   	pop    %ebp
  release(&lk->lk);
80104805:	e9 56 02 00 00       	jmp    80104a60 <release>
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104810 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	53                   	push   %ebx
80104816:	31 ff                	xor    %edi,%edi
80104818:	83 ec 18             	sub    $0x18,%esp
8010481b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010481e:	8d 73 04             	lea    0x4(%ebx),%esi
80104821:	56                   	push   %esi
80104822:	e8 79 01 00 00       	call   801049a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104827:	8b 03                	mov    (%ebx),%eax
80104829:	83 c4 10             	add    $0x10,%esp
8010482c:	85 c0                	test   %eax,%eax
8010482e:	74 13                	je     80104843 <holdingsleep+0x33>
80104830:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104833:	e8 08 f4 ff ff       	call   80103c40 <myproc>
80104838:	39 58 10             	cmp    %ebx,0x10(%eax)
8010483b:	0f 94 c0             	sete   %al
8010483e:	0f b6 c0             	movzbl %al,%eax
80104841:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104843:	83 ec 0c             	sub    $0xc,%esp
80104846:	56                   	push   %esi
80104847:	e8 14 02 00 00       	call   80104a60 <release>
  return r;
}
8010484c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010484f:	89 f8                	mov    %edi,%eax
80104851:	5b                   	pop    %ebx
80104852:	5e                   	pop    %esi
80104853:	5f                   	pop    %edi
80104854:	5d                   	pop    %ebp
80104855:	c3                   	ret    
80104856:	66 90                	xchg   %ax,%ax
80104858:	66 90                	xchg   %ax,%ax
8010485a:	66 90                	xchg   %ax,%ax
8010485c:	66 90                	xchg   %ax,%ax
8010485e:	66 90                	xchg   %ax,%ax

80104860 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104866:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104869:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010486f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104872:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104879:	5d                   	pop    %ebp
8010487a:	c3                   	ret    
8010487b:	90                   	nop
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104880:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104881:	31 d2                	xor    %edx,%edx
{
80104883:	89 e5                	mov    %esp,%ebp
80104885:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104886:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104889:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010488c:	83 e8 08             	sub    $0x8,%eax
8010488f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104890:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104896:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010489c:	77 1a                	ja     801048b8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010489e:	8b 58 04             	mov    0x4(%eax),%ebx
801048a1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801048a4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801048a7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801048a9:	83 fa 0a             	cmp    $0xa,%edx
801048ac:	75 e2                	jne    80104890 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801048ae:	5b                   	pop    %ebx
801048af:	5d                   	pop    %ebp
801048b0:	c3                   	ret    
801048b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801048bb:	83 c1 28             	add    $0x28,%ecx
801048be:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801048c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801048c6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801048c9:	39 c1                	cmp    %eax,%ecx
801048cb:	75 f3                	jne    801048c0 <getcallerpcs+0x40>
}
801048cd:	5b                   	pop    %ebx
801048ce:	5d                   	pop    %ebp
801048cf:	c3                   	ret    

801048d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	53                   	push   %ebx
801048d4:	83 ec 04             	sub    $0x4,%esp
801048d7:	9c                   	pushf  
801048d8:	5b                   	pop    %ebx
  asm volatile("cli");
801048d9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801048da:	e8 c1 f2 ff ff       	call   80103ba0 <mycpu>
801048df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801048e5:	85 c0                	test   %eax,%eax
801048e7:	75 11                	jne    801048fa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801048e9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801048ef:	e8 ac f2 ff ff       	call   80103ba0 <mycpu>
801048f4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801048fa:	e8 a1 f2 ff ff       	call   80103ba0 <mycpu>
801048ff:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104906:	83 c4 04             	add    $0x4,%esp
80104909:	5b                   	pop    %ebx
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <popcli>:

void
popcli(void)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104916:	9c                   	pushf  
80104917:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104918:	f6 c4 02             	test   $0x2,%ah
8010491b:	75 35                	jne    80104952 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010491d:	e8 7e f2 ff ff       	call   80103ba0 <mycpu>
80104922:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104929:	78 34                	js     8010495f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010492b:	e8 70 f2 ff ff       	call   80103ba0 <mycpu>
80104930:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104936:	85 d2                	test   %edx,%edx
80104938:	74 06                	je     80104940 <popcli+0x30>
    sti();
}
8010493a:	c9                   	leave  
8010493b:	c3                   	ret    
8010493c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104940:	e8 5b f2 ff ff       	call   80103ba0 <mycpu>
80104945:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010494b:	85 c0                	test   %eax,%eax
8010494d:	74 eb                	je     8010493a <popcli+0x2a>
  asm volatile("sti");
8010494f:	fb                   	sti    
}
80104950:	c9                   	leave  
80104951:	c3                   	ret    
    panic("popcli - interruptible");
80104952:	83 ec 0c             	sub    $0xc,%esp
80104955:	68 2f 84 10 80       	push   $0x8010842f
8010495a:	e8 31 ba ff ff       	call   80100390 <panic>
    panic("popcli");
8010495f:	83 ec 0c             	sub    $0xc,%esp
80104962:	68 46 84 10 80       	push   $0x80108446
80104967:	e8 24 ba ff ff       	call   80100390 <panic>
8010496c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104970 <holding>:
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
80104975:	8b 75 08             	mov    0x8(%ebp),%esi
80104978:	31 db                	xor    %ebx,%ebx
  pushcli();
8010497a:	e8 51 ff ff ff       	call   801048d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010497f:	8b 06                	mov    (%esi),%eax
80104981:	85 c0                	test   %eax,%eax
80104983:	74 10                	je     80104995 <holding+0x25>
80104985:	8b 5e 08             	mov    0x8(%esi),%ebx
80104988:	e8 13 f2 ff ff       	call   80103ba0 <mycpu>
8010498d:	39 c3                	cmp    %eax,%ebx
8010498f:	0f 94 c3             	sete   %bl
80104992:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104995:	e8 76 ff ff ff       	call   80104910 <popcli>
}
8010499a:	89 d8                	mov    %ebx,%eax
8010499c:	5b                   	pop    %ebx
8010499d:	5e                   	pop    %esi
8010499e:	5d                   	pop    %ebp
8010499f:	c3                   	ret    

801049a0 <acquire>:
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	56                   	push   %esi
801049a4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801049a5:	e8 26 ff ff ff       	call   801048d0 <pushcli>
  if(holding(lk))
801049aa:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049ad:	83 ec 0c             	sub    $0xc,%esp
801049b0:	53                   	push   %ebx
801049b1:	e8 ba ff ff ff       	call   80104970 <holding>
801049b6:	83 c4 10             	add    $0x10,%esp
801049b9:	85 c0                	test   %eax,%eax
801049bb:	0f 85 83 00 00 00    	jne    80104a44 <acquire+0xa4>
801049c1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801049c3:	ba 01 00 00 00       	mov    $0x1,%edx
801049c8:	eb 09                	jmp    801049d3 <acquire+0x33>
801049ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049d3:	89 d0                	mov    %edx,%eax
801049d5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801049d8:	85 c0                	test   %eax,%eax
801049da:	75 f4                	jne    801049d0 <acquire+0x30>
  __sync_synchronize();
801049dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801049e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049e4:	e8 b7 f1 ff ff       	call   80103ba0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801049e9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801049ec:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801049ef:	89 e8                	mov    %ebp,%eax
801049f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801049f8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801049fe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104a04:	77 1a                	ja     80104a20 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104a06:	8b 48 04             	mov    0x4(%eax),%ecx
80104a09:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104a0c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104a0f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104a11:	83 fe 0a             	cmp    $0xa,%esi
80104a14:	75 e2                	jne    801049f8 <acquire+0x58>
}
80104a16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a19:	5b                   	pop    %ebx
80104a1a:	5e                   	pop    %esi
80104a1b:	5d                   	pop    %ebp
80104a1c:	c3                   	ret    
80104a1d:	8d 76 00             	lea    0x0(%esi),%esi
80104a20:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104a23:	83 c2 28             	add    $0x28,%edx
80104a26:	8d 76 00             	lea    0x0(%esi),%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104a30:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104a36:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104a39:	39 d0                	cmp    %edx,%eax
80104a3b:	75 f3                	jne    80104a30 <acquire+0x90>
}
80104a3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a40:	5b                   	pop    %ebx
80104a41:	5e                   	pop    %esi
80104a42:	5d                   	pop    %ebp
80104a43:	c3                   	ret    
    panic("acquire");
80104a44:	83 ec 0c             	sub    $0xc,%esp
80104a47:	68 4d 84 10 80       	push   $0x8010844d
80104a4c:	e8 3f b9 ff ff       	call   80100390 <panic>
80104a51:	eb 0d                	jmp    80104a60 <release>
80104a53:	90                   	nop
80104a54:	90                   	nop
80104a55:	90                   	nop
80104a56:	90                   	nop
80104a57:	90                   	nop
80104a58:	90                   	nop
80104a59:	90                   	nop
80104a5a:	90                   	nop
80104a5b:	90                   	nop
80104a5c:	90                   	nop
80104a5d:	90                   	nop
80104a5e:	90                   	nop
80104a5f:	90                   	nop

80104a60 <release>:
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	53                   	push   %ebx
80104a64:	83 ec 10             	sub    $0x10,%esp
80104a67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104a6a:	53                   	push   %ebx
80104a6b:	e8 00 ff ff ff       	call   80104970 <holding>
80104a70:	83 c4 10             	add    $0x10,%esp
80104a73:	85 c0                	test   %eax,%eax
80104a75:	74 22                	je     80104a99 <release+0x39>
  lk->pcs[0] = 0;
80104a77:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104a7e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104a85:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104a8a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104a90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a93:	c9                   	leave  
  popcli();
80104a94:	e9 77 fe ff ff       	jmp    80104910 <popcli>
    panic("release");
80104a99:	83 ec 0c             	sub    $0xc,%esp
80104a9c:	68 55 84 10 80       	push   $0x80108455
80104aa1:	e8 ea b8 ff ff       	call   80100390 <panic>
80104aa6:	66 90                	xchg   %ax,%ax
80104aa8:	66 90                	xchg   %ax,%ax
80104aaa:	66 90                	xchg   %ax,%ax
80104aac:	66 90                	xchg   %ax,%ax
80104aae:	66 90                	xchg   %ax,%ax

80104ab0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104ab0:	55                   	push   %ebp
80104ab1:	89 e5                	mov    %esp,%ebp
80104ab3:	57                   	push   %edi
80104ab4:	53                   	push   %ebx
80104ab5:	8b 55 08             	mov    0x8(%ebp),%edx
80104ab8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104abb:	f6 c2 03             	test   $0x3,%dl
80104abe:	75 05                	jne    80104ac5 <memset+0x15>
80104ac0:	f6 c1 03             	test   $0x3,%cl
80104ac3:	74 13                	je     80104ad8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104ac5:	89 d7                	mov    %edx,%edi
80104ac7:	8b 45 0c             	mov    0xc(%ebp),%eax
80104aca:	fc                   	cld    
80104acb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104acd:	5b                   	pop    %ebx
80104ace:	89 d0                	mov    %edx,%eax
80104ad0:	5f                   	pop    %edi
80104ad1:	5d                   	pop    %ebp
80104ad2:	c3                   	ret    
80104ad3:	90                   	nop
80104ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104ad8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104adc:	c1 e9 02             	shr    $0x2,%ecx
80104adf:	89 f8                	mov    %edi,%eax
80104ae1:	89 fb                	mov    %edi,%ebx
80104ae3:	c1 e0 18             	shl    $0x18,%eax
80104ae6:	c1 e3 10             	shl    $0x10,%ebx
80104ae9:	09 d8                	or     %ebx,%eax
80104aeb:	09 f8                	or     %edi,%eax
80104aed:	c1 e7 08             	shl    $0x8,%edi
80104af0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104af2:	89 d7                	mov    %edx,%edi
80104af4:	fc                   	cld    
80104af5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104af7:	5b                   	pop    %ebx
80104af8:	89 d0                	mov    %edx,%eax
80104afa:	5f                   	pop    %edi
80104afb:	5d                   	pop    %ebp
80104afc:	c3                   	ret    
80104afd:	8d 76 00             	lea    0x0(%esi),%esi

80104b00 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	57                   	push   %edi
80104b04:	56                   	push   %esi
80104b05:	53                   	push   %ebx
80104b06:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104b09:	8b 75 08             	mov    0x8(%ebp),%esi
80104b0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104b0f:	85 db                	test   %ebx,%ebx
80104b11:	74 29                	je     80104b3c <memcmp+0x3c>
    if(*s1 != *s2)
80104b13:	0f b6 16             	movzbl (%esi),%edx
80104b16:	0f b6 0f             	movzbl (%edi),%ecx
80104b19:	38 d1                	cmp    %dl,%cl
80104b1b:	75 2b                	jne    80104b48 <memcmp+0x48>
80104b1d:	b8 01 00 00 00       	mov    $0x1,%eax
80104b22:	eb 14                	jmp    80104b38 <memcmp+0x38>
80104b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b28:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104b2c:	83 c0 01             	add    $0x1,%eax
80104b2f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104b34:	38 ca                	cmp    %cl,%dl
80104b36:	75 10                	jne    80104b48 <memcmp+0x48>
  while(n-- > 0){
80104b38:	39 d8                	cmp    %ebx,%eax
80104b3a:	75 ec                	jne    80104b28 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104b3c:	5b                   	pop    %ebx
  return 0;
80104b3d:	31 c0                	xor    %eax,%eax
}
80104b3f:	5e                   	pop    %esi
80104b40:	5f                   	pop    %edi
80104b41:	5d                   	pop    %ebp
80104b42:	c3                   	ret    
80104b43:	90                   	nop
80104b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104b48:	0f b6 c2             	movzbl %dl,%eax
}
80104b4b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104b4c:	29 c8                	sub    %ecx,%eax
}
80104b4e:	5e                   	pop    %esi
80104b4f:	5f                   	pop    %edi
80104b50:	5d                   	pop    %ebp
80104b51:	c3                   	ret    
80104b52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b60 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	56                   	push   %esi
80104b64:	53                   	push   %ebx
80104b65:	8b 45 08             	mov    0x8(%ebp),%eax
80104b68:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104b6b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104b6e:	39 c3                	cmp    %eax,%ebx
80104b70:	73 26                	jae    80104b98 <memmove+0x38>
80104b72:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104b75:	39 c8                	cmp    %ecx,%eax
80104b77:	73 1f                	jae    80104b98 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104b79:	85 f6                	test   %esi,%esi
80104b7b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104b7e:	74 0f                	je     80104b8f <memmove+0x2f>
      *--d = *--s;
80104b80:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104b84:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104b87:	83 ea 01             	sub    $0x1,%edx
80104b8a:	83 fa ff             	cmp    $0xffffffff,%edx
80104b8d:	75 f1                	jne    80104b80 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104b8f:	5b                   	pop    %ebx
80104b90:	5e                   	pop    %esi
80104b91:	5d                   	pop    %ebp
80104b92:	c3                   	ret    
80104b93:	90                   	nop
80104b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104b98:	31 d2                	xor    %edx,%edx
80104b9a:	85 f6                	test   %esi,%esi
80104b9c:	74 f1                	je     80104b8f <memmove+0x2f>
80104b9e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104ba0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104ba4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104ba7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104baa:	39 d6                	cmp    %edx,%esi
80104bac:	75 f2                	jne    80104ba0 <memmove+0x40>
}
80104bae:	5b                   	pop    %ebx
80104baf:	5e                   	pop    %esi
80104bb0:	5d                   	pop    %ebp
80104bb1:	c3                   	ret    
80104bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bc0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104bc3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104bc4:	eb 9a                	jmp    80104b60 <memmove>
80104bc6:	8d 76 00             	lea    0x0(%esi),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	57                   	push   %edi
80104bd4:	56                   	push   %esi
80104bd5:	8b 7d 10             	mov    0x10(%ebp),%edi
80104bd8:	53                   	push   %ebx
80104bd9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104bdc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104bdf:	85 ff                	test   %edi,%edi
80104be1:	74 2f                	je     80104c12 <strncmp+0x42>
80104be3:	0f b6 01             	movzbl (%ecx),%eax
80104be6:	0f b6 1e             	movzbl (%esi),%ebx
80104be9:	84 c0                	test   %al,%al
80104beb:	74 37                	je     80104c24 <strncmp+0x54>
80104bed:	38 c3                	cmp    %al,%bl
80104bef:	75 33                	jne    80104c24 <strncmp+0x54>
80104bf1:	01 f7                	add    %esi,%edi
80104bf3:	eb 13                	jmp    80104c08 <strncmp+0x38>
80104bf5:	8d 76 00             	lea    0x0(%esi),%esi
80104bf8:	0f b6 01             	movzbl (%ecx),%eax
80104bfb:	84 c0                	test   %al,%al
80104bfd:	74 21                	je     80104c20 <strncmp+0x50>
80104bff:	0f b6 1a             	movzbl (%edx),%ebx
80104c02:	89 d6                	mov    %edx,%esi
80104c04:	38 d8                	cmp    %bl,%al
80104c06:	75 1c                	jne    80104c24 <strncmp+0x54>
    n--, p++, q++;
80104c08:	8d 56 01             	lea    0x1(%esi),%edx
80104c0b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104c0e:	39 fa                	cmp    %edi,%edx
80104c10:	75 e6                	jne    80104bf8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104c12:	5b                   	pop    %ebx
    return 0;
80104c13:	31 c0                	xor    %eax,%eax
}
80104c15:	5e                   	pop    %esi
80104c16:	5f                   	pop    %edi
80104c17:	5d                   	pop    %ebp
80104c18:	c3                   	ret    
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c20:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104c24:	29 d8                	sub    %ebx,%eax
}
80104c26:	5b                   	pop    %ebx
80104c27:	5e                   	pop    %esi
80104c28:	5f                   	pop    %edi
80104c29:	5d                   	pop    %ebp
80104c2a:	c3                   	ret    
80104c2b:	90                   	nop
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c30 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	56                   	push   %esi
80104c34:	53                   	push   %ebx
80104c35:	8b 45 08             	mov    0x8(%ebp),%eax
80104c38:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104c3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104c3e:	89 c2                	mov    %eax,%edx
80104c40:	eb 19                	jmp    80104c5b <strncpy+0x2b>
80104c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c48:	83 c3 01             	add    $0x1,%ebx
80104c4b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104c4f:	83 c2 01             	add    $0x1,%edx
80104c52:	84 c9                	test   %cl,%cl
80104c54:	88 4a ff             	mov    %cl,-0x1(%edx)
80104c57:	74 09                	je     80104c62 <strncpy+0x32>
80104c59:	89 f1                	mov    %esi,%ecx
80104c5b:	85 c9                	test   %ecx,%ecx
80104c5d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104c60:	7f e6                	jg     80104c48 <strncpy+0x18>
    ;
  while(n-- > 0)
80104c62:	31 c9                	xor    %ecx,%ecx
80104c64:	85 f6                	test   %esi,%esi
80104c66:	7e 17                	jle    80104c7f <strncpy+0x4f>
80104c68:	90                   	nop
80104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104c70:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104c74:	89 f3                	mov    %esi,%ebx
80104c76:	83 c1 01             	add    $0x1,%ecx
80104c79:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104c7b:	85 db                	test   %ebx,%ebx
80104c7d:	7f f1                	jg     80104c70 <strncpy+0x40>
  return os;
}
80104c7f:	5b                   	pop    %ebx
80104c80:	5e                   	pop    %esi
80104c81:	5d                   	pop    %ebp
80104c82:	c3                   	ret    
80104c83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	56                   	push   %esi
80104c94:	53                   	push   %ebx
80104c95:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104c98:	8b 45 08             	mov    0x8(%ebp),%eax
80104c9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104c9e:	85 c9                	test   %ecx,%ecx
80104ca0:	7e 26                	jle    80104cc8 <safestrcpy+0x38>
80104ca2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104ca6:	89 c1                	mov    %eax,%ecx
80104ca8:	eb 17                	jmp    80104cc1 <safestrcpy+0x31>
80104caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104cb0:	83 c2 01             	add    $0x1,%edx
80104cb3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104cb7:	83 c1 01             	add    $0x1,%ecx
80104cba:	84 db                	test   %bl,%bl
80104cbc:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104cbf:	74 04                	je     80104cc5 <safestrcpy+0x35>
80104cc1:	39 f2                	cmp    %esi,%edx
80104cc3:	75 eb                	jne    80104cb0 <safestrcpy+0x20>
    ;
  *s = 0;
80104cc5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104cc8:	5b                   	pop    %ebx
80104cc9:	5e                   	pop    %esi
80104cca:	5d                   	pop    %ebp
80104ccb:	c3                   	ret    
80104ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cd0 <strlen>:

int
strlen(const char *s)
{
80104cd0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104cd1:	31 c0                	xor    %eax,%eax
{
80104cd3:	89 e5                	mov    %esp,%ebp
80104cd5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104cd8:	80 3a 00             	cmpb   $0x0,(%edx)
80104cdb:	74 0c                	je     80104ce9 <strlen+0x19>
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi
80104ce0:	83 c0 01             	add    $0x1,%eax
80104ce3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104ce7:	75 f7                	jne    80104ce0 <strlen+0x10>
    ;
  return n;
}
80104ce9:	5d                   	pop    %ebp
80104cea:	c3                   	ret    

80104ceb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104ceb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104cef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104cf3:	55                   	push   %ebp
  pushl %ebx
80104cf4:	53                   	push   %ebx
  pushl %esi
80104cf5:	56                   	push   %esi
  pushl %edi
80104cf6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104cf7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104cf9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104cfb:	5f                   	pop    %edi
  popl %esi
80104cfc:	5e                   	pop    %esi
  popl %ebx
80104cfd:	5b                   	pop    %ebx
  popl %ebp
80104cfe:	5d                   	pop    %ebp
  ret
80104cff:	c3                   	ret    

80104d00 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	53                   	push   %ebx
80104d04:	83 ec 04             	sub    $0x4,%esp
80104d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104d0a:	e8 31 ef ff ff       	call   80103c40 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d0f:	8b 00                	mov    (%eax),%eax
80104d11:	39 d8                	cmp    %ebx,%eax
80104d13:	76 1b                	jbe    80104d30 <fetchint+0x30>
80104d15:	8d 53 04             	lea    0x4(%ebx),%edx
80104d18:	39 d0                	cmp    %edx,%eax
80104d1a:	72 14                	jb     80104d30 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d1f:	8b 13                	mov    (%ebx),%edx
80104d21:	89 10                	mov    %edx,(%eax)
  return 0;
80104d23:	31 c0                	xor    %eax,%eax
}
80104d25:	83 c4 04             	add    $0x4,%esp
80104d28:	5b                   	pop    %ebx
80104d29:	5d                   	pop    %ebp
80104d2a:	c3                   	ret    
80104d2b:	90                   	nop
80104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d35:	eb ee                	jmp    80104d25 <fetchint+0x25>
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	53                   	push   %ebx
80104d44:	83 ec 04             	sub    $0x4,%esp
80104d47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104d4a:	e8 f1 ee ff ff       	call   80103c40 <myproc>

  if(addr >= curproc->sz)
80104d4f:	39 18                	cmp    %ebx,(%eax)
80104d51:	76 29                	jbe    80104d7c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104d53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104d56:	89 da                	mov    %ebx,%edx
80104d58:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104d5a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104d5c:	39 c3                	cmp    %eax,%ebx
80104d5e:	73 1c                	jae    80104d7c <fetchstr+0x3c>
    if(*s == 0)
80104d60:	80 3b 00             	cmpb   $0x0,(%ebx)
80104d63:	75 10                	jne    80104d75 <fetchstr+0x35>
80104d65:	eb 39                	jmp    80104da0 <fetchstr+0x60>
80104d67:	89 f6                	mov    %esi,%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d70:	80 3a 00             	cmpb   $0x0,(%edx)
80104d73:	74 1b                	je     80104d90 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104d75:	83 c2 01             	add    $0x1,%edx
80104d78:	39 d0                	cmp    %edx,%eax
80104d7a:	77 f4                	ja     80104d70 <fetchstr+0x30>
    return -1;
80104d7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104d81:	83 c4 04             	add    $0x4,%esp
80104d84:	5b                   	pop    %ebx
80104d85:	5d                   	pop    %ebp
80104d86:	c3                   	ret    
80104d87:	89 f6                	mov    %esi,%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104d90:	83 c4 04             	add    $0x4,%esp
80104d93:	89 d0                	mov    %edx,%eax
80104d95:	29 d8                	sub    %ebx,%eax
80104d97:	5b                   	pop    %ebx
80104d98:	5d                   	pop    %ebp
80104d99:	c3                   	ret    
80104d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104da0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104da2:	eb dd                	jmp    80104d81 <fetchstr+0x41>
80104da4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104daa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104db0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104db5:	e8 86 ee ff ff       	call   80103c40 <myproc>
80104dba:	8b 40 18             	mov    0x18(%eax),%eax
80104dbd:	8b 55 08             	mov    0x8(%ebp),%edx
80104dc0:	8b 40 44             	mov    0x44(%eax),%eax
80104dc3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104dc6:	e8 75 ee ff ff       	call   80103c40 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104dcb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104dcd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104dd0:	39 c6                	cmp    %eax,%esi
80104dd2:	73 1c                	jae    80104df0 <argint+0x40>
80104dd4:	8d 53 08             	lea    0x8(%ebx),%edx
80104dd7:	39 d0                	cmp    %edx,%eax
80104dd9:	72 15                	jb     80104df0 <argint+0x40>
  *ip = *(int*)(addr);
80104ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104dde:	8b 53 04             	mov    0x4(%ebx),%edx
80104de1:	89 10                	mov    %edx,(%eax)
  return 0;
80104de3:	31 c0                	xor    %eax,%eax
}
80104de5:	5b                   	pop    %ebx
80104de6:	5e                   	pop    %esi
80104de7:	5d                   	pop    %ebp
80104de8:	c3                   	ret    
80104de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104df5:	eb ee                	jmp    80104de5 <argint+0x35>
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	56                   	push   %esi
80104e04:	53                   	push   %ebx
80104e05:	83 ec 10             	sub    $0x10,%esp
80104e08:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104e0b:	e8 30 ee ff ff       	call   80103c40 <myproc>
80104e10:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104e12:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e15:	83 ec 08             	sub    $0x8,%esp
80104e18:	50                   	push   %eax
80104e19:	ff 75 08             	pushl  0x8(%ebp)
80104e1c:	e8 8f ff ff ff       	call   80104db0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104e21:	83 c4 10             	add    $0x10,%esp
80104e24:	85 c0                	test   %eax,%eax
80104e26:	78 28                	js     80104e50 <argptr+0x50>
80104e28:	85 db                	test   %ebx,%ebx
80104e2a:	78 24                	js     80104e50 <argptr+0x50>
80104e2c:	8b 16                	mov    (%esi),%edx
80104e2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e31:	39 c2                	cmp    %eax,%edx
80104e33:	76 1b                	jbe    80104e50 <argptr+0x50>
80104e35:	01 c3                	add    %eax,%ebx
80104e37:	39 da                	cmp    %ebx,%edx
80104e39:	72 15                	jb     80104e50 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104e3b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e3e:	89 02                	mov    %eax,(%edx)
  return 0;
80104e40:	31 c0                	xor    %eax,%eax
}
80104e42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e45:	5b                   	pop    %ebx
80104e46:	5e                   	pop    %esi
80104e47:	5d                   	pop    %ebp
80104e48:	c3                   	ret    
80104e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e55:	eb eb                	jmp    80104e42 <argptr+0x42>
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e60 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104e66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e69:	50                   	push   %eax
80104e6a:	ff 75 08             	pushl  0x8(%ebp)
80104e6d:	e8 3e ff ff ff       	call   80104db0 <argint>
80104e72:	83 c4 10             	add    $0x10,%esp
80104e75:	85 c0                	test   %eax,%eax
80104e77:	78 17                	js     80104e90 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104e79:	83 ec 08             	sub    $0x8,%esp
80104e7c:	ff 75 0c             	pushl  0xc(%ebp)
80104e7f:	ff 75 f4             	pushl  -0xc(%ebp)
80104e82:	e8 b9 fe ff ff       	call   80104d40 <fetchstr>
80104e87:	83 c4 10             	add    $0x10,%esp
}
80104e8a:	c9                   	leave  
80104e8b:	c3                   	ret    
80104e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e95:	c9                   	leave  
80104e96:	c3                   	ret    
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	53                   	push   %ebx
80104ea4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104ea7:	e8 94 ed ff ff       	call   80103c40 <myproc>
80104eac:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104eae:	8b 40 18             	mov    0x18(%eax),%eax
80104eb1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104eb4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104eb7:	83 fa 14             	cmp    $0x14,%edx
80104eba:	77 1c                	ja     80104ed8 <syscall+0x38>
80104ebc:	8b 14 85 80 84 10 80 	mov    -0x7fef7b80(,%eax,4),%edx
80104ec3:	85 d2                	test   %edx,%edx
80104ec5:	74 11                	je     80104ed8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104ec7:	ff d2                	call   *%edx
80104ec9:	8b 53 18             	mov    0x18(%ebx),%edx
80104ecc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104ecf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ed2:	c9                   	leave  
80104ed3:	c3                   	ret    
80104ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104ed8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ed9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104edc:	50                   	push   %eax
80104edd:	ff 73 10             	pushl  0x10(%ebx)
80104ee0:	68 5d 84 10 80       	push   $0x8010845d
80104ee5:	e8 76 b7 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104eea:	8b 43 18             	mov    0x18(%ebx),%eax
80104eed:	83 c4 10             	add    $0x10,%esp
80104ef0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104ef7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104efa:	c9                   	leave  
80104efb:	c3                   	ret    
80104efc:	66 90                	xchg   %ax,%ax
80104efe:	66 90                	xchg   %ax,%ax

80104f00 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
80104f05:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104f07:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104f0a:	89 d6                	mov    %edx,%esi
80104f0c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f0f:	50                   	push   %eax
80104f10:	6a 00                	push   $0x0
80104f12:	e8 99 fe ff ff       	call   80104db0 <argint>
80104f17:	83 c4 10             	add    $0x10,%esp
80104f1a:	85 c0                	test   %eax,%eax
80104f1c:	78 2a                	js     80104f48 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f1e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f22:	77 24                	ja     80104f48 <argfd.constprop.0+0x48>
80104f24:	e8 17 ed ff ff       	call   80103c40 <myproc>
80104f29:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f2c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104f30:	85 c0                	test   %eax,%eax
80104f32:	74 14                	je     80104f48 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
80104f34:	85 db                	test   %ebx,%ebx
80104f36:	74 02                	je     80104f3a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104f38:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
80104f3a:	89 06                	mov    %eax,(%esi)
  return 0;
80104f3c:	31 c0                	xor    %eax,%eax
}
80104f3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f41:	5b                   	pop    %ebx
80104f42:	5e                   	pop    %esi
80104f43:	5d                   	pop    %ebp
80104f44:	c3                   	ret    
80104f45:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f4d:	eb ef                	jmp    80104f3e <argfd.constprop.0+0x3e>
80104f4f:	90                   	nop

80104f50 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104f50:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104f51:	31 c0                	xor    %eax,%eax
{
80104f53:	89 e5                	mov    %esp,%ebp
80104f55:	56                   	push   %esi
80104f56:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104f57:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104f5a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104f5d:	e8 9e ff ff ff       	call   80104f00 <argfd.constprop.0>
80104f62:	85 c0                	test   %eax,%eax
80104f64:	78 42                	js     80104fa8 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104f66:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104f69:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104f6b:	e8 d0 ec ff ff       	call   80103c40 <myproc>
80104f70:	eb 0e                	jmp    80104f80 <sys_dup+0x30>
80104f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104f78:	83 c3 01             	add    $0x1,%ebx
80104f7b:	83 fb 10             	cmp    $0x10,%ebx
80104f7e:	74 28                	je     80104fa8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104f80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104f84:	85 d2                	test   %edx,%edx
80104f86:	75 f0                	jne    80104f78 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104f88:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
80104f8c:	83 ec 0c             	sub    $0xc,%esp
80104f8f:	ff 75 f4             	pushl  -0xc(%ebp)
80104f92:	e8 99 be ff ff       	call   80100e30 <filedup>
  return fd;
80104f97:	83 c4 10             	add    $0x10,%esp
}
80104f9a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f9d:	89 d8                	mov    %ebx,%eax
80104f9f:	5b                   	pop    %ebx
80104fa0:	5e                   	pop    %esi
80104fa1:	5d                   	pop    %ebp
80104fa2:	c3                   	ret    
80104fa3:	90                   	nop
80104fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fa8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104fab:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104fb0:	89 d8                	mov    %ebx,%eax
80104fb2:	5b                   	pop    %ebx
80104fb3:	5e                   	pop    %esi
80104fb4:	5d                   	pop    %ebp
80104fb5:	c3                   	ret    
80104fb6:	8d 76 00             	lea    0x0(%esi),%esi
80104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fc0 <sys_read>:

int
sys_read(void)
{
80104fc0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fc1:	31 c0                	xor    %eax,%eax
{
80104fc3:	89 e5                	mov    %esp,%ebp
80104fc5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fc8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104fcb:	e8 30 ff ff ff       	call   80104f00 <argfd.constprop.0>
80104fd0:	85 c0                	test   %eax,%eax
80104fd2:	78 4c                	js     80105020 <sys_read+0x60>
80104fd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fd7:	83 ec 08             	sub    $0x8,%esp
80104fda:	50                   	push   %eax
80104fdb:	6a 02                	push   $0x2
80104fdd:	e8 ce fd ff ff       	call   80104db0 <argint>
80104fe2:	83 c4 10             	add    $0x10,%esp
80104fe5:	85 c0                	test   %eax,%eax
80104fe7:	78 37                	js     80105020 <sys_read+0x60>
80104fe9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fec:	83 ec 04             	sub    $0x4,%esp
80104fef:	ff 75 f0             	pushl  -0x10(%ebp)
80104ff2:	50                   	push   %eax
80104ff3:	6a 01                	push   $0x1
80104ff5:	e8 06 fe ff ff       	call   80104e00 <argptr>
80104ffa:	83 c4 10             	add    $0x10,%esp
80104ffd:	85 c0                	test   %eax,%eax
80104fff:	78 1f                	js     80105020 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80105001:	83 ec 04             	sub    $0x4,%esp
80105004:	ff 75 f0             	pushl  -0x10(%ebp)
80105007:	ff 75 f4             	pushl  -0xc(%ebp)
8010500a:	ff 75 ec             	pushl  -0x14(%ebp)
8010500d:	e8 8e bf ff ff       	call   80100fa0 <fileread>
80105012:	83 c4 10             	add    $0x10,%esp
}
80105015:	c9                   	leave  
80105016:	c3                   	ret    
80105017:	89 f6                	mov    %esi,%esi
80105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105025:	c9                   	leave  
80105026:	c3                   	ret    
80105027:	89 f6                	mov    %esi,%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105030 <sys_write>:

int
sys_write(void)
{
80105030:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105031:	31 c0                	xor    %eax,%eax
{
80105033:	89 e5                	mov    %esp,%ebp
80105035:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105038:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010503b:	e8 c0 fe ff ff       	call   80104f00 <argfd.constprop.0>
80105040:	85 c0                	test   %eax,%eax
80105042:	78 4c                	js     80105090 <sys_write+0x60>
80105044:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105047:	83 ec 08             	sub    $0x8,%esp
8010504a:	50                   	push   %eax
8010504b:	6a 02                	push   $0x2
8010504d:	e8 5e fd ff ff       	call   80104db0 <argint>
80105052:	83 c4 10             	add    $0x10,%esp
80105055:	85 c0                	test   %eax,%eax
80105057:	78 37                	js     80105090 <sys_write+0x60>
80105059:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010505c:	83 ec 04             	sub    $0x4,%esp
8010505f:	ff 75 f0             	pushl  -0x10(%ebp)
80105062:	50                   	push   %eax
80105063:	6a 01                	push   $0x1
80105065:	e8 96 fd ff ff       	call   80104e00 <argptr>
8010506a:	83 c4 10             	add    $0x10,%esp
8010506d:	85 c0                	test   %eax,%eax
8010506f:	78 1f                	js     80105090 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105071:	83 ec 04             	sub    $0x4,%esp
80105074:	ff 75 f0             	pushl  -0x10(%ebp)
80105077:	ff 75 f4             	pushl  -0xc(%ebp)
8010507a:	ff 75 ec             	pushl  -0x14(%ebp)
8010507d:	e8 ae bf ff ff       	call   80101030 <filewrite>
80105082:	83 c4 10             	add    $0x10,%esp
}
80105085:	c9                   	leave  
80105086:	c3                   	ret    
80105087:	89 f6                	mov    %esi,%esi
80105089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105095:	c9                   	leave  
80105096:	c3                   	ret    
80105097:	89 f6                	mov    %esi,%esi
80105099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050a0 <sys_close>:

int
sys_close(void)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
801050a6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801050a9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050ac:	e8 4f fe ff ff       	call   80104f00 <argfd.constprop.0>
801050b1:	85 c0                	test   %eax,%eax
801050b3:	78 2b                	js     801050e0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
801050b5:	e8 86 eb ff ff       	call   80103c40 <myproc>
801050ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801050bd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801050c0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801050c7:	00 
  fileclose(f);
801050c8:	ff 75 f4             	pushl  -0xc(%ebp)
801050cb:	e8 b0 bd ff ff       	call   80100e80 <fileclose>
  return 0;
801050d0:	83 c4 10             	add    $0x10,%esp
801050d3:	31 c0                	xor    %eax,%eax
}
801050d5:	c9                   	leave  
801050d6:	c3                   	ret    
801050d7:	89 f6                	mov    %esi,%esi
801050d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801050e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050e5:	c9                   	leave  
801050e6:	c3                   	ret    
801050e7:	89 f6                	mov    %esi,%esi
801050e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050f0 <sys_fstat>:

int
sys_fstat(void)
{
801050f0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801050f1:	31 c0                	xor    %eax,%eax
{
801050f3:	89 e5                	mov    %esp,%ebp
801050f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801050f8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801050fb:	e8 00 fe ff ff       	call   80104f00 <argfd.constprop.0>
80105100:	85 c0                	test   %eax,%eax
80105102:	78 2c                	js     80105130 <sys_fstat+0x40>
80105104:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105107:	83 ec 04             	sub    $0x4,%esp
8010510a:	6a 14                	push   $0x14
8010510c:	50                   	push   %eax
8010510d:	6a 01                	push   $0x1
8010510f:	e8 ec fc ff ff       	call   80104e00 <argptr>
80105114:	83 c4 10             	add    $0x10,%esp
80105117:	85 c0                	test   %eax,%eax
80105119:	78 15                	js     80105130 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
8010511b:	83 ec 08             	sub    $0x8,%esp
8010511e:	ff 75 f4             	pushl  -0xc(%ebp)
80105121:	ff 75 f0             	pushl  -0x10(%ebp)
80105124:	e8 27 be ff ff       	call   80100f50 <filestat>
80105129:	83 c4 10             	add    $0x10,%esp
}
8010512c:	c9                   	leave  
8010512d:	c3                   	ret    
8010512e:	66 90                	xchg   %ax,%ax
    return -1;
80105130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105135:	c9                   	leave  
80105136:	c3                   	ret    
80105137:	89 f6                	mov    %esi,%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	57                   	push   %edi
80105144:	56                   	push   %esi
80105145:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105146:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105149:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010514c:	50                   	push   %eax
8010514d:	6a 00                	push   $0x0
8010514f:	e8 0c fd ff ff       	call   80104e60 <argstr>
80105154:	83 c4 10             	add    $0x10,%esp
80105157:	85 c0                	test   %eax,%eax
80105159:	0f 88 fb 00 00 00    	js     8010525a <sys_link+0x11a>
8010515f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105162:	83 ec 08             	sub    $0x8,%esp
80105165:	50                   	push   %eax
80105166:	6a 01                	push   $0x1
80105168:	e8 f3 fc ff ff       	call   80104e60 <argstr>
8010516d:	83 c4 10             	add    $0x10,%esp
80105170:	85 c0                	test   %eax,%eax
80105172:	0f 88 e2 00 00 00    	js     8010525a <sys_link+0x11a>
    return -1;

  begin_op();
80105178:	e8 03 de ff ff       	call   80102f80 <begin_op>
  if((ip = namei(old)) == 0){
8010517d:	83 ec 0c             	sub    $0xc,%esp
80105180:	ff 75 d4             	pushl  -0x2c(%ebp)
80105183:	e8 98 cd ff ff       	call   80101f20 <namei>
80105188:	83 c4 10             	add    $0x10,%esp
8010518b:	85 c0                	test   %eax,%eax
8010518d:	89 c3                	mov    %eax,%ebx
8010518f:	0f 84 ea 00 00 00    	je     8010527f <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
80105195:	83 ec 0c             	sub    $0xc,%esp
80105198:	50                   	push   %eax
80105199:	e8 22 c5 ff ff       	call   801016c0 <ilock>
  if(ip->type == T_DIR){
8010519e:	83 c4 10             	add    $0x10,%esp
801051a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051a6:	0f 84 bb 00 00 00    	je     80105267 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
801051ac:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
801051b1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
801051b4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801051b7:	53                   	push   %ebx
801051b8:	e8 53 c4 ff ff       	call   80101610 <iupdate>
  iunlock(ip);
801051bd:	89 1c 24             	mov    %ebx,(%esp)
801051c0:	e8 db c5 ff ff       	call   801017a0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801051c5:	58                   	pop    %eax
801051c6:	5a                   	pop    %edx
801051c7:	57                   	push   %edi
801051c8:	ff 75 d0             	pushl  -0x30(%ebp)
801051cb:	e8 70 cd ff ff       	call   80101f40 <nameiparent>
801051d0:	83 c4 10             	add    $0x10,%esp
801051d3:	85 c0                	test   %eax,%eax
801051d5:	89 c6                	mov    %eax,%esi
801051d7:	74 5b                	je     80105234 <sys_link+0xf4>
    goto bad;
  ilock(dp);
801051d9:	83 ec 0c             	sub    $0xc,%esp
801051dc:	50                   	push   %eax
801051dd:	e8 de c4 ff ff       	call   801016c0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801051e2:	83 c4 10             	add    $0x10,%esp
801051e5:	8b 03                	mov    (%ebx),%eax
801051e7:	39 06                	cmp    %eax,(%esi)
801051e9:	75 3d                	jne    80105228 <sys_link+0xe8>
801051eb:	83 ec 04             	sub    $0x4,%esp
801051ee:	ff 73 04             	pushl  0x4(%ebx)
801051f1:	57                   	push   %edi
801051f2:	56                   	push   %esi
801051f3:	e8 68 cc ff ff       	call   80101e60 <dirlink>
801051f8:	83 c4 10             	add    $0x10,%esp
801051fb:	85 c0                	test   %eax,%eax
801051fd:	78 29                	js     80105228 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801051ff:	83 ec 0c             	sub    $0xc,%esp
80105202:	56                   	push   %esi
80105203:	e8 48 c7 ff ff       	call   80101950 <iunlockput>
  iput(ip);
80105208:	89 1c 24             	mov    %ebx,(%esp)
8010520b:	e8 e0 c5 ff ff       	call   801017f0 <iput>

  end_op();
80105210:	e8 db dd ff ff       	call   80102ff0 <end_op>

  return 0;
80105215:	83 c4 10             	add    $0x10,%esp
80105218:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010521a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010521d:	5b                   	pop    %ebx
8010521e:	5e                   	pop    %esi
8010521f:	5f                   	pop    %edi
80105220:	5d                   	pop    %ebp
80105221:	c3                   	ret    
80105222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105228:	83 ec 0c             	sub    $0xc,%esp
8010522b:	56                   	push   %esi
8010522c:	e8 1f c7 ff ff       	call   80101950 <iunlockput>
    goto bad;
80105231:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105234:	83 ec 0c             	sub    $0xc,%esp
80105237:	53                   	push   %ebx
80105238:	e8 83 c4 ff ff       	call   801016c0 <ilock>
  ip->nlink--;
8010523d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105242:	89 1c 24             	mov    %ebx,(%esp)
80105245:	e8 c6 c3 ff ff       	call   80101610 <iupdate>
  iunlockput(ip);
8010524a:	89 1c 24             	mov    %ebx,(%esp)
8010524d:	e8 fe c6 ff ff       	call   80101950 <iunlockput>
  end_op();
80105252:	e8 99 dd ff ff       	call   80102ff0 <end_op>
  return -1;
80105257:	83 c4 10             	add    $0x10,%esp
}
8010525a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010525d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105262:	5b                   	pop    %ebx
80105263:	5e                   	pop    %esi
80105264:	5f                   	pop    %edi
80105265:	5d                   	pop    %ebp
80105266:	c3                   	ret    
    iunlockput(ip);
80105267:	83 ec 0c             	sub    $0xc,%esp
8010526a:	53                   	push   %ebx
8010526b:	e8 e0 c6 ff ff       	call   80101950 <iunlockput>
    end_op();
80105270:	e8 7b dd ff ff       	call   80102ff0 <end_op>
    return -1;
80105275:	83 c4 10             	add    $0x10,%esp
80105278:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010527d:	eb 9b                	jmp    8010521a <sys_link+0xda>
    end_op();
8010527f:	e8 6c dd ff ff       	call   80102ff0 <end_op>
    return -1;
80105284:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105289:	eb 8f                	jmp    8010521a <sys_link+0xda>
8010528b:	90                   	nop
8010528c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105290 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	57                   	push   %edi
80105294:	56                   	push   %esi
80105295:	53                   	push   %ebx
80105296:	83 ec 1c             	sub    $0x1c,%esp
80105299:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010529c:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
801052a0:	76 3e                	jbe    801052e0 <isdirempty+0x50>
801052a2:	bb 20 00 00 00       	mov    $0x20,%ebx
801052a7:	8d 7d d8             	lea    -0x28(%ebp),%edi
801052aa:	eb 0c                	jmp    801052b8 <isdirempty+0x28>
801052ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052b0:	83 c3 10             	add    $0x10,%ebx
801052b3:	3b 5e 58             	cmp    0x58(%esi),%ebx
801052b6:	73 28                	jae    801052e0 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052b8:	6a 10                	push   $0x10
801052ba:	53                   	push   %ebx
801052bb:	57                   	push   %edi
801052bc:	56                   	push   %esi
801052bd:	e8 de c6 ff ff       	call   801019a0 <readi>
801052c2:	83 c4 10             	add    $0x10,%esp
801052c5:	83 f8 10             	cmp    $0x10,%eax
801052c8:	75 23                	jne    801052ed <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
801052ca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801052cf:	74 df                	je     801052b0 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
801052d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801052d4:	31 c0                	xor    %eax,%eax
}
801052d6:	5b                   	pop    %ebx
801052d7:	5e                   	pop    %esi
801052d8:	5f                   	pop    %edi
801052d9:	5d                   	pop    %ebp
801052da:	c3                   	ret    
801052db:	90                   	nop
801052dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
801052e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
801052e8:	5b                   	pop    %ebx
801052e9:	5e                   	pop    %esi
801052ea:	5f                   	pop    %edi
801052eb:	5d                   	pop    %ebp
801052ec:	c3                   	ret    
      panic("isdirempty: readi");
801052ed:	83 ec 0c             	sub    $0xc,%esp
801052f0:	68 d8 84 10 80       	push   $0x801084d8
801052f5:	e8 96 b0 ff ff       	call   80100390 <panic>
801052fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105300 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	57                   	push   %edi
80105304:	56                   	push   %esi
80105305:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105306:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105309:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010530c:	50                   	push   %eax
8010530d:	6a 00                	push   $0x0
8010530f:	e8 4c fb ff ff       	call   80104e60 <argstr>
80105314:	83 c4 10             	add    $0x10,%esp
80105317:	85 c0                	test   %eax,%eax
80105319:	0f 88 51 01 00 00    	js     80105470 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010531f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105322:	e8 59 dc ff ff       	call   80102f80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105327:	83 ec 08             	sub    $0x8,%esp
8010532a:	53                   	push   %ebx
8010532b:	ff 75 c0             	pushl  -0x40(%ebp)
8010532e:	e8 0d cc ff ff       	call   80101f40 <nameiparent>
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	85 c0                	test   %eax,%eax
80105338:	89 c6                	mov    %eax,%esi
8010533a:	0f 84 37 01 00 00    	je     80105477 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
80105340:	83 ec 0c             	sub    $0xc,%esp
80105343:	50                   	push   %eax
80105344:	e8 77 c3 ff ff       	call   801016c0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105349:	58                   	pop    %eax
8010534a:	5a                   	pop    %edx
8010534b:	68 7d 7e 10 80       	push   $0x80107e7d
80105350:	53                   	push   %ebx
80105351:	e8 7a c8 ff ff       	call   80101bd0 <namecmp>
80105356:	83 c4 10             	add    $0x10,%esp
80105359:	85 c0                	test   %eax,%eax
8010535b:	0f 84 d7 00 00 00    	je     80105438 <sys_unlink+0x138>
80105361:	83 ec 08             	sub    $0x8,%esp
80105364:	68 7c 7e 10 80       	push   $0x80107e7c
80105369:	53                   	push   %ebx
8010536a:	e8 61 c8 ff ff       	call   80101bd0 <namecmp>
8010536f:	83 c4 10             	add    $0x10,%esp
80105372:	85 c0                	test   %eax,%eax
80105374:	0f 84 be 00 00 00    	je     80105438 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010537a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010537d:	83 ec 04             	sub    $0x4,%esp
80105380:	50                   	push   %eax
80105381:	53                   	push   %ebx
80105382:	56                   	push   %esi
80105383:	e8 68 c8 ff ff       	call   80101bf0 <dirlookup>
80105388:	83 c4 10             	add    $0x10,%esp
8010538b:	85 c0                	test   %eax,%eax
8010538d:	89 c3                	mov    %eax,%ebx
8010538f:	0f 84 a3 00 00 00    	je     80105438 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
80105395:	83 ec 0c             	sub    $0xc,%esp
80105398:	50                   	push   %eax
80105399:	e8 22 c3 ff ff       	call   801016c0 <ilock>

  if(ip->nlink < 1)
8010539e:	83 c4 10             	add    $0x10,%esp
801053a1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801053a6:	0f 8e e4 00 00 00    	jle    80105490 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801053ac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053b1:	74 65                	je     80105418 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801053b3:	8d 7d d8             	lea    -0x28(%ebp),%edi
801053b6:	83 ec 04             	sub    $0x4,%esp
801053b9:	6a 10                	push   $0x10
801053bb:	6a 00                	push   $0x0
801053bd:	57                   	push   %edi
801053be:	e8 ed f6 ff ff       	call   80104ab0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801053c3:	6a 10                	push   $0x10
801053c5:	ff 75 c4             	pushl  -0x3c(%ebp)
801053c8:	57                   	push   %edi
801053c9:	56                   	push   %esi
801053ca:	e8 d1 c6 ff ff       	call   80101aa0 <writei>
801053cf:	83 c4 20             	add    $0x20,%esp
801053d2:	83 f8 10             	cmp    $0x10,%eax
801053d5:	0f 85 a8 00 00 00    	jne    80105483 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801053db:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801053e0:	74 6e                	je     80105450 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801053e2:	83 ec 0c             	sub    $0xc,%esp
801053e5:	56                   	push   %esi
801053e6:	e8 65 c5 ff ff       	call   80101950 <iunlockput>

  ip->nlink--;
801053eb:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801053f0:	89 1c 24             	mov    %ebx,(%esp)
801053f3:	e8 18 c2 ff ff       	call   80101610 <iupdate>
  iunlockput(ip);
801053f8:	89 1c 24             	mov    %ebx,(%esp)
801053fb:	e8 50 c5 ff ff       	call   80101950 <iunlockput>

  end_op();
80105400:	e8 eb db ff ff       	call   80102ff0 <end_op>

  return 0;
80105405:	83 c4 10             	add    $0x10,%esp
80105408:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
8010540a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010540d:	5b                   	pop    %ebx
8010540e:	5e                   	pop    %esi
8010540f:	5f                   	pop    %edi
80105410:	5d                   	pop    %ebp
80105411:	c3                   	ret    
80105412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
80105418:	83 ec 0c             	sub    $0xc,%esp
8010541b:	53                   	push   %ebx
8010541c:	e8 6f fe ff ff       	call   80105290 <isdirempty>
80105421:	83 c4 10             	add    $0x10,%esp
80105424:	85 c0                	test   %eax,%eax
80105426:	75 8b                	jne    801053b3 <sys_unlink+0xb3>
    iunlockput(ip);
80105428:	83 ec 0c             	sub    $0xc,%esp
8010542b:	53                   	push   %ebx
8010542c:	e8 1f c5 ff ff       	call   80101950 <iunlockput>
    goto bad;
80105431:	83 c4 10             	add    $0x10,%esp
80105434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105438:	83 ec 0c             	sub    $0xc,%esp
8010543b:	56                   	push   %esi
8010543c:	e8 0f c5 ff ff       	call   80101950 <iunlockput>
  end_op();
80105441:	e8 aa db ff ff       	call   80102ff0 <end_op>
  return -1;
80105446:	83 c4 10             	add    $0x10,%esp
80105449:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010544e:	eb ba                	jmp    8010540a <sys_unlink+0x10a>
    dp->nlink--;
80105450:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105455:	83 ec 0c             	sub    $0xc,%esp
80105458:	56                   	push   %esi
80105459:	e8 b2 c1 ff ff       	call   80101610 <iupdate>
8010545e:	83 c4 10             	add    $0x10,%esp
80105461:	e9 7c ff ff ff       	jmp    801053e2 <sys_unlink+0xe2>
80105466:	8d 76 00             	lea    0x0(%esi),%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105475:	eb 93                	jmp    8010540a <sys_unlink+0x10a>
    end_op();
80105477:	e8 74 db ff ff       	call   80102ff0 <end_op>
    return -1;
8010547c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105481:	eb 87                	jmp    8010540a <sys_unlink+0x10a>
    panic("unlink: writei");
80105483:	83 ec 0c             	sub    $0xc,%esp
80105486:	68 91 7e 10 80       	push   $0x80107e91
8010548b:	e8 00 af ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105490:	83 ec 0c             	sub    $0xc,%esp
80105493:	68 7f 7e 10 80       	push   $0x80107e7f
80105498:	e8 f3 ae ff ff       	call   80100390 <panic>
8010549d:	8d 76 00             	lea    0x0(%esi),%esi

801054a0 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	57                   	push   %edi
801054a4:	56                   	push   %esi
801054a5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801054a6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801054a9:	83 ec 34             	sub    $0x34,%esp
801054ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801054af:	8b 55 10             	mov    0x10(%ebp),%edx
801054b2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801054b5:	56                   	push   %esi
801054b6:	ff 75 08             	pushl  0x8(%ebp)
{
801054b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801054bc:	89 55 d0             	mov    %edx,-0x30(%ebp)
801054bf:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801054c2:	e8 79 ca ff ff       	call   80101f40 <nameiparent>
801054c7:	83 c4 10             	add    $0x10,%esp
801054ca:	85 c0                	test   %eax,%eax
801054cc:	0f 84 4e 01 00 00    	je     80105620 <create+0x180>
    return 0;
  ilock(dp);
801054d2:	83 ec 0c             	sub    $0xc,%esp
801054d5:	89 c3                	mov    %eax,%ebx
801054d7:	50                   	push   %eax
801054d8:	e8 e3 c1 ff ff       	call   801016c0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801054dd:	83 c4 0c             	add    $0xc,%esp
801054e0:	6a 00                	push   $0x0
801054e2:	56                   	push   %esi
801054e3:	53                   	push   %ebx
801054e4:	e8 07 c7 ff ff       	call   80101bf0 <dirlookup>
801054e9:	83 c4 10             	add    $0x10,%esp
801054ec:	85 c0                	test   %eax,%eax
801054ee:	89 c7                	mov    %eax,%edi
801054f0:	74 3e                	je     80105530 <create+0x90>
    iunlockput(dp);
801054f2:	83 ec 0c             	sub    $0xc,%esp
801054f5:	53                   	push   %ebx
801054f6:	e8 55 c4 ff ff       	call   80101950 <iunlockput>
    ilock(ip);
801054fb:	89 3c 24             	mov    %edi,(%esp)
801054fe:	e8 bd c1 ff ff       	call   801016c0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105503:	83 c4 10             	add    $0x10,%esp
80105506:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010550b:	0f 85 9f 00 00 00    	jne    801055b0 <create+0x110>
80105511:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105516:	0f 85 94 00 00 00    	jne    801055b0 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010551c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010551f:	89 f8                	mov    %edi,%eax
80105521:	5b                   	pop    %ebx
80105522:	5e                   	pop    %esi
80105523:	5f                   	pop    %edi
80105524:	5d                   	pop    %ebp
80105525:	c3                   	ret    
80105526:	8d 76 00             	lea    0x0(%esi),%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
80105530:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105534:	83 ec 08             	sub    $0x8,%esp
80105537:	50                   	push   %eax
80105538:	ff 33                	pushl  (%ebx)
8010553a:	e8 11 c0 ff ff       	call   80101550 <ialloc>
8010553f:	83 c4 10             	add    $0x10,%esp
80105542:	85 c0                	test   %eax,%eax
80105544:	89 c7                	mov    %eax,%edi
80105546:	0f 84 e8 00 00 00    	je     80105634 <create+0x194>
  ilock(ip);
8010554c:	83 ec 0c             	sub    $0xc,%esp
8010554f:	50                   	push   %eax
80105550:	e8 6b c1 ff ff       	call   801016c0 <ilock>
  ip->major = major;
80105555:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105559:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010555d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105561:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105565:	b8 01 00 00 00       	mov    $0x1,%eax
8010556a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010556e:	89 3c 24             	mov    %edi,(%esp)
80105571:	e8 9a c0 ff ff       	call   80101610 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105576:	83 c4 10             	add    $0x10,%esp
80105579:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010557e:	74 50                	je     801055d0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105580:	83 ec 04             	sub    $0x4,%esp
80105583:	ff 77 04             	pushl  0x4(%edi)
80105586:	56                   	push   %esi
80105587:	53                   	push   %ebx
80105588:	e8 d3 c8 ff ff       	call   80101e60 <dirlink>
8010558d:	83 c4 10             	add    $0x10,%esp
80105590:	85 c0                	test   %eax,%eax
80105592:	0f 88 8f 00 00 00    	js     80105627 <create+0x187>
  iunlockput(dp);
80105598:	83 ec 0c             	sub    $0xc,%esp
8010559b:	53                   	push   %ebx
8010559c:	e8 af c3 ff ff       	call   80101950 <iunlockput>
  return ip;
801055a1:	83 c4 10             	add    $0x10,%esp
}
801055a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055a7:	89 f8                	mov    %edi,%eax
801055a9:	5b                   	pop    %ebx
801055aa:	5e                   	pop    %esi
801055ab:	5f                   	pop    %edi
801055ac:	5d                   	pop    %ebp
801055ad:	c3                   	ret    
801055ae:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801055b0:	83 ec 0c             	sub    $0xc,%esp
801055b3:	57                   	push   %edi
    return 0;
801055b4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801055b6:	e8 95 c3 ff ff       	call   80101950 <iunlockput>
    return 0;
801055bb:	83 c4 10             	add    $0x10,%esp
}
801055be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055c1:	89 f8                	mov    %edi,%eax
801055c3:	5b                   	pop    %ebx
801055c4:	5e                   	pop    %esi
801055c5:	5f                   	pop    %edi
801055c6:	5d                   	pop    %ebp
801055c7:	c3                   	ret    
801055c8:	90                   	nop
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801055d0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801055d5:	83 ec 0c             	sub    $0xc,%esp
801055d8:	53                   	push   %ebx
801055d9:	e8 32 c0 ff ff       	call   80101610 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801055de:	83 c4 0c             	add    $0xc,%esp
801055e1:	ff 77 04             	pushl  0x4(%edi)
801055e4:	68 7d 7e 10 80       	push   $0x80107e7d
801055e9:	57                   	push   %edi
801055ea:	e8 71 c8 ff ff       	call   80101e60 <dirlink>
801055ef:	83 c4 10             	add    $0x10,%esp
801055f2:	85 c0                	test   %eax,%eax
801055f4:	78 1c                	js     80105612 <create+0x172>
801055f6:	83 ec 04             	sub    $0x4,%esp
801055f9:	ff 73 04             	pushl  0x4(%ebx)
801055fc:	68 7c 7e 10 80       	push   $0x80107e7c
80105601:	57                   	push   %edi
80105602:	e8 59 c8 ff ff       	call   80101e60 <dirlink>
80105607:	83 c4 10             	add    $0x10,%esp
8010560a:	85 c0                	test   %eax,%eax
8010560c:	0f 89 6e ff ff ff    	jns    80105580 <create+0xe0>
      panic("create dots");
80105612:	83 ec 0c             	sub    $0xc,%esp
80105615:	68 f9 84 10 80       	push   $0x801084f9
8010561a:	e8 71 ad ff ff       	call   80100390 <panic>
8010561f:	90                   	nop
    return 0;
80105620:	31 ff                	xor    %edi,%edi
80105622:	e9 f5 fe ff ff       	jmp    8010551c <create+0x7c>
    panic("create: dirlink");
80105627:	83 ec 0c             	sub    $0xc,%esp
8010562a:	68 05 85 10 80       	push   $0x80108505
8010562f:	e8 5c ad ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105634:	83 ec 0c             	sub    $0xc,%esp
80105637:	68 ea 84 10 80       	push   $0x801084ea
8010563c:	e8 4f ad ff ff       	call   80100390 <panic>
80105641:	eb 0d                	jmp    80105650 <sys_open>
80105643:	90                   	nop
80105644:	90                   	nop
80105645:	90                   	nop
80105646:	90                   	nop
80105647:	90                   	nop
80105648:	90                   	nop
80105649:	90                   	nop
8010564a:	90                   	nop
8010564b:	90                   	nop
8010564c:	90                   	nop
8010564d:	90                   	nop
8010564e:	90                   	nop
8010564f:	90                   	nop

80105650 <sys_open>:

int
sys_open(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	56                   	push   %esi
80105655:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105656:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105659:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010565c:	50                   	push   %eax
8010565d:	6a 00                	push   $0x0
8010565f:	e8 fc f7 ff ff       	call   80104e60 <argstr>
80105664:	83 c4 10             	add    $0x10,%esp
80105667:	85 c0                	test   %eax,%eax
80105669:	0f 88 1d 01 00 00    	js     8010578c <sys_open+0x13c>
8010566f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105672:	83 ec 08             	sub    $0x8,%esp
80105675:	50                   	push   %eax
80105676:	6a 01                	push   $0x1
80105678:	e8 33 f7 ff ff       	call   80104db0 <argint>
8010567d:	83 c4 10             	add    $0x10,%esp
80105680:	85 c0                	test   %eax,%eax
80105682:	0f 88 04 01 00 00    	js     8010578c <sys_open+0x13c>
    return -1;

  begin_op();
80105688:	e8 f3 d8 ff ff       	call   80102f80 <begin_op>

  if(omode & O_CREATE){
8010568d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105691:	0f 85 a9 00 00 00    	jne    80105740 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105697:	83 ec 0c             	sub    $0xc,%esp
8010569a:	ff 75 e0             	pushl  -0x20(%ebp)
8010569d:	e8 7e c8 ff ff       	call   80101f20 <namei>
801056a2:	83 c4 10             	add    $0x10,%esp
801056a5:	85 c0                	test   %eax,%eax
801056a7:	89 c6                	mov    %eax,%esi
801056a9:	0f 84 ac 00 00 00    	je     8010575b <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
801056af:	83 ec 0c             	sub    $0xc,%esp
801056b2:	50                   	push   %eax
801056b3:	e8 08 c0 ff ff       	call   801016c0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801056b8:	83 c4 10             	add    $0x10,%esp
801056bb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801056c0:	0f 84 aa 00 00 00    	je     80105770 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801056c6:	e8 f5 b6 ff ff       	call   80100dc0 <filealloc>
801056cb:	85 c0                	test   %eax,%eax
801056cd:	89 c7                	mov    %eax,%edi
801056cf:	0f 84 a6 00 00 00    	je     8010577b <sys_open+0x12b>
  struct proc *curproc = myproc();
801056d5:	e8 66 e5 ff ff       	call   80103c40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801056da:	31 db                	xor    %ebx,%ebx
801056dc:	eb 0e                	jmp    801056ec <sys_open+0x9c>
801056de:	66 90                	xchg   %ax,%ax
801056e0:	83 c3 01             	add    $0x1,%ebx
801056e3:	83 fb 10             	cmp    $0x10,%ebx
801056e6:	0f 84 ac 00 00 00    	je     80105798 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801056ec:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801056f0:	85 d2                	test   %edx,%edx
801056f2:	75 ec                	jne    801056e0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801056f4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801056f7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801056fb:	56                   	push   %esi
801056fc:	e8 9f c0 ff ff       	call   801017a0 <iunlock>
  end_op();
80105701:	e8 ea d8 ff ff       	call   80102ff0 <end_op>

  f->type = FD_INODE;
80105706:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010570c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010570f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105712:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105715:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010571c:	89 d0                	mov    %edx,%eax
8010571e:	f7 d0                	not    %eax
80105720:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105723:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105726:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105729:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010572d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105730:	89 d8                	mov    %ebx,%eax
80105732:	5b                   	pop    %ebx
80105733:	5e                   	pop    %esi
80105734:	5f                   	pop    %edi
80105735:	5d                   	pop    %ebp
80105736:	c3                   	ret    
80105737:	89 f6                	mov    %esi,%esi
80105739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105740:	6a 00                	push   $0x0
80105742:	6a 00                	push   $0x0
80105744:	6a 02                	push   $0x2
80105746:	ff 75 e0             	pushl  -0x20(%ebp)
80105749:	e8 52 fd ff ff       	call   801054a0 <create>
    if(ip == 0){
8010574e:	83 c4 10             	add    $0x10,%esp
80105751:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105753:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105755:	0f 85 6b ff ff ff    	jne    801056c6 <sys_open+0x76>
      end_op();
8010575b:	e8 90 d8 ff ff       	call   80102ff0 <end_op>
      return -1;
80105760:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105765:	eb c6                	jmp    8010572d <sys_open+0xdd>
80105767:	89 f6                	mov    %esi,%esi
80105769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105770:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105773:	85 c9                	test   %ecx,%ecx
80105775:	0f 84 4b ff ff ff    	je     801056c6 <sys_open+0x76>
    iunlockput(ip);
8010577b:	83 ec 0c             	sub    $0xc,%esp
8010577e:	56                   	push   %esi
8010577f:	e8 cc c1 ff ff       	call   80101950 <iunlockput>
    end_op();
80105784:	e8 67 d8 ff ff       	call   80102ff0 <end_op>
    return -1;
80105789:	83 c4 10             	add    $0x10,%esp
8010578c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105791:	eb 9a                	jmp    8010572d <sys_open+0xdd>
80105793:	90                   	nop
80105794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105798:	83 ec 0c             	sub    $0xc,%esp
8010579b:	57                   	push   %edi
8010579c:	e8 df b6 ff ff       	call   80100e80 <fileclose>
801057a1:	83 c4 10             	add    $0x10,%esp
801057a4:	eb d5                	jmp    8010577b <sys_open+0x12b>
801057a6:	8d 76 00             	lea    0x0(%esi),%esi
801057a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801057b6:	e8 c5 d7 ff ff       	call   80102f80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801057bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057be:	83 ec 08             	sub    $0x8,%esp
801057c1:	50                   	push   %eax
801057c2:	6a 00                	push   $0x0
801057c4:	e8 97 f6 ff ff       	call   80104e60 <argstr>
801057c9:	83 c4 10             	add    $0x10,%esp
801057cc:	85 c0                	test   %eax,%eax
801057ce:	78 30                	js     80105800 <sys_mkdir+0x50>
801057d0:	6a 00                	push   $0x0
801057d2:	6a 00                	push   $0x0
801057d4:	6a 01                	push   $0x1
801057d6:	ff 75 f4             	pushl  -0xc(%ebp)
801057d9:	e8 c2 fc ff ff       	call   801054a0 <create>
801057de:	83 c4 10             	add    $0x10,%esp
801057e1:	85 c0                	test   %eax,%eax
801057e3:	74 1b                	je     80105800 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801057e5:	83 ec 0c             	sub    $0xc,%esp
801057e8:	50                   	push   %eax
801057e9:	e8 62 c1 ff ff       	call   80101950 <iunlockput>
  end_op();
801057ee:	e8 fd d7 ff ff       	call   80102ff0 <end_op>
  return 0;
801057f3:	83 c4 10             	add    $0x10,%esp
801057f6:	31 c0                	xor    %eax,%eax
}
801057f8:	c9                   	leave  
801057f9:	c3                   	ret    
801057fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105800:	e8 eb d7 ff ff       	call   80102ff0 <end_op>
    return -1;
80105805:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010580a:	c9                   	leave  
8010580b:	c3                   	ret    
8010580c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105810 <sys_mknod>:

int
sys_mknod(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105816:	e8 65 d7 ff ff       	call   80102f80 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010581b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010581e:	83 ec 08             	sub    $0x8,%esp
80105821:	50                   	push   %eax
80105822:	6a 00                	push   $0x0
80105824:	e8 37 f6 ff ff       	call   80104e60 <argstr>
80105829:	83 c4 10             	add    $0x10,%esp
8010582c:	85 c0                	test   %eax,%eax
8010582e:	78 60                	js     80105890 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105830:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105833:	83 ec 08             	sub    $0x8,%esp
80105836:	50                   	push   %eax
80105837:	6a 01                	push   $0x1
80105839:	e8 72 f5 ff ff       	call   80104db0 <argint>
  if((argstr(0, &path)) < 0 ||
8010583e:	83 c4 10             	add    $0x10,%esp
80105841:	85 c0                	test   %eax,%eax
80105843:	78 4b                	js     80105890 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105845:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105848:	83 ec 08             	sub    $0x8,%esp
8010584b:	50                   	push   %eax
8010584c:	6a 02                	push   $0x2
8010584e:	e8 5d f5 ff ff       	call   80104db0 <argint>
     argint(1, &major) < 0 ||
80105853:	83 c4 10             	add    $0x10,%esp
80105856:	85 c0                	test   %eax,%eax
80105858:	78 36                	js     80105890 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010585a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010585e:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
8010585f:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80105863:	50                   	push   %eax
80105864:	6a 03                	push   $0x3
80105866:	ff 75 ec             	pushl  -0x14(%ebp)
80105869:	e8 32 fc ff ff       	call   801054a0 <create>
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	85 c0                	test   %eax,%eax
80105873:	74 1b                	je     80105890 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105875:	83 ec 0c             	sub    $0xc,%esp
80105878:	50                   	push   %eax
80105879:	e8 d2 c0 ff ff       	call   80101950 <iunlockput>
  end_op();
8010587e:	e8 6d d7 ff ff       	call   80102ff0 <end_op>
  return 0;
80105883:	83 c4 10             	add    $0x10,%esp
80105886:	31 c0                	xor    %eax,%eax
}
80105888:	c9                   	leave  
80105889:	c3                   	ret    
8010588a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105890:	e8 5b d7 ff ff       	call   80102ff0 <end_op>
    return -1;
80105895:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010589a:	c9                   	leave  
8010589b:	c3                   	ret    
8010589c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058a0 <sys_chdir>:

int
sys_chdir(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	56                   	push   %esi
801058a4:	53                   	push   %ebx
801058a5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801058a8:	e8 93 e3 ff ff       	call   80103c40 <myproc>
801058ad:	89 c6                	mov    %eax,%esi
  
  begin_op();
801058af:	e8 cc d6 ff ff       	call   80102f80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801058b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058b7:	83 ec 08             	sub    $0x8,%esp
801058ba:	50                   	push   %eax
801058bb:	6a 00                	push   $0x0
801058bd:	e8 9e f5 ff ff       	call   80104e60 <argstr>
801058c2:	83 c4 10             	add    $0x10,%esp
801058c5:	85 c0                	test   %eax,%eax
801058c7:	78 77                	js     80105940 <sys_chdir+0xa0>
801058c9:	83 ec 0c             	sub    $0xc,%esp
801058cc:	ff 75 f4             	pushl  -0xc(%ebp)
801058cf:	e8 4c c6 ff ff       	call   80101f20 <namei>
801058d4:	83 c4 10             	add    $0x10,%esp
801058d7:	85 c0                	test   %eax,%eax
801058d9:	89 c3                	mov    %eax,%ebx
801058db:	74 63                	je     80105940 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801058dd:	83 ec 0c             	sub    $0xc,%esp
801058e0:	50                   	push   %eax
801058e1:	e8 da bd ff ff       	call   801016c0 <ilock>
  if(ip->type != T_DIR){
801058e6:	83 c4 10             	add    $0x10,%esp
801058e9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801058ee:	75 30                	jne    80105920 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801058f0:	83 ec 0c             	sub    $0xc,%esp
801058f3:	53                   	push   %ebx
801058f4:	e8 a7 be ff ff       	call   801017a0 <iunlock>
  iput(curproc->cwd);
801058f9:	58                   	pop    %eax
801058fa:	ff 76 68             	pushl  0x68(%esi)
801058fd:	e8 ee be ff ff       	call   801017f0 <iput>
  end_op();
80105902:	e8 e9 d6 ff ff       	call   80102ff0 <end_op>
  curproc->cwd = ip;
80105907:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010590a:	83 c4 10             	add    $0x10,%esp
8010590d:	31 c0                	xor    %eax,%eax
}
8010590f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105912:	5b                   	pop    %ebx
80105913:	5e                   	pop    %esi
80105914:	5d                   	pop    %ebp
80105915:	c3                   	ret    
80105916:	8d 76 00             	lea    0x0(%esi),%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105920:	83 ec 0c             	sub    $0xc,%esp
80105923:	53                   	push   %ebx
80105924:	e8 27 c0 ff ff       	call   80101950 <iunlockput>
    end_op();
80105929:	e8 c2 d6 ff ff       	call   80102ff0 <end_op>
    return -1;
8010592e:	83 c4 10             	add    $0x10,%esp
80105931:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105936:	eb d7                	jmp    8010590f <sys_chdir+0x6f>
80105938:	90                   	nop
80105939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105940:	e8 ab d6 ff ff       	call   80102ff0 <end_op>
    return -1;
80105945:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594a:	eb c3                	jmp    8010590f <sys_chdir+0x6f>
8010594c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105950 <sys_exec>:

int
sys_exec(void)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	57                   	push   %edi
80105954:	56                   	push   %esi
80105955:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105956:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010595c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105962:	50                   	push   %eax
80105963:	6a 00                	push   $0x0
80105965:	e8 f6 f4 ff ff       	call   80104e60 <argstr>
8010596a:	83 c4 10             	add    $0x10,%esp
8010596d:	85 c0                	test   %eax,%eax
8010596f:	0f 88 87 00 00 00    	js     801059fc <sys_exec+0xac>
80105975:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010597b:	83 ec 08             	sub    $0x8,%esp
8010597e:	50                   	push   %eax
8010597f:	6a 01                	push   $0x1
80105981:	e8 2a f4 ff ff       	call   80104db0 <argint>
80105986:	83 c4 10             	add    $0x10,%esp
80105989:	85 c0                	test   %eax,%eax
8010598b:	78 6f                	js     801059fc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010598d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105993:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105996:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105998:	68 80 00 00 00       	push   $0x80
8010599d:	6a 00                	push   $0x0
8010599f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801059a5:	50                   	push   %eax
801059a6:	e8 05 f1 ff ff       	call   80104ab0 <memset>
801059ab:	83 c4 10             	add    $0x10,%esp
801059ae:	eb 2c                	jmp    801059dc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801059b0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801059b6:	85 c0                	test   %eax,%eax
801059b8:	74 56                	je     80105a10 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801059ba:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801059c0:	83 ec 08             	sub    $0x8,%esp
801059c3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801059c6:	52                   	push   %edx
801059c7:	50                   	push   %eax
801059c8:	e8 73 f3 ff ff       	call   80104d40 <fetchstr>
801059cd:	83 c4 10             	add    $0x10,%esp
801059d0:	85 c0                	test   %eax,%eax
801059d2:	78 28                	js     801059fc <sys_exec+0xac>
  for(i=0;; i++){
801059d4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801059d7:	83 fb 20             	cmp    $0x20,%ebx
801059da:	74 20                	je     801059fc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801059dc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801059e2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801059e9:	83 ec 08             	sub    $0x8,%esp
801059ec:	57                   	push   %edi
801059ed:	01 f0                	add    %esi,%eax
801059ef:	50                   	push   %eax
801059f0:	e8 0b f3 ff ff       	call   80104d00 <fetchint>
801059f5:	83 c4 10             	add    $0x10,%esp
801059f8:	85 c0                	test   %eax,%eax
801059fa:	79 b4                	jns    801059b0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801059fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801059ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a04:	5b                   	pop    %ebx
80105a05:	5e                   	pop    %esi
80105a06:	5f                   	pop    %edi
80105a07:	5d                   	pop    %ebp
80105a08:	c3                   	ret    
80105a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105a10:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105a16:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105a19:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105a20:	00 00 00 00 
  return exec(path, argv);
80105a24:	50                   	push   %eax
80105a25:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105a2b:	e8 e0 af ff ff       	call   80100a10 <exec>
80105a30:	83 c4 10             	add    $0x10,%esp
}
80105a33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a36:	5b                   	pop    %ebx
80105a37:	5e                   	pop    %esi
80105a38:	5f                   	pop    %edi
80105a39:	5d                   	pop    %ebp
80105a3a:	c3                   	ret    
80105a3b:	90                   	nop
80105a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a40 <sys_pipe>:

int
sys_pipe(void)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	57                   	push   %edi
80105a44:	56                   	push   %esi
80105a45:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a46:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105a49:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a4c:	6a 08                	push   $0x8
80105a4e:	50                   	push   %eax
80105a4f:	6a 00                	push   $0x0
80105a51:	e8 aa f3 ff ff       	call   80104e00 <argptr>
80105a56:	83 c4 10             	add    $0x10,%esp
80105a59:	85 c0                	test   %eax,%eax
80105a5b:	0f 88 ae 00 00 00    	js     80105b0f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105a61:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a64:	83 ec 08             	sub    $0x8,%esp
80105a67:	50                   	push   %eax
80105a68:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a6b:	50                   	push   %eax
80105a6c:	e8 af db ff ff       	call   80103620 <pipealloc>
80105a71:	83 c4 10             	add    $0x10,%esp
80105a74:	85 c0                	test   %eax,%eax
80105a76:	0f 88 93 00 00 00    	js     80105b0f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a7c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105a7f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105a81:	e8 ba e1 ff ff       	call   80103c40 <myproc>
80105a86:	eb 10                	jmp    80105a98 <sys_pipe+0x58>
80105a88:	90                   	nop
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105a90:	83 c3 01             	add    $0x1,%ebx
80105a93:	83 fb 10             	cmp    $0x10,%ebx
80105a96:	74 60                	je     80105af8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105a98:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105a9c:	85 f6                	test   %esi,%esi
80105a9e:	75 f0                	jne    80105a90 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105aa0:	8d 73 08             	lea    0x8(%ebx),%esi
80105aa3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105aa7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105aaa:	e8 91 e1 ff ff       	call   80103c40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105aaf:	31 d2                	xor    %edx,%edx
80105ab1:	eb 0d                	jmp    80105ac0 <sys_pipe+0x80>
80105ab3:	90                   	nop
80105ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ab8:	83 c2 01             	add    $0x1,%edx
80105abb:	83 fa 10             	cmp    $0x10,%edx
80105abe:	74 28                	je     80105ae8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105ac0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105ac4:	85 c9                	test   %ecx,%ecx
80105ac6:	75 f0                	jne    80105ab8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105ac8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105acc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105acf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105ad1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105ad4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105ad7:	31 c0                	xor    %eax,%eax
}
80105ad9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105adc:	5b                   	pop    %ebx
80105add:	5e                   	pop    %esi
80105ade:	5f                   	pop    %edi
80105adf:	5d                   	pop    %ebp
80105ae0:	c3                   	ret    
80105ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105ae8:	e8 53 e1 ff ff       	call   80103c40 <myproc>
80105aed:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105af4:	00 
80105af5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105af8:	83 ec 0c             	sub    $0xc,%esp
80105afb:	ff 75 e0             	pushl  -0x20(%ebp)
80105afe:	e8 7d b3 ff ff       	call   80100e80 <fileclose>
    fileclose(wf);
80105b03:	58                   	pop    %eax
80105b04:	ff 75 e4             	pushl  -0x1c(%ebp)
80105b07:	e8 74 b3 ff ff       	call   80100e80 <fileclose>
    return -1;
80105b0c:	83 c4 10             	add    $0x10,%esp
80105b0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b14:	eb c3                	jmp    80105ad9 <sys_pipe+0x99>
80105b16:	66 90                	xchg   %ax,%ax
80105b18:	66 90                	xchg   %ax,%ax
80105b1a:	66 90                	xchg   %ax,%ax
80105b1c:	66 90                	xchg   %ax,%ax
80105b1e:	66 90                	xchg   %ax,%ax

80105b20 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105b23:	5d                   	pop    %ebp
  return fork();
80105b24:	e9 b7 e2 ff ff       	jmp    80103de0 <fork>
80105b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b30 <sys_exit>:

int
sys_exit(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	83 ec 08             	sub    $0x8,%esp
  exit();
80105b36:	e8 15 e6 ff ff       	call   80104150 <exit>
  return 0;  // not reached
}
80105b3b:	31 c0                	xor    %eax,%eax
80105b3d:	c9                   	leave  
80105b3e:	c3                   	ret    
80105b3f:	90                   	nop

80105b40 <sys_wait>:

int
sys_wait(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105b43:	5d                   	pop    %ebp
  return wait();
80105b44:	e9 47 e8 ff ff       	jmp    80104390 <wait>
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b50 <sys_kill>:

int
sys_kill(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105b56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b59:	50                   	push   %eax
80105b5a:	6a 00                	push   $0x0
80105b5c:	e8 4f f2 ff ff       	call   80104db0 <argint>
80105b61:	83 c4 10             	add    $0x10,%esp
80105b64:	85 c0                	test   %eax,%eax
80105b66:	78 18                	js     80105b80 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105b68:	83 ec 0c             	sub    $0xc,%esp
80105b6b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b6e:	e8 7d e9 ff ff       	call   801044f0 <kill>
80105b73:	83 c4 10             	add    $0x10,%esp
}
80105b76:	c9                   	leave  
80105b77:	c3                   	ret    
80105b78:	90                   	nop
80105b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b85:	c9                   	leave  
80105b86:	c3                   	ret    
80105b87:	89 f6                	mov    %esi,%esi
80105b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b90 <sys_getpid>:

int
sys_getpid(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105b96:	e8 a5 e0 ff ff       	call   80103c40 <myproc>
80105b9b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105b9e:	c9                   	leave  
80105b9f:	c3                   	ret    

80105ba0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105ba4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ba7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105baa:	50                   	push   %eax
80105bab:	6a 00                	push   $0x0
80105bad:	e8 fe f1 ff ff       	call   80104db0 <argint>
80105bb2:	83 c4 10             	add    $0x10,%esp
80105bb5:	85 c0                	test   %eax,%eax
80105bb7:	78 27                	js     80105be0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105bb9:	e8 82 e0 ff ff       	call   80103c40 <myproc>
  if(growproc(n) < 0)
80105bbe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105bc1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105bc3:	ff 75 f4             	pushl  -0xc(%ebp)
80105bc6:	e8 95 e1 ff ff       	call   80103d60 <growproc>
80105bcb:	83 c4 10             	add    $0x10,%esp
80105bce:	85 c0                	test   %eax,%eax
80105bd0:	78 0e                	js     80105be0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105bd2:	89 d8                	mov    %ebx,%eax
80105bd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bd7:	c9                   	leave  
80105bd8:	c3                   	ret    
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105be0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105be5:	eb eb                	jmp    80105bd2 <sys_sbrk+0x32>
80105be7:	89 f6                	mov    %esi,%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bf0 <sys_sleep>:

int
sys_sleep(void)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105bf4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105bf7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105bfa:	50                   	push   %eax
80105bfb:	6a 00                	push   $0x0
80105bfd:	e8 ae f1 ff ff       	call   80104db0 <argint>
80105c02:	83 c4 10             	add    $0x10,%esp
80105c05:	85 c0                	test   %eax,%eax
80105c07:	0f 88 8a 00 00 00    	js     80105c97 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105c0d:	83 ec 0c             	sub    $0xc,%esp
80105c10:	68 a0 ff 11 80       	push   $0x8011ffa0
80105c15:	e8 86 ed ff ff       	call   801049a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105c1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c1d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105c20:	8b 1d e0 07 12 80    	mov    0x801207e0,%ebx
  while(ticks - ticks0 < n){
80105c26:	85 d2                	test   %edx,%edx
80105c28:	75 27                	jne    80105c51 <sys_sleep+0x61>
80105c2a:	eb 54                	jmp    80105c80 <sys_sleep+0x90>
80105c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105c30:	83 ec 08             	sub    $0x8,%esp
80105c33:	68 a0 ff 11 80       	push   $0x8011ffa0
80105c38:	68 e0 07 12 80       	push   $0x801207e0
80105c3d:	e8 8e e6 ff ff       	call   801042d0 <sleep>
  while(ticks - ticks0 < n){
80105c42:	a1 e0 07 12 80       	mov    0x801207e0,%eax
80105c47:	83 c4 10             	add    $0x10,%esp
80105c4a:	29 d8                	sub    %ebx,%eax
80105c4c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105c4f:	73 2f                	jae    80105c80 <sys_sleep+0x90>
    if(myproc()->killed){
80105c51:	e8 ea df ff ff       	call   80103c40 <myproc>
80105c56:	8b 40 24             	mov    0x24(%eax),%eax
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	74 d3                	je     80105c30 <sys_sleep+0x40>
      release(&tickslock);
80105c5d:	83 ec 0c             	sub    $0xc,%esp
80105c60:	68 a0 ff 11 80       	push   $0x8011ffa0
80105c65:	e8 f6 ed ff ff       	call   80104a60 <release>
      return -1;
80105c6a:	83 c4 10             	add    $0x10,%esp
80105c6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105c72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c75:	c9                   	leave  
80105c76:	c3                   	ret    
80105c77:	89 f6                	mov    %esi,%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105c80:	83 ec 0c             	sub    $0xc,%esp
80105c83:	68 a0 ff 11 80       	push   $0x8011ffa0
80105c88:	e8 d3 ed ff ff       	call   80104a60 <release>
  return 0;
80105c8d:	83 c4 10             	add    $0x10,%esp
80105c90:	31 c0                	xor    %eax,%eax
}
80105c92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c95:	c9                   	leave  
80105c96:	c3                   	ret    
    return -1;
80105c97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9c:	eb f4                	jmp    80105c92 <sys_sleep+0xa2>
80105c9e:	66 90                	xchg   %ax,%ax

80105ca0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	53                   	push   %ebx
80105ca4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105ca7:	68 a0 ff 11 80       	push   $0x8011ffa0
80105cac:	e8 ef ec ff ff       	call   801049a0 <acquire>
  xticks = ticks;
80105cb1:	8b 1d e0 07 12 80    	mov    0x801207e0,%ebx
  release(&tickslock);
80105cb7:	c7 04 24 a0 ff 11 80 	movl   $0x8011ffa0,(%esp)
80105cbe:	e8 9d ed ff ff       	call   80104a60 <release>
  return xticks;
}
80105cc3:	89 d8                	mov    %ebx,%eax
80105cc5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105cc8:	c9                   	leave  
80105cc9:	c3                   	ret    

80105cca <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105cca:	1e                   	push   %ds
  pushl %es
80105ccb:	06                   	push   %es
  pushl %fs
80105ccc:	0f a0                	push   %fs
  pushl %gs
80105cce:	0f a8                	push   %gs
  pushal
80105cd0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105cd1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105cd5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105cd7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105cd9:	54                   	push   %esp
  call trap
80105cda:	e8 c1 00 00 00       	call   80105da0 <trap>
  addl $4, %esp
80105cdf:	83 c4 04             	add    $0x4,%esp

80105ce2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105ce2:	61                   	popa   
  popl %gs
80105ce3:	0f a9                	pop    %gs
  popl %fs
80105ce5:	0f a1                	pop    %fs
  popl %es
80105ce7:	07                   	pop    %es
  popl %ds
80105ce8:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105ce9:	83 c4 08             	add    $0x8,%esp
  iret
80105cec:	cf                   	iret   
80105ced:	66 90                	xchg   %ax,%ax
80105cef:	90                   	nop

80105cf0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105cf0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105cf1:	31 c0                	xor    %eax,%eax
{
80105cf3:	89 e5                	mov    %esp,%ebp
80105cf5:	83 ec 08             	sub    $0x8,%esp
80105cf8:	90                   	nop
80105cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105d00:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105d07:	c7 04 c5 e2 ff 11 80 	movl   $0x8e000008,-0x7fee001e(,%eax,8)
80105d0e:	08 00 00 8e 
80105d12:	66 89 14 c5 e0 ff 11 	mov    %dx,-0x7fee0020(,%eax,8)
80105d19:	80 
80105d1a:	c1 ea 10             	shr    $0x10,%edx
80105d1d:	66 89 14 c5 e6 ff 11 	mov    %dx,-0x7fee001a(,%eax,8)
80105d24:	80 
  for(i = 0; i < 256; i++)
80105d25:	83 c0 01             	add    $0x1,%eax
80105d28:	3d 00 01 00 00       	cmp    $0x100,%eax
80105d2d:	75 d1                	jne    80105d00 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d2f:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80105d34:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d37:	c7 05 e2 01 12 80 08 	movl   $0xef000008,0x801201e2
80105d3e:	00 00 ef 
  initlock(&tickslock, "time");
80105d41:	68 15 85 10 80       	push   $0x80108515
80105d46:	68 a0 ff 11 80       	push   $0x8011ffa0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d4b:	66 a3 e0 01 12 80    	mov    %ax,0x801201e0
80105d51:	c1 e8 10             	shr    $0x10,%eax
80105d54:	66 a3 e6 01 12 80    	mov    %ax,0x801201e6
  initlock(&tickslock, "time");
80105d5a:	e8 01 eb ff ff       	call   80104860 <initlock>
}
80105d5f:	83 c4 10             	add    $0x10,%esp
80105d62:	c9                   	leave  
80105d63:	c3                   	ret    
80105d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105d70 <idtinit>:

void
idtinit(void)
{
80105d70:	55                   	push   %ebp
  pd[0] = size-1;
80105d71:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105d76:	89 e5                	mov    %esp,%ebp
80105d78:	83 ec 10             	sub    $0x10,%esp
80105d7b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105d7f:	b8 e0 ff 11 80       	mov    $0x8011ffe0,%eax
80105d84:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105d88:	c1 e8 10             	shr    $0x10,%eax
80105d8b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105d8f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105d92:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105d95:	c9                   	leave  
80105d96:	c3                   	ret    
80105d97:	89 f6                	mov    %esi,%esi
80105d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105da0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	57                   	push   %edi
80105da4:	56                   	push   %esi
80105da5:	53                   	push   %ebx
80105da6:	83 ec 1c             	sub    $0x1c,%esp
80105da9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105dac:	8b 47 30             	mov    0x30(%edi),%eax
80105daf:	83 f8 40             	cmp    $0x40,%eax
80105db2:	0f 84 f0 00 00 00    	je     80105ea8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105db8:	83 e8 0e             	sub    $0xe,%eax
80105dbb:	83 f8 31             	cmp    $0x31,%eax
80105dbe:	77 10                	ja     80105dd0 <trap+0x30>
80105dc0:	ff 24 85 bc 85 10 80 	jmp    *-0x7fef7a44(,%eax,4)
80105dc7:	89 f6                	mov    %esi,%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    UpdatePageCounters();
    Handle_PGFLT(rcr2());
    break;
  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105dd0:	e8 6b de ff ff       	call   80103c40 <myproc>
80105dd5:	85 c0                	test   %eax,%eax
80105dd7:	8b 5f 38             	mov    0x38(%edi),%ebx
80105dda:	0f 84 14 02 00 00    	je     80105ff4 <trap+0x254>
80105de0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105de4:	0f 84 0a 02 00 00    	je     80105ff4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105dea:	0f 20 d1             	mov    %cr2,%ecx
80105ded:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105df0:	e8 2b de ff ff       	call   80103c20 <cpuid>
80105df5:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105df8:	8b 47 34             	mov    0x34(%edi),%eax
80105dfb:	8b 77 30             	mov    0x30(%edi),%esi
80105dfe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105e01:	e8 3a de ff ff       	call   80103c40 <myproc>
80105e06:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105e09:	e8 32 de ff ff       	call   80103c40 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105e0e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105e11:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105e14:	51                   	push   %ecx
80105e15:	53                   	push   %ebx
80105e16:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105e17:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105e1a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105e1d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105e1e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105e21:	52                   	push   %edx
80105e22:	ff 70 10             	pushl  0x10(%eax)
80105e25:	68 78 85 10 80       	push   $0x80108578
80105e2a:	e8 31 a8 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105e2f:	83 c4 20             	add    $0x20,%esp
80105e32:	e8 09 de ff ff       	call   80103c40 <myproc>
80105e37:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105e3e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e40:	e8 fb dd ff ff       	call   80103c40 <myproc>
80105e45:	85 c0                	test   %eax,%eax
80105e47:	74 1d                	je     80105e66 <trap+0xc6>
80105e49:	e8 f2 dd ff ff       	call   80103c40 <myproc>
80105e4e:	8b 50 24             	mov    0x24(%eax),%edx
80105e51:	85 d2                	test   %edx,%edx
80105e53:	74 11                	je     80105e66 <trap+0xc6>
80105e55:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105e59:	83 e0 03             	and    $0x3,%eax
80105e5c:	66 83 f8 03          	cmp    $0x3,%ax
80105e60:	0f 84 4a 01 00 00    	je     80105fb0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105e66:	e8 d5 dd ff ff       	call   80103c40 <myproc>
80105e6b:	85 c0                	test   %eax,%eax
80105e6d:	74 0b                	je     80105e7a <trap+0xda>
80105e6f:	e8 cc dd ff ff       	call   80103c40 <myproc>
80105e74:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105e78:	74 66                	je     80105ee0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e7a:	e8 c1 dd ff ff       	call   80103c40 <myproc>
80105e7f:	85 c0                	test   %eax,%eax
80105e81:	74 19                	je     80105e9c <trap+0xfc>
80105e83:	e8 b8 dd ff ff       	call   80103c40 <myproc>
80105e88:	8b 40 24             	mov    0x24(%eax),%eax
80105e8b:	85 c0                	test   %eax,%eax
80105e8d:	74 0d                	je     80105e9c <trap+0xfc>
80105e8f:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105e93:	83 e0 03             	and    $0x3,%eax
80105e96:	66 83 f8 03          	cmp    $0x3,%ax
80105e9a:	74 35                	je     80105ed1 <trap+0x131>
    exit();
}
80105e9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e9f:	5b                   	pop    %ebx
80105ea0:	5e                   	pop    %esi
80105ea1:	5f                   	pop    %edi
80105ea2:	5d                   	pop    %ebp
80105ea3:	c3                   	ret    
80105ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105ea8:	e8 93 dd ff ff       	call   80103c40 <myproc>
80105ead:	8b 58 24             	mov    0x24(%eax),%ebx
80105eb0:	85 db                	test   %ebx,%ebx
80105eb2:	0f 85 e8 00 00 00    	jne    80105fa0 <trap+0x200>
    myproc()->tf = tf;
80105eb8:	e8 83 dd ff ff       	call   80103c40 <myproc>
80105ebd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105ec0:	e8 db ef ff ff       	call   80104ea0 <syscall>
    if(myproc()->killed)
80105ec5:	e8 76 dd ff ff       	call   80103c40 <myproc>
80105eca:	8b 48 24             	mov    0x24(%eax),%ecx
80105ecd:	85 c9                	test   %ecx,%ecx
80105ecf:	74 cb                	je     80105e9c <trap+0xfc>
}
80105ed1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ed4:	5b                   	pop    %ebx
80105ed5:	5e                   	pop    %esi
80105ed6:	5f                   	pop    %edi
80105ed7:	5d                   	pop    %ebp
      exit();
80105ed8:	e9 73 e2 ff ff       	jmp    80104150 <exit>
80105edd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105ee0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105ee4:	75 94                	jne    80105e7a <trap+0xda>
    yield();
80105ee6:	e8 95 e3 ff ff       	call   80104280 <yield>
80105eeb:	eb 8d                	jmp    80105e7a <trap+0xda>
80105eed:	8d 76 00             	lea    0x0(%esi),%esi
    UpdatePageCounters();
80105ef0:	e8 6b 1d 00 00       	call   80107c60 <UpdatePageCounters>
80105ef5:	0f 20 d0             	mov    %cr2,%eax
    Handle_PGFLT(rcr2());
80105ef8:	83 ec 0c             	sub    $0xc,%esp
80105efb:	50                   	push   %eax
80105efc:	e8 8f 18 00 00       	call   80107790 <Handle_PGFLT>
    break;
80105f01:	83 c4 10             	add    $0x10,%esp
80105f04:	e9 37 ff ff ff       	jmp    80105e40 <trap+0xa0>
80105f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105f10:	e8 0b dd ff ff       	call   80103c20 <cpuid>
80105f15:	85 c0                	test   %eax,%eax
80105f17:	0f 84 a3 00 00 00    	je     80105fc0 <trap+0x220>
    lapiceoi();
80105f1d:	e8 0e cc ff ff       	call   80102b30 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f22:	e8 19 dd ff ff       	call   80103c40 <myproc>
80105f27:	85 c0                	test   %eax,%eax
80105f29:	0f 85 1a ff ff ff    	jne    80105e49 <trap+0xa9>
80105f2f:	e9 32 ff ff ff       	jmp    80105e66 <trap+0xc6>
80105f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105f38:	e8 b3 ca ff ff       	call   801029f0 <kbdintr>
    lapiceoi();
80105f3d:	e8 ee cb ff ff       	call   80102b30 <lapiceoi>
    break;
80105f42:	e9 f9 fe ff ff       	jmp    80105e40 <trap+0xa0>
80105f47:	89 f6                	mov    %esi,%esi
80105f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    uartintr();
80105f50:	e8 3b 02 00 00       	call   80106190 <uartintr>
    lapiceoi();
80105f55:	e8 d6 cb ff ff       	call   80102b30 <lapiceoi>
    break;
80105f5a:	e9 e1 fe ff ff       	jmp    80105e40 <trap+0xa0>
80105f5f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f60:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105f64:	8b 77 38             	mov    0x38(%edi),%esi
80105f67:	e8 b4 dc ff ff       	call   80103c20 <cpuid>
80105f6c:	56                   	push   %esi
80105f6d:	53                   	push   %ebx
80105f6e:	50                   	push   %eax
80105f6f:	68 20 85 10 80       	push   $0x80108520
80105f74:	e8 e7 a6 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105f79:	e8 b2 cb ff ff       	call   80102b30 <lapiceoi>
    break;
80105f7e:	83 c4 10             	add    $0x10,%esp
80105f81:	e9 ba fe ff ff       	jmp    80105e40 <trap+0xa0>
80105f86:	8d 76 00             	lea    0x0(%esi),%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80105f90:	e8 bb c4 ff ff       	call   80102450 <ideintr>
80105f95:	eb 86                	jmp    80105f1d <trap+0x17d>
80105f97:	89 f6                	mov    %esi,%esi
80105f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
80105fa0:	e8 ab e1 ff ff       	call   80104150 <exit>
80105fa5:	e9 0e ff ff ff       	jmp    80105eb8 <trap+0x118>
80105faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105fb0:	e8 9b e1 ff ff       	call   80104150 <exit>
80105fb5:	e9 ac fe ff ff       	jmp    80105e66 <trap+0xc6>
80105fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105fc0:	83 ec 0c             	sub    $0xc,%esp
80105fc3:	68 a0 ff 11 80       	push   $0x8011ffa0
80105fc8:	e8 d3 e9 ff ff       	call   801049a0 <acquire>
      wakeup(&ticks);
80105fcd:	c7 04 24 e0 07 12 80 	movl   $0x801207e0,(%esp)
      ticks++;
80105fd4:	83 05 e0 07 12 80 01 	addl   $0x1,0x801207e0
      wakeup(&ticks);
80105fdb:	e8 b0 e4 ff ff       	call   80104490 <wakeup>
      release(&tickslock);
80105fe0:	c7 04 24 a0 ff 11 80 	movl   $0x8011ffa0,(%esp)
80105fe7:	e8 74 ea ff ff       	call   80104a60 <release>
80105fec:	83 c4 10             	add    $0x10,%esp
80105fef:	e9 29 ff ff ff       	jmp    80105f1d <trap+0x17d>
80105ff4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105ff7:	e8 24 dc ff ff       	call   80103c20 <cpuid>
80105ffc:	83 ec 0c             	sub    $0xc,%esp
80105fff:	56                   	push   %esi
80106000:	53                   	push   %ebx
80106001:	50                   	push   %eax
80106002:	ff 77 30             	pushl  0x30(%edi)
80106005:	68 44 85 10 80       	push   $0x80108544
8010600a:	e8 51 a6 ff ff       	call   80100660 <cprintf>
      panic("trap");
8010600f:	83 c4 14             	add    $0x14,%esp
80106012:	68 1a 85 10 80       	push   $0x8010851a
80106017:	e8 74 a3 ff ff       	call   80100390 <panic>
8010601c:	66 90                	xchg   %ax,%ax
8010601e:	66 90                	xchg   %ax,%ax

80106020 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106020:	a1 e0 c5 10 80       	mov    0x8010c5e0,%eax
{
80106025:	55                   	push   %ebp
80106026:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106028:	85 c0                	test   %eax,%eax
8010602a:	74 1c                	je     80106048 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010602c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106031:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106032:	a8 01                	test   $0x1,%al
80106034:	74 12                	je     80106048 <uartgetc+0x28>
80106036:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010603b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010603c:	0f b6 c0             	movzbl %al,%eax
}
8010603f:	5d                   	pop    %ebp
80106040:	c3                   	ret    
80106041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106048:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010604d:	5d                   	pop    %ebp
8010604e:	c3                   	ret    
8010604f:	90                   	nop

80106050 <uartputc.part.0>:
uartputc(int c)
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	57                   	push   %edi
80106054:	56                   	push   %esi
80106055:	53                   	push   %ebx
80106056:	89 c7                	mov    %eax,%edi
80106058:	bb 80 00 00 00       	mov    $0x80,%ebx
8010605d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106062:	83 ec 0c             	sub    $0xc,%esp
80106065:	eb 1b                	jmp    80106082 <uartputc.part.0+0x32>
80106067:	89 f6                	mov    %esi,%esi
80106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106070:	83 ec 0c             	sub    $0xc,%esp
80106073:	6a 0a                	push   $0xa
80106075:	e8 d6 ca ff ff       	call   80102b50 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010607a:	83 c4 10             	add    $0x10,%esp
8010607d:	83 eb 01             	sub    $0x1,%ebx
80106080:	74 07                	je     80106089 <uartputc.part.0+0x39>
80106082:	89 f2                	mov    %esi,%edx
80106084:	ec                   	in     (%dx),%al
80106085:	a8 20                	test   $0x20,%al
80106087:	74 e7                	je     80106070 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106089:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010608e:	89 f8                	mov    %edi,%eax
80106090:	ee                   	out    %al,(%dx)
}
80106091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106094:	5b                   	pop    %ebx
80106095:	5e                   	pop    %esi
80106096:	5f                   	pop    %edi
80106097:	5d                   	pop    %ebp
80106098:	c3                   	ret    
80106099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801060a0 <uartinit>:
{
801060a0:	55                   	push   %ebp
801060a1:	31 c9                	xor    %ecx,%ecx
801060a3:	89 c8                	mov    %ecx,%eax
801060a5:	89 e5                	mov    %esp,%ebp
801060a7:	57                   	push   %edi
801060a8:	56                   	push   %esi
801060a9:	53                   	push   %ebx
801060aa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801060af:	89 da                	mov    %ebx,%edx
801060b1:	83 ec 0c             	sub    $0xc,%esp
801060b4:	ee                   	out    %al,(%dx)
801060b5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801060ba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801060bf:	89 fa                	mov    %edi,%edx
801060c1:	ee                   	out    %al,(%dx)
801060c2:	b8 0c 00 00 00       	mov    $0xc,%eax
801060c7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060cc:	ee                   	out    %al,(%dx)
801060cd:	be f9 03 00 00       	mov    $0x3f9,%esi
801060d2:	89 c8                	mov    %ecx,%eax
801060d4:	89 f2                	mov    %esi,%edx
801060d6:	ee                   	out    %al,(%dx)
801060d7:	b8 03 00 00 00       	mov    $0x3,%eax
801060dc:	89 fa                	mov    %edi,%edx
801060de:	ee                   	out    %al,(%dx)
801060df:	ba fc 03 00 00       	mov    $0x3fc,%edx
801060e4:	89 c8                	mov    %ecx,%eax
801060e6:	ee                   	out    %al,(%dx)
801060e7:	b8 01 00 00 00       	mov    $0x1,%eax
801060ec:	89 f2                	mov    %esi,%edx
801060ee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801060ef:	ba fd 03 00 00       	mov    $0x3fd,%edx
801060f4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801060f5:	3c ff                	cmp    $0xff,%al
801060f7:	74 5a                	je     80106153 <uartinit+0xb3>
  uart = 1;
801060f9:	c7 05 e0 c5 10 80 01 	movl   $0x1,0x8010c5e0
80106100:	00 00 00 
80106103:	89 da                	mov    %ebx,%edx
80106105:	ec                   	in     (%dx),%al
80106106:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010610b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010610c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010610f:	bb 84 86 10 80       	mov    $0x80108684,%ebx
  ioapicenable(IRQ_COM1, 0);
80106114:	6a 00                	push   $0x0
80106116:	6a 04                	push   $0x4
80106118:	e8 83 c5 ff ff       	call   801026a0 <ioapicenable>
8010611d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106120:	b8 78 00 00 00       	mov    $0x78,%eax
80106125:	eb 13                	jmp    8010613a <uartinit+0x9a>
80106127:	89 f6                	mov    %esi,%esi
80106129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106130:	83 c3 01             	add    $0x1,%ebx
80106133:	0f be 03             	movsbl (%ebx),%eax
80106136:	84 c0                	test   %al,%al
80106138:	74 19                	je     80106153 <uartinit+0xb3>
  if(!uart)
8010613a:	8b 15 e0 c5 10 80    	mov    0x8010c5e0,%edx
80106140:	85 d2                	test   %edx,%edx
80106142:	74 ec                	je     80106130 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106144:	83 c3 01             	add    $0x1,%ebx
80106147:	e8 04 ff ff ff       	call   80106050 <uartputc.part.0>
8010614c:	0f be 03             	movsbl (%ebx),%eax
8010614f:	84 c0                	test   %al,%al
80106151:	75 e7                	jne    8010613a <uartinit+0x9a>
}
80106153:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106156:	5b                   	pop    %ebx
80106157:	5e                   	pop    %esi
80106158:	5f                   	pop    %edi
80106159:	5d                   	pop    %ebp
8010615a:	c3                   	ret    
8010615b:	90                   	nop
8010615c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106160 <uartputc>:
  if(!uart)
80106160:	8b 15 e0 c5 10 80    	mov    0x8010c5e0,%edx
{
80106166:	55                   	push   %ebp
80106167:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106169:	85 d2                	test   %edx,%edx
{
8010616b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010616e:	74 10                	je     80106180 <uartputc+0x20>
}
80106170:	5d                   	pop    %ebp
80106171:	e9 da fe ff ff       	jmp    80106050 <uartputc.part.0>
80106176:	8d 76 00             	lea    0x0(%esi),%esi
80106179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106180:	5d                   	pop    %ebp
80106181:	c3                   	ret    
80106182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106190 <uartintr>:

void
uartintr(void)
{
80106190:	55                   	push   %ebp
80106191:	89 e5                	mov    %esp,%ebp
80106193:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106196:	68 20 60 10 80       	push   $0x80106020
8010619b:	e8 70 a6 ff ff       	call   80100810 <consoleintr>
}
801061a0:	83 c4 10             	add    $0x10,%esp
801061a3:	c9                   	leave  
801061a4:	c3                   	ret    

801061a5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801061a5:	6a 00                	push   $0x0
  pushl $0
801061a7:	6a 00                	push   $0x0
  jmp alltraps
801061a9:	e9 1c fb ff ff       	jmp    80105cca <alltraps>

801061ae <vector1>:
.globl vector1
vector1:
  pushl $0
801061ae:	6a 00                	push   $0x0
  pushl $1
801061b0:	6a 01                	push   $0x1
  jmp alltraps
801061b2:	e9 13 fb ff ff       	jmp    80105cca <alltraps>

801061b7 <vector2>:
.globl vector2
vector2:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $2
801061b9:	6a 02                	push   $0x2
  jmp alltraps
801061bb:	e9 0a fb ff ff       	jmp    80105cca <alltraps>

801061c0 <vector3>:
.globl vector3
vector3:
  pushl $0
801061c0:	6a 00                	push   $0x0
  pushl $3
801061c2:	6a 03                	push   $0x3
  jmp alltraps
801061c4:	e9 01 fb ff ff       	jmp    80105cca <alltraps>

801061c9 <vector4>:
.globl vector4
vector4:
  pushl $0
801061c9:	6a 00                	push   $0x0
  pushl $4
801061cb:	6a 04                	push   $0x4
  jmp alltraps
801061cd:	e9 f8 fa ff ff       	jmp    80105cca <alltraps>

801061d2 <vector5>:
.globl vector5
vector5:
  pushl $0
801061d2:	6a 00                	push   $0x0
  pushl $5
801061d4:	6a 05                	push   $0x5
  jmp alltraps
801061d6:	e9 ef fa ff ff       	jmp    80105cca <alltraps>

801061db <vector6>:
.globl vector6
vector6:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $6
801061dd:	6a 06                	push   $0x6
  jmp alltraps
801061df:	e9 e6 fa ff ff       	jmp    80105cca <alltraps>

801061e4 <vector7>:
.globl vector7
vector7:
  pushl $0
801061e4:	6a 00                	push   $0x0
  pushl $7
801061e6:	6a 07                	push   $0x7
  jmp alltraps
801061e8:	e9 dd fa ff ff       	jmp    80105cca <alltraps>

801061ed <vector8>:
.globl vector8
vector8:
  pushl $8
801061ed:	6a 08                	push   $0x8
  jmp alltraps
801061ef:	e9 d6 fa ff ff       	jmp    80105cca <alltraps>

801061f4 <vector9>:
.globl vector9
vector9:
  pushl $0
801061f4:	6a 00                	push   $0x0
  pushl $9
801061f6:	6a 09                	push   $0x9
  jmp alltraps
801061f8:	e9 cd fa ff ff       	jmp    80105cca <alltraps>

801061fd <vector10>:
.globl vector10
vector10:
  pushl $10
801061fd:	6a 0a                	push   $0xa
  jmp alltraps
801061ff:	e9 c6 fa ff ff       	jmp    80105cca <alltraps>

80106204 <vector11>:
.globl vector11
vector11:
  pushl $11
80106204:	6a 0b                	push   $0xb
  jmp alltraps
80106206:	e9 bf fa ff ff       	jmp    80105cca <alltraps>

8010620b <vector12>:
.globl vector12
vector12:
  pushl $12
8010620b:	6a 0c                	push   $0xc
  jmp alltraps
8010620d:	e9 b8 fa ff ff       	jmp    80105cca <alltraps>

80106212 <vector13>:
.globl vector13
vector13:
  pushl $13
80106212:	6a 0d                	push   $0xd
  jmp alltraps
80106214:	e9 b1 fa ff ff       	jmp    80105cca <alltraps>

80106219 <vector14>:
.globl vector14
vector14:
  pushl $14
80106219:	6a 0e                	push   $0xe
  jmp alltraps
8010621b:	e9 aa fa ff ff       	jmp    80105cca <alltraps>

80106220 <vector15>:
.globl vector15
vector15:
  pushl $0
80106220:	6a 00                	push   $0x0
  pushl $15
80106222:	6a 0f                	push   $0xf
  jmp alltraps
80106224:	e9 a1 fa ff ff       	jmp    80105cca <alltraps>

80106229 <vector16>:
.globl vector16
vector16:
  pushl $0
80106229:	6a 00                	push   $0x0
  pushl $16
8010622b:	6a 10                	push   $0x10
  jmp alltraps
8010622d:	e9 98 fa ff ff       	jmp    80105cca <alltraps>

80106232 <vector17>:
.globl vector17
vector17:
  pushl $17
80106232:	6a 11                	push   $0x11
  jmp alltraps
80106234:	e9 91 fa ff ff       	jmp    80105cca <alltraps>

80106239 <vector18>:
.globl vector18
vector18:
  pushl $0
80106239:	6a 00                	push   $0x0
  pushl $18
8010623b:	6a 12                	push   $0x12
  jmp alltraps
8010623d:	e9 88 fa ff ff       	jmp    80105cca <alltraps>

80106242 <vector19>:
.globl vector19
vector19:
  pushl $0
80106242:	6a 00                	push   $0x0
  pushl $19
80106244:	6a 13                	push   $0x13
  jmp alltraps
80106246:	e9 7f fa ff ff       	jmp    80105cca <alltraps>

8010624b <vector20>:
.globl vector20
vector20:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $20
8010624d:	6a 14                	push   $0x14
  jmp alltraps
8010624f:	e9 76 fa ff ff       	jmp    80105cca <alltraps>

80106254 <vector21>:
.globl vector21
vector21:
  pushl $0
80106254:	6a 00                	push   $0x0
  pushl $21
80106256:	6a 15                	push   $0x15
  jmp alltraps
80106258:	e9 6d fa ff ff       	jmp    80105cca <alltraps>

8010625d <vector22>:
.globl vector22
vector22:
  pushl $0
8010625d:	6a 00                	push   $0x0
  pushl $22
8010625f:	6a 16                	push   $0x16
  jmp alltraps
80106261:	e9 64 fa ff ff       	jmp    80105cca <alltraps>

80106266 <vector23>:
.globl vector23
vector23:
  pushl $0
80106266:	6a 00                	push   $0x0
  pushl $23
80106268:	6a 17                	push   $0x17
  jmp alltraps
8010626a:	e9 5b fa ff ff       	jmp    80105cca <alltraps>

8010626f <vector24>:
.globl vector24
vector24:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $24
80106271:	6a 18                	push   $0x18
  jmp alltraps
80106273:	e9 52 fa ff ff       	jmp    80105cca <alltraps>

80106278 <vector25>:
.globl vector25
vector25:
  pushl $0
80106278:	6a 00                	push   $0x0
  pushl $25
8010627a:	6a 19                	push   $0x19
  jmp alltraps
8010627c:	e9 49 fa ff ff       	jmp    80105cca <alltraps>

80106281 <vector26>:
.globl vector26
vector26:
  pushl $0
80106281:	6a 00                	push   $0x0
  pushl $26
80106283:	6a 1a                	push   $0x1a
  jmp alltraps
80106285:	e9 40 fa ff ff       	jmp    80105cca <alltraps>

8010628a <vector27>:
.globl vector27
vector27:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $27
8010628c:	6a 1b                	push   $0x1b
  jmp alltraps
8010628e:	e9 37 fa ff ff       	jmp    80105cca <alltraps>

80106293 <vector28>:
.globl vector28
vector28:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $28
80106295:	6a 1c                	push   $0x1c
  jmp alltraps
80106297:	e9 2e fa ff ff       	jmp    80105cca <alltraps>

8010629c <vector29>:
.globl vector29
vector29:
  pushl $0
8010629c:	6a 00                	push   $0x0
  pushl $29
8010629e:	6a 1d                	push   $0x1d
  jmp alltraps
801062a0:	e9 25 fa ff ff       	jmp    80105cca <alltraps>

801062a5 <vector30>:
.globl vector30
vector30:
  pushl $0
801062a5:	6a 00                	push   $0x0
  pushl $30
801062a7:	6a 1e                	push   $0x1e
  jmp alltraps
801062a9:	e9 1c fa ff ff       	jmp    80105cca <alltraps>

801062ae <vector31>:
.globl vector31
vector31:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $31
801062b0:	6a 1f                	push   $0x1f
  jmp alltraps
801062b2:	e9 13 fa ff ff       	jmp    80105cca <alltraps>

801062b7 <vector32>:
.globl vector32
vector32:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $32
801062b9:	6a 20                	push   $0x20
  jmp alltraps
801062bb:	e9 0a fa ff ff       	jmp    80105cca <alltraps>

801062c0 <vector33>:
.globl vector33
vector33:
  pushl $0
801062c0:	6a 00                	push   $0x0
  pushl $33
801062c2:	6a 21                	push   $0x21
  jmp alltraps
801062c4:	e9 01 fa ff ff       	jmp    80105cca <alltraps>

801062c9 <vector34>:
.globl vector34
vector34:
  pushl $0
801062c9:	6a 00                	push   $0x0
  pushl $34
801062cb:	6a 22                	push   $0x22
  jmp alltraps
801062cd:	e9 f8 f9 ff ff       	jmp    80105cca <alltraps>

801062d2 <vector35>:
.globl vector35
vector35:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $35
801062d4:	6a 23                	push   $0x23
  jmp alltraps
801062d6:	e9 ef f9 ff ff       	jmp    80105cca <alltraps>

801062db <vector36>:
.globl vector36
vector36:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $36
801062dd:	6a 24                	push   $0x24
  jmp alltraps
801062df:	e9 e6 f9 ff ff       	jmp    80105cca <alltraps>

801062e4 <vector37>:
.globl vector37
vector37:
  pushl $0
801062e4:	6a 00                	push   $0x0
  pushl $37
801062e6:	6a 25                	push   $0x25
  jmp alltraps
801062e8:	e9 dd f9 ff ff       	jmp    80105cca <alltraps>

801062ed <vector38>:
.globl vector38
vector38:
  pushl $0
801062ed:	6a 00                	push   $0x0
  pushl $38
801062ef:	6a 26                	push   $0x26
  jmp alltraps
801062f1:	e9 d4 f9 ff ff       	jmp    80105cca <alltraps>

801062f6 <vector39>:
.globl vector39
vector39:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $39
801062f8:	6a 27                	push   $0x27
  jmp alltraps
801062fa:	e9 cb f9 ff ff       	jmp    80105cca <alltraps>

801062ff <vector40>:
.globl vector40
vector40:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $40
80106301:	6a 28                	push   $0x28
  jmp alltraps
80106303:	e9 c2 f9 ff ff       	jmp    80105cca <alltraps>

80106308 <vector41>:
.globl vector41
vector41:
  pushl $0
80106308:	6a 00                	push   $0x0
  pushl $41
8010630a:	6a 29                	push   $0x29
  jmp alltraps
8010630c:	e9 b9 f9 ff ff       	jmp    80105cca <alltraps>

80106311 <vector42>:
.globl vector42
vector42:
  pushl $0
80106311:	6a 00                	push   $0x0
  pushl $42
80106313:	6a 2a                	push   $0x2a
  jmp alltraps
80106315:	e9 b0 f9 ff ff       	jmp    80105cca <alltraps>

8010631a <vector43>:
.globl vector43
vector43:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $43
8010631c:	6a 2b                	push   $0x2b
  jmp alltraps
8010631e:	e9 a7 f9 ff ff       	jmp    80105cca <alltraps>

80106323 <vector44>:
.globl vector44
vector44:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $44
80106325:	6a 2c                	push   $0x2c
  jmp alltraps
80106327:	e9 9e f9 ff ff       	jmp    80105cca <alltraps>

8010632c <vector45>:
.globl vector45
vector45:
  pushl $0
8010632c:	6a 00                	push   $0x0
  pushl $45
8010632e:	6a 2d                	push   $0x2d
  jmp alltraps
80106330:	e9 95 f9 ff ff       	jmp    80105cca <alltraps>

80106335 <vector46>:
.globl vector46
vector46:
  pushl $0
80106335:	6a 00                	push   $0x0
  pushl $46
80106337:	6a 2e                	push   $0x2e
  jmp alltraps
80106339:	e9 8c f9 ff ff       	jmp    80105cca <alltraps>

8010633e <vector47>:
.globl vector47
vector47:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $47
80106340:	6a 2f                	push   $0x2f
  jmp alltraps
80106342:	e9 83 f9 ff ff       	jmp    80105cca <alltraps>

80106347 <vector48>:
.globl vector48
vector48:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $48
80106349:	6a 30                	push   $0x30
  jmp alltraps
8010634b:	e9 7a f9 ff ff       	jmp    80105cca <alltraps>

80106350 <vector49>:
.globl vector49
vector49:
  pushl $0
80106350:	6a 00                	push   $0x0
  pushl $49
80106352:	6a 31                	push   $0x31
  jmp alltraps
80106354:	e9 71 f9 ff ff       	jmp    80105cca <alltraps>

80106359 <vector50>:
.globl vector50
vector50:
  pushl $0
80106359:	6a 00                	push   $0x0
  pushl $50
8010635b:	6a 32                	push   $0x32
  jmp alltraps
8010635d:	e9 68 f9 ff ff       	jmp    80105cca <alltraps>

80106362 <vector51>:
.globl vector51
vector51:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $51
80106364:	6a 33                	push   $0x33
  jmp alltraps
80106366:	e9 5f f9 ff ff       	jmp    80105cca <alltraps>

8010636b <vector52>:
.globl vector52
vector52:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $52
8010636d:	6a 34                	push   $0x34
  jmp alltraps
8010636f:	e9 56 f9 ff ff       	jmp    80105cca <alltraps>

80106374 <vector53>:
.globl vector53
vector53:
  pushl $0
80106374:	6a 00                	push   $0x0
  pushl $53
80106376:	6a 35                	push   $0x35
  jmp alltraps
80106378:	e9 4d f9 ff ff       	jmp    80105cca <alltraps>

8010637d <vector54>:
.globl vector54
vector54:
  pushl $0
8010637d:	6a 00                	push   $0x0
  pushl $54
8010637f:	6a 36                	push   $0x36
  jmp alltraps
80106381:	e9 44 f9 ff ff       	jmp    80105cca <alltraps>

80106386 <vector55>:
.globl vector55
vector55:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $55
80106388:	6a 37                	push   $0x37
  jmp alltraps
8010638a:	e9 3b f9 ff ff       	jmp    80105cca <alltraps>

8010638f <vector56>:
.globl vector56
vector56:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $56
80106391:	6a 38                	push   $0x38
  jmp alltraps
80106393:	e9 32 f9 ff ff       	jmp    80105cca <alltraps>

80106398 <vector57>:
.globl vector57
vector57:
  pushl $0
80106398:	6a 00                	push   $0x0
  pushl $57
8010639a:	6a 39                	push   $0x39
  jmp alltraps
8010639c:	e9 29 f9 ff ff       	jmp    80105cca <alltraps>

801063a1 <vector58>:
.globl vector58
vector58:
  pushl $0
801063a1:	6a 00                	push   $0x0
  pushl $58
801063a3:	6a 3a                	push   $0x3a
  jmp alltraps
801063a5:	e9 20 f9 ff ff       	jmp    80105cca <alltraps>

801063aa <vector59>:
.globl vector59
vector59:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $59
801063ac:	6a 3b                	push   $0x3b
  jmp alltraps
801063ae:	e9 17 f9 ff ff       	jmp    80105cca <alltraps>

801063b3 <vector60>:
.globl vector60
vector60:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $60
801063b5:	6a 3c                	push   $0x3c
  jmp alltraps
801063b7:	e9 0e f9 ff ff       	jmp    80105cca <alltraps>

801063bc <vector61>:
.globl vector61
vector61:
  pushl $0
801063bc:	6a 00                	push   $0x0
  pushl $61
801063be:	6a 3d                	push   $0x3d
  jmp alltraps
801063c0:	e9 05 f9 ff ff       	jmp    80105cca <alltraps>

801063c5 <vector62>:
.globl vector62
vector62:
  pushl $0
801063c5:	6a 00                	push   $0x0
  pushl $62
801063c7:	6a 3e                	push   $0x3e
  jmp alltraps
801063c9:	e9 fc f8 ff ff       	jmp    80105cca <alltraps>

801063ce <vector63>:
.globl vector63
vector63:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $63
801063d0:	6a 3f                	push   $0x3f
  jmp alltraps
801063d2:	e9 f3 f8 ff ff       	jmp    80105cca <alltraps>

801063d7 <vector64>:
.globl vector64
vector64:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $64
801063d9:	6a 40                	push   $0x40
  jmp alltraps
801063db:	e9 ea f8 ff ff       	jmp    80105cca <alltraps>

801063e0 <vector65>:
.globl vector65
vector65:
  pushl $0
801063e0:	6a 00                	push   $0x0
  pushl $65
801063e2:	6a 41                	push   $0x41
  jmp alltraps
801063e4:	e9 e1 f8 ff ff       	jmp    80105cca <alltraps>

801063e9 <vector66>:
.globl vector66
vector66:
  pushl $0
801063e9:	6a 00                	push   $0x0
  pushl $66
801063eb:	6a 42                	push   $0x42
  jmp alltraps
801063ed:	e9 d8 f8 ff ff       	jmp    80105cca <alltraps>

801063f2 <vector67>:
.globl vector67
vector67:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $67
801063f4:	6a 43                	push   $0x43
  jmp alltraps
801063f6:	e9 cf f8 ff ff       	jmp    80105cca <alltraps>

801063fb <vector68>:
.globl vector68
vector68:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $68
801063fd:	6a 44                	push   $0x44
  jmp alltraps
801063ff:	e9 c6 f8 ff ff       	jmp    80105cca <alltraps>

80106404 <vector69>:
.globl vector69
vector69:
  pushl $0
80106404:	6a 00                	push   $0x0
  pushl $69
80106406:	6a 45                	push   $0x45
  jmp alltraps
80106408:	e9 bd f8 ff ff       	jmp    80105cca <alltraps>

8010640d <vector70>:
.globl vector70
vector70:
  pushl $0
8010640d:	6a 00                	push   $0x0
  pushl $70
8010640f:	6a 46                	push   $0x46
  jmp alltraps
80106411:	e9 b4 f8 ff ff       	jmp    80105cca <alltraps>

80106416 <vector71>:
.globl vector71
vector71:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $71
80106418:	6a 47                	push   $0x47
  jmp alltraps
8010641a:	e9 ab f8 ff ff       	jmp    80105cca <alltraps>

8010641f <vector72>:
.globl vector72
vector72:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $72
80106421:	6a 48                	push   $0x48
  jmp alltraps
80106423:	e9 a2 f8 ff ff       	jmp    80105cca <alltraps>

80106428 <vector73>:
.globl vector73
vector73:
  pushl $0
80106428:	6a 00                	push   $0x0
  pushl $73
8010642a:	6a 49                	push   $0x49
  jmp alltraps
8010642c:	e9 99 f8 ff ff       	jmp    80105cca <alltraps>

80106431 <vector74>:
.globl vector74
vector74:
  pushl $0
80106431:	6a 00                	push   $0x0
  pushl $74
80106433:	6a 4a                	push   $0x4a
  jmp alltraps
80106435:	e9 90 f8 ff ff       	jmp    80105cca <alltraps>

8010643a <vector75>:
.globl vector75
vector75:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $75
8010643c:	6a 4b                	push   $0x4b
  jmp alltraps
8010643e:	e9 87 f8 ff ff       	jmp    80105cca <alltraps>

80106443 <vector76>:
.globl vector76
vector76:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $76
80106445:	6a 4c                	push   $0x4c
  jmp alltraps
80106447:	e9 7e f8 ff ff       	jmp    80105cca <alltraps>

8010644c <vector77>:
.globl vector77
vector77:
  pushl $0
8010644c:	6a 00                	push   $0x0
  pushl $77
8010644e:	6a 4d                	push   $0x4d
  jmp alltraps
80106450:	e9 75 f8 ff ff       	jmp    80105cca <alltraps>

80106455 <vector78>:
.globl vector78
vector78:
  pushl $0
80106455:	6a 00                	push   $0x0
  pushl $78
80106457:	6a 4e                	push   $0x4e
  jmp alltraps
80106459:	e9 6c f8 ff ff       	jmp    80105cca <alltraps>

8010645e <vector79>:
.globl vector79
vector79:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $79
80106460:	6a 4f                	push   $0x4f
  jmp alltraps
80106462:	e9 63 f8 ff ff       	jmp    80105cca <alltraps>

80106467 <vector80>:
.globl vector80
vector80:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $80
80106469:	6a 50                	push   $0x50
  jmp alltraps
8010646b:	e9 5a f8 ff ff       	jmp    80105cca <alltraps>

80106470 <vector81>:
.globl vector81
vector81:
  pushl $0
80106470:	6a 00                	push   $0x0
  pushl $81
80106472:	6a 51                	push   $0x51
  jmp alltraps
80106474:	e9 51 f8 ff ff       	jmp    80105cca <alltraps>

80106479 <vector82>:
.globl vector82
vector82:
  pushl $0
80106479:	6a 00                	push   $0x0
  pushl $82
8010647b:	6a 52                	push   $0x52
  jmp alltraps
8010647d:	e9 48 f8 ff ff       	jmp    80105cca <alltraps>

80106482 <vector83>:
.globl vector83
vector83:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $83
80106484:	6a 53                	push   $0x53
  jmp alltraps
80106486:	e9 3f f8 ff ff       	jmp    80105cca <alltraps>

8010648b <vector84>:
.globl vector84
vector84:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $84
8010648d:	6a 54                	push   $0x54
  jmp alltraps
8010648f:	e9 36 f8 ff ff       	jmp    80105cca <alltraps>

80106494 <vector85>:
.globl vector85
vector85:
  pushl $0
80106494:	6a 00                	push   $0x0
  pushl $85
80106496:	6a 55                	push   $0x55
  jmp alltraps
80106498:	e9 2d f8 ff ff       	jmp    80105cca <alltraps>

8010649d <vector86>:
.globl vector86
vector86:
  pushl $0
8010649d:	6a 00                	push   $0x0
  pushl $86
8010649f:	6a 56                	push   $0x56
  jmp alltraps
801064a1:	e9 24 f8 ff ff       	jmp    80105cca <alltraps>

801064a6 <vector87>:
.globl vector87
vector87:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $87
801064a8:	6a 57                	push   $0x57
  jmp alltraps
801064aa:	e9 1b f8 ff ff       	jmp    80105cca <alltraps>

801064af <vector88>:
.globl vector88
vector88:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $88
801064b1:	6a 58                	push   $0x58
  jmp alltraps
801064b3:	e9 12 f8 ff ff       	jmp    80105cca <alltraps>

801064b8 <vector89>:
.globl vector89
vector89:
  pushl $0
801064b8:	6a 00                	push   $0x0
  pushl $89
801064ba:	6a 59                	push   $0x59
  jmp alltraps
801064bc:	e9 09 f8 ff ff       	jmp    80105cca <alltraps>

801064c1 <vector90>:
.globl vector90
vector90:
  pushl $0
801064c1:	6a 00                	push   $0x0
  pushl $90
801064c3:	6a 5a                	push   $0x5a
  jmp alltraps
801064c5:	e9 00 f8 ff ff       	jmp    80105cca <alltraps>

801064ca <vector91>:
.globl vector91
vector91:
  pushl $0
801064ca:	6a 00                	push   $0x0
  pushl $91
801064cc:	6a 5b                	push   $0x5b
  jmp alltraps
801064ce:	e9 f7 f7 ff ff       	jmp    80105cca <alltraps>

801064d3 <vector92>:
.globl vector92
vector92:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $92
801064d5:	6a 5c                	push   $0x5c
  jmp alltraps
801064d7:	e9 ee f7 ff ff       	jmp    80105cca <alltraps>

801064dc <vector93>:
.globl vector93
vector93:
  pushl $0
801064dc:	6a 00                	push   $0x0
  pushl $93
801064de:	6a 5d                	push   $0x5d
  jmp alltraps
801064e0:	e9 e5 f7 ff ff       	jmp    80105cca <alltraps>

801064e5 <vector94>:
.globl vector94
vector94:
  pushl $0
801064e5:	6a 00                	push   $0x0
  pushl $94
801064e7:	6a 5e                	push   $0x5e
  jmp alltraps
801064e9:	e9 dc f7 ff ff       	jmp    80105cca <alltraps>

801064ee <vector95>:
.globl vector95
vector95:
  pushl $0
801064ee:	6a 00                	push   $0x0
  pushl $95
801064f0:	6a 5f                	push   $0x5f
  jmp alltraps
801064f2:	e9 d3 f7 ff ff       	jmp    80105cca <alltraps>

801064f7 <vector96>:
.globl vector96
vector96:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $96
801064f9:	6a 60                	push   $0x60
  jmp alltraps
801064fb:	e9 ca f7 ff ff       	jmp    80105cca <alltraps>

80106500 <vector97>:
.globl vector97
vector97:
  pushl $0
80106500:	6a 00                	push   $0x0
  pushl $97
80106502:	6a 61                	push   $0x61
  jmp alltraps
80106504:	e9 c1 f7 ff ff       	jmp    80105cca <alltraps>

80106509 <vector98>:
.globl vector98
vector98:
  pushl $0
80106509:	6a 00                	push   $0x0
  pushl $98
8010650b:	6a 62                	push   $0x62
  jmp alltraps
8010650d:	e9 b8 f7 ff ff       	jmp    80105cca <alltraps>

80106512 <vector99>:
.globl vector99
vector99:
  pushl $0
80106512:	6a 00                	push   $0x0
  pushl $99
80106514:	6a 63                	push   $0x63
  jmp alltraps
80106516:	e9 af f7 ff ff       	jmp    80105cca <alltraps>

8010651b <vector100>:
.globl vector100
vector100:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $100
8010651d:	6a 64                	push   $0x64
  jmp alltraps
8010651f:	e9 a6 f7 ff ff       	jmp    80105cca <alltraps>

80106524 <vector101>:
.globl vector101
vector101:
  pushl $0
80106524:	6a 00                	push   $0x0
  pushl $101
80106526:	6a 65                	push   $0x65
  jmp alltraps
80106528:	e9 9d f7 ff ff       	jmp    80105cca <alltraps>

8010652d <vector102>:
.globl vector102
vector102:
  pushl $0
8010652d:	6a 00                	push   $0x0
  pushl $102
8010652f:	6a 66                	push   $0x66
  jmp alltraps
80106531:	e9 94 f7 ff ff       	jmp    80105cca <alltraps>

80106536 <vector103>:
.globl vector103
vector103:
  pushl $0
80106536:	6a 00                	push   $0x0
  pushl $103
80106538:	6a 67                	push   $0x67
  jmp alltraps
8010653a:	e9 8b f7 ff ff       	jmp    80105cca <alltraps>

8010653f <vector104>:
.globl vector104
vector104:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $104
80106541:	6a 68                	push   $0x68
  jmp alltraps
80106543:	e9 82 f7 ff ff       	jmp    80105cca <alltraps>

80106548 <vector105>:
.globl vector105
vector105:
  pushl $0
80106548:	6a 00                	push   $0x0
  pushl $105
8010654a:	6a 69                	push   $0x69
  jmp alltraps
8010654c:	e9 79 f7 ff ff       	jmp    80105cca <alltraps>

80106551 <vector106>:
.globl vector106
vector106:
  pushl $0
80106551:	6a 00                	push   $0x0
  pushl $106
80106553:	6a 6a                	push   $0x6a
  jmp alltraps
80106555:	e9 70 f7 ff ff       	jmp    80105cca <alltraps>

8010655a <vector107>:
.globl vector107
vector107:
  pushl $0
8010655a:	6a 00                	push   $0x0
  pushl $107
8010655c:	6a 6b                	push   $0x6b
  jmp alltraps
8010655e:	e9 67 f7 ff ff       	jmp    80105cca <alltraps>

80106563 <vector108>:
.globl vector108
vector108:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $108
80106565:	6a 6c                	push   $0x6c
  jmp alltraps
80106567:	e9 5e f7 ff ff       	jmp    80105cca <alltraps>

8010656c <vector109>:
.globl vector109
vector109:
  pushl $0
8010656c:	6a 00                	push   $0x0
  pushl $109
8010656e:	6a 6d                	push   $0x6d
  jmp alltraps
80106570:	e9 55 f7 ff ff       	jmp    80105cca <alltraps>

80106575 <vector110>:
.globl vector110
vector110:
  pushl $0
80106575:	6a 00                	push   $0x0
  pushl $110
80106577:	6a 6e                	push   $0x6e
  jmp alltraps
80106579:	e9 4c f7 ff ff       	jmp    80105cca <alltraps>

8010657e <vector111>:
.globl vector111
vector111:
  pushl $0
8010657e:	6a 00                	push   $0x0
  pushl $111
80106580:	6a 6f                	push   $0x6f
  jmp alltraps
80106582:	e9 43 f7 ff ff       	jmp    80105cca <alltraps>

80106587 <vector112>:
.globl vector112
vector112:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $112
80106589:	6a 70                	push   $0x70
  jmp alltraps
8010658b:	e9 3a f7 ff ff       	jmp    80105cca <alltraps>

80106590 <vector113>:
.globl vector113
vector113:
  pushl $0
80106590:	6a 00                	push   $0x0
  pushl $113
80106592:	6a 71                	push   $0x71
  jmp alltraps
80106594:	e9 31 f7 ff ff       	jmp    80105cca <alltraps>

80106599 <vector114>:
.globl vector114
vector114:
  pushl $0
80106599:	6a 00                	push   $0x0
  pushl $114
8010659b:	6a 72                	push   $0x72
  jmp alltraps
8010659d:	e9 28 f7 ff ff       	jmp    80105cca <alltraps>

801065a2 <vector115>:
.globl vector115
vector115:
  pushl $0
801065a2:	6a 00                	push   $0x0
  pushl $115
801065a4:	6a 73                	push   $0x73
  jmp alltraps
801065a6:	e9 1f f7 ff ff       	jmp    80105cca <alltraps>

801065ab <vector116>:
.globl vector116
vector116:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $116
801065ad:	6a 74                	push   $0x74
  jmp alltraps
801065af:	e9 16 f7 ff ff       	jmp    80105cca <alltraps>

801065b4 <vector117>:
.globl vector117
vector117:
  pushl $0
801065b4:	6a 00                	push   $0x0
  pushl $117
801065b6:	6a 75                	push   $0x75
  jmp alltraps
801065b8:	e9 0d f7 ff ff       	jmp    80105cca <alltraps>

801065bd <vector118>:
.globl vector118
vector118:
  pushl $0
801065bd:	6a 00                	push   $0x0
  pushl $118
801065bf:	6a 76                	push   $0x76
  jmp alltraps
801065c1:	e9 04 f7 ff ff       	jmp    80105cca <alltraps>

801065c6 <vector119>:
.globl vector119
vector119:
  pushl $0
801065c6:	6a 00                	push   $0x0
  pushl $119
801065c8:	6a 77                	push   $0x77
  jmp alltraps
801065ca:	e9 fb f6 ff ff       	jmp    80105cca <alltraps>

801065cf <vector120>:
.globl vector120
vector120:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $120
801065d1:	6a 78                	push   $0x78
  jmp alltraps
801065d3:	e9 f2 f6 ff ff       	jmp    80105cca <alltraps>

801065d8 <vector121>:
.globl vector121
vector121:
  pushl $0
801065d8:	6a 00                	push   $0x0
  pushl $121
801065da:	6a 79                	push   $0x79
  jmp alltraps
801065dc:	e9 e9 f6 ff ff       	jmp    80105cca <alltraps>

801065e1 <vector122>:
.globl vector122
vector122:
  pushl $0
801065e1:	6a 00                	push   $0x0
  pushl $122
801065e3:	6a 7a                	push   $0x7a
  jmp alltraps
801065e5:	e9 e0 f6 ff ff       	jmp    80105cca <alltraps>

801065ea <vector123>:
.globl vector123
vector123:
  pushl $0
801065ea:	6a 00                	push   $0x0
  pushl $123
801065ec:	6a 7b                	push   $0x7b
  jmp alltraps
801065ee:	e9 d7 f6 ff ff       	jmp    80105cca <alltraps>

801065f3 <vector124>:
.globl vector124
vector124:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $124
801065f5:	6a 7c                	push   $0x7c
  jmp alltraps
801065f7:	e9 ce f6 ff ff       	jmp    80105cca <alltraps>

801065fc <vector125>:
.globl vector125
vector125:
  pushl $0
801065fc:	6a 00                	push   $0x0
  pushl $125
801065fe:	6a 7d                	push   $0x7d
  jmp alltraps
80106600:	e9 c5 f6 ff ff       	jmp    80105cca <alltraps>

80106605 <vector126>:
.globl vector126
vector126:
  pushl $0
80106605:	6a 00                	push   $0x0
  pushl $126
80106607:	6a 7e                	push   $0x7e
  jmp alltraps
80106609:	e9 bc f6 ff ff       	jmp    80105cca <alltraps>

8010660e <vector127>:
.globl vector127
vector127:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $127
80106610:	6a 7f                	push   $0x7f
  jmp alltraps
80106612:	e9 b3 f6 ff ff       	jmp    80105cca <alltraps>

80106617 <vector128>:
.globl vector128
vector128:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $128
80106619:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010661e:	e9 a7 f6 ff ff       	jmp    80105cca <alltraps>

80106623 <vector129>:
.globl vector129
vector129:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $129
80106625:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010662a:	e9 9b f6 ff ff       	jmp    80105cca <alltraps>

8010662f <vector130>:
.globl vector130
vector130:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $130
80106631:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106636:	e9 8f f6 ff ff       	jmp    80105cca <alltraps>

8010663b <vector131>:
.globl vector131
vector131:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $131
8010663d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106642:	e9 83 f6 ff ff       	jmp    80105cca <alltraps>

80106647 <vector132>:
.globl vector132
vector132:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $132
80106649:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010664e:	e9 77 f6 ff ff       	jmp    80105cca <alltraps>

80106653 <vector133>:
.globl vector133
vector133:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $133
80106655:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010665a:	e9 6b f6 ff ff       	jmp    80105cca <alltraps>

8010665f <vector134>:
.globl vector134
vector134:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $134
80106661:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106666:	e9 5f f6 ff ff       	jmp    80105cca <alltraps>

8010666b <vector135>:
.globl vector135
vector135:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $135
8010666d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106672:	e9 53 f6 ff ff       	jmp    80105cca <alltraps>

80106677 <vector136>:
.globl vector136
vector136:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $136
80106679:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010667e:	e9 47 f6 ff ff       	jmp    80105cca <alltraps>

80106683 <vector137>:
.globl vector137
vector137:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $137
80106685:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010668a:	e9 3b f6 ff ff       	jmp    80105cca <alltraps>

8010668f <vector138>:
.globl vector138
vector138:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $138
80106691:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106696:	e9 2f f6 ff ff       	jmp    80105cca <alltraps>

8010669b <vector139>:
.globl vector139
vector139:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $139
8010669d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801066a2:	e9 23 f6 ff ff       	jmp    80105cca <alltraps>

801066a7 <vector140>:
.globl vector140
vector140:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $140
801066a9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801066ae:	e9 17 f6 ff ff       	jmp    80105cca <alltraps>

801066b3 <vector141>:
.globl vector141
vector141:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $141
801066b5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801066ba:	e9 0b f6 ff ff       	jmp    80105cca <alltraps>

801066bf <vector142>:
.globl vector142
vector142:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $142
801066c1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801066c6:	e9 ff f5 ff ff       	jmp    80105cca <alltraps>

801066cb <vector143>:
.globl vector143
vector143:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $143
801066cd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801066d2:	e9 f3 f5 ff ff       	jmp    80105cca <alltraps>

801066d7 <vector144>:
.globl vector144
vector144:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $144
801066d9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801066de:	e9 e7 f5 ff ff       	jmp    80105cca <alltraps>

801066e3 <vector145>:
.globl vector145
vector145:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $145
801066e5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801066ea:	e9 db f5 ff ff       	jmp    80105cca <alltraps>

801066ef <vector146>:
.globl vector146
vector146:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $146
801066f1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801066f6:	e9 cf f5 ff ff       	jmp    80105cca <alltraps>

801066fb <vector147>:
.globl vector147
vector147:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $147
801066fd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106702:	e9 c3 f5 ff ff       	jmp    80105cca <alltraps>

80106707 <vector148>:
.globl vector148
vector148:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $148
80106709:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010670e:	e9 b7 f5 ff ff       	jmp    80105cca <alltraps>

80106713 <vector149>:
.globl vector149
vector149:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $149
80106715:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010671a:	e9 ab f5 ff ff       	jmp    80105cca <alltraps>

8010671f <vector150>:
.globl vector150
vector150:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $150
80106721:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106726:	e9 9f f5 ff ff       	jmp    80105cca <alltraps>

8010672b <vector151>:
.globl vector151
vector151:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $151
8010672d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106732:	e9 93 f5 ff ff       	jmp    80105cca <alltraps>

80106737 <vector152>:
.globl vector152
vector152:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $152
80106739:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010673e:	e9 87 f5 ff ff       	jmp    80105cca <alltraps>

80106743 <vector153>:
.globl vector153
vector153:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $153
80106745:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010674a:	e9 7b f5 ff ff       	jmp    80105cca <alltraps>

8010674f <vector154>:
.globl vector154
vector154:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $154
80106751:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106756:	e9 6f f5 ff ff       	jmp    80105cca <alltraps>

8010675b <vector155>:
.globl vector155
vector155:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $155
8010675d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106762:	e9 63 f5 ff ff       	jmp    80105cca <alltraps>

80106767 <vector156>:
.globl vector156
vector156:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $156
80106769:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010676e:	e9 57 f5 ff ff       	jmp    80105cca <alltraps>

80106773 <vector157>:
.globl vector157
vector157:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $157
80106775:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010677a:	e9 4b f5 ff ff       	jmp    80105cca <alltraps>

8010677f <vector158>:
.globl vector158
vector158:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $158
80106781:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106786:	e9 3f f5 ff ff       	jmp    80105cca <alltraps>

8010678b <vector159>:
.globl vector159
vector159:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $159
8010678d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106792:	e9 33 f5 ff ff       	jmp    80105cca <alltraps>

80106797 <vector160>:
.globl vector160
vector160:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $160
80106799:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010679e:	e9 27 f5 ff ff       	jmp    80105cca <alltraps>

801067a3 <vector161>:
.globl vector161
vector161:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $161
801067a5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801067aa:	e9 1b f5 ff ff       	jmp    80105cca <alltraps>

801067af <vector162>:
.globl vector162
vector162:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $162
801067b1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801067b6:	e9 0f f5 ff ff       	jmp    80105cca <alltraps>

801067bb <vector163>:
.globl vector163
vector163:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $163
801067bd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801067c2:	e9 03 f5 ff ff       	jmp    80105cca <alltraps>

801067c7 <vector164>:
.globl vector164
vector164:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $164
801067c9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801067ce:	e9 f7 f4 ff ff       	jmp    80105cca <alltraps>

801067d3 <vector165>:
.globl vector165
vector165:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $165
801067d5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801067da:	e9 eb f4 ff ff       	jmp    80105cca <alltraps>

801067df <vector166>:
.globl vector166
vector166:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $166
801067e1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801067e6:	e9 df f4 ff ff       	jmp    80105cca <alltraps>

801067eb <vector167>:
.globl vector167
vector167:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $167
801067ed:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801067f2:	e9 d3 f4 ff ff       	jmp    80105cca <alltraps>

801067f7 <vector168>:
.globl vector168
vector168:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $168
801067f9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801067fe:	e9 c7 f4 ff ff       	jmp    80105cca <alltraps>

80106803 <vector169>:
.globl vector169
vector169:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $169
80106805:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010680a:	e9 bb f4 ff ff       	jmp    80105cca <alltraps>

8010680f <vector170>:
.globl vector170
vector170:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $170
80106811:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106816:	e9 af f4 ff ff       	jmp    80105cca <alltraps>

8010681b <vector171>:
.globl vector171
vector171:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $171
8010681d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106822:	e9 a3 f4 ff ff       	jmp    80105cca <alltraps>

80106827 <vector172>:
.globl vector172
vector172:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $172
80106829:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010682e:	e9 97 f4 ff ff       	jmp    80105cca <alltraps>

80106833 <vector173>:
.globl vector173
vector173:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $173
80106835:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010683a:	e9 8b f4 ff ff       	jmp    80105cca <alltraps>

8010683f <vector174>:
.globl vector174
vector174:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $174
80106841:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106846:	e9 7f f4 ff ff       	jmp    80105cca <alltraps>

8010684b <vector175>:
.globl vector175
vector175:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $175
8010684d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106852:	e9 73 f4 ff ff       	jmp    80105cca <alltraps>

80106857 <vector176>:
.globl vector176
vector176:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $176
80106859:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010685e:	e9 67 f4 ff ff       	jmp    80105cca <alltraps>

80106863 <vector177>:
.globl vector177
vector177:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $177
80106865:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010686a:	e9 5b f4 ff ff       	jmp    80105cca <alltraps>

8010686f <vector178>:
.globl vector178
vector178:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $178
80106871:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106876:	e9 4f f4 ff ff       	jmp    80105cca <alltraps>

8010687b <vector179>:
.globl vector179
vector179:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $179
8010687d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106882:	e9 43 f4 ff ff       	jmp    80105cca <alltraps>

80106887 <vector180>:
.globl vector180
vector180:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $180
80106889:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010688e:	e9 37 f4 ff ff       	jmp    80105cca <alltraps>

80106893 <vector181>:
.globl vector181
vector181:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $181
80106895:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010689a:	e9 2b f4 ff ff       	jmp    80105cca <alltraps>

8010689f <vector182>:
.globl vector182
vector182:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $182
801068a1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801068a6:	e9 1f f4 ff ff       	jmp    80105cca <alltraps>

801068ab <vector183>:
.globl vector183
vector183:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $183
801068ad:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801068b2:	e9 13 f4 ff ff       	jmp    80105cca <alltraps>

801068b7 <vector184>:
.globl vector184
vector184:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $184
801068b9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801068be:	e9 07 f4 ff ff       	jmp    80105cca <alltraps>

801068c3 <vector185>:
.globl vector185
vector185:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $185
801068c5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801068ca:	e9 fb f3 ff ff       	jmp    80105cca <alltraps>

801068cf <vector186>:
.globl vector186
vector186:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $186
801068d1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801068d6:	e9 ef f3 ff ff       	jmp    80105cca <alltraps>

801068db <vector187>:
.globl vector187
vector187:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $187
801068dd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801068e2:	e9 e3 f3 ff ff       	jmp    80105cca <alltraps>

801068e7 <vector188>:
.globl vector188
vector188:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $188
801068e9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801068ee:	e9 d7 f3 ff ff       	jmp    80105cca <alltraps>

801068f3 <vector189>:
.globl vector189
vector189:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $189
801068f5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801068fa:	e9 cb f3 ff ff       	jmp    80105cca <alltraps>

801068ff <vector190>:
.globl vector190
vector190:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $190
80106901:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106906:	e9 bf f3 ff ff       	jmp    80105cca <alltraps>

8010690b <vector191>:
.globl vector191
vector191:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $191
8010690d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106912:	e9 b3 f3 ff ff       	jmp    80105cca <alltraps>

80106917 <vector192>:
.globl vector192
vector192:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $192
80106919:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010691e:	e9 a7 f3 ff ff       	jmp    80105cca <alltraps>

80106923 <vector193>:
.globl vector193
vector193:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $193
80106925:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010692a:	e9 9b f3 ff ff       	jmp    80105cca <alltraps>

8010692f <vector194>:
.globl vector194
vector194:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $194
80106931:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106936:	e9 8f f3 ff ff       	jmp    80105cca <alltraps>

8010693b <vector195>:
.globl vector195
vector195:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $195
8010693d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106942:	e9 83 f3 ff ff       	jmp    80105cca <alltraps>

80106947 <vector196>:
.globl vector196
vector196:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $196
80106949:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010694e:	e9 77 f3 ff ff       	jmp    80105cca <alltraps>

80106953 <vector197>:
.globl vector197
vector197:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $197
80106955:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010695a:	e9 6b f3 ff ff       	jmp    80105cca <alltraps>

8010695f <vector198>:
.globl vector198
vector198:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $198
80106961:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106966:	e9 5f f3 ff ff       	jmp    80105cca <alltraps>

8010696b <vector199>:
.globl vector199
vector199:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $199
8010696d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106972:	e9 53 f3 ff ff       	jmp    80105cca <alltraps>

80106977 <vector200>:
.globl vector200
vector200:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $200
80106979:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010697e:	e9 47 f3 ff ff       	jmp    80105cca <alltraps>

80106983 <vector201>:
.globl vector201
vector201:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $201
80106985:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010698a:	e9 3b f3 ff ff       	jmp    80105cca <alltraps>

8010698f <vector202>:
.globl vector202
vector202:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $202
80106991:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106996:	e9 2f f3 ff ff       	jmp    80105cca <alltraps>

8010699b <vector203>:
.globl vector203
vector203:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $203
8010699d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801069a2:	e9 23 f3 ff ff       	jmp    80105cca <alltraps>

801069a7 <vector204>:
.globl vector204
vector204:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $204
801069a9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801069ae:	e9 17 f3 ff ff       	jmp    80105cca <alltraps>

801069b3 <vector205>:
.globl vector205
vector205:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $205
801069b5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801069ba:	e9 0b f3 ff ff       	jmp    80105cca <alltraps>

801069bf <vector206>:
.globl vector206
vector206:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $206
801069c1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801069c6:	e9 ff f2 ff ff       	jmp    80105cca <alltraps>

801069cb <vector207>:
.globl vector207
vector207:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $207
801069cd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801069d2:	e9 f3 f2 ff ff       	jmp    80105cca <alltraps>

801069d7 <vector208>:
.globl vector208
vector208:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $208
801069d9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801069de:	e9 e7 f2 ff ff       	jmp    80105cca <alltraps>

801069e3 <vector209>:
.globl vector209
vector209:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $209
801069e5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801069ea:	e9 db f2 ff ff       	jmp    80105cca <alltraps>

801069ef <vector210>:
.globl vector210
vector210:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $210
801069f1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801069f6:	e9 cf f2 ff ff       	jmp    80105cca <alltraps>

801069fb <vector211>:
.globl vector211
vector211:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $211
801069fd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106a02:	e9 c3 f2 ff ff       	jmp    80105cca <alltraps>

80106a07 <vector212>:
.globl vector212
vector212:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $212
80106a09:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106a0e:	e9 b7 f2 ff ff       	jmp    80105cca <alltraps>

80106a13 <vector213>:
.globl vector213
vector213:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $213
80106a15:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106a1a:	e9 ab f2 ff ff       	jmp    80105cca <alltraps>

80106a1f <vector214>:
.globl vector214
vector214:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $214
80106a21:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106a26:	e9 9f f2 ff ff       	jmp    80105cca <alltraps>

80106a2b <vector215>:
.globl vector215
vector215:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $215
80106a2d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106a32:	e9 93 f2 ff ff       	jmp    80105cca <alltraps>

80106a37 <vector216>:
.globl vector216
vector216:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $216
80106a39:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106a3e:	e9 87 f2 ff ff       	jmp    80105cca <alltraps>

80106a43 <vector217>:
.globl vector217
vector217:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $217
80106a45:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106a4a:	e9 7b f2 ff ff       	jmp    80105cca <alltraps>

80106a4f <vector218>:
.globl vector218
vector218:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $218
80106a51:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106a56:	e9 6f f2 ff ff       	jmp    80105cca <alltraps>

80106a5b <vector219>:
.globl vector219
vector219:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $219
80106a5d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106a62:	e9 63 f2 ff ff       	jmp    80105cca <alltraps>

80106a67 <vector220>:
.globl vector220
vector220:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $220
80106a69:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106a6e:	e9 57 f2 ff ff       	jmp    80105cca <alltraps>

80106a73 <vector221>:
.globl vector221
vector221:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $221
80106a75:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106a7a:	e9 4b f2 ff ff       	jmp    80105cca <alltraps>

80106a7f <vector222>:
.globl vector222
vector222:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $222
80106a81:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106a86:	e9 3f f2 ff ff       	jmp    80105cca <alltraps>

80106a8b <vector223>:
.globl vector223
vector223:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $223
80106a8d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106a92:	e9 33 f2 ff ff       	jmp    80105cca <alltraps>

80106a97 <vector224>:
.globl vector224
vector224:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $224
80106a99:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106a9e:	e9 27 f2 ff ff       	jmp    80105cca <alltraps>

80106aa3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $225
80106aa5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106aaa:	e9 1b f2 ff ff       	jmp    80105cca <alltraps>

80106aaf <vector226>:
.globl vector226
vector226:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $226
80106ab1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ab6:	e9 0f f2 ff ff       	jmp    80105cca <alltraps>

80106abb <vector227>:
.globl vector227
vector227:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $227
80106abd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106ac2:	e9 03 f2 ff ff       	jmp    80105cca <alltraps>

80106ac7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $228
80106ac9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106ace:	e9 f7 f1 ff ff       	jmp    80105cca <alltraps>

80106ad3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $229
80106ad5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106ada:	e9 eb f1 ff ff       	jmp    80105cca <alltraps>

80106adf <vector230>:
.globl vector230
vector230:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $230
80106ae1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106ae6:	e9 df f1 ff ff       	jmp    80105cca <alltraps>

80106aeb <vector231>:
.globl vector231
vector231:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $231
80106aed:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106af2:	e9 d3 f1 ff ff       	jmp    80105cca <alltraps>

80106af7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $232
80106af9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106afe:	e9 c7 f1 ff ff       	jmp    80105cca <alltraps>

80106b03 <vector233>:
.globl vector233
vector233:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $233
80106b05:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106b0a:	e9 bb f1 ff ff       	jmp    80105cca <alltraps>

80106b0f <vector234>:
.globl vector234
vector234:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $234
80106b11:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106b16:	e9 af f1 ff ff       	jmp    80105cca <alltraps>

80106b1b <vector235>:
.globl vector235
vector235:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $235
80106b1d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106b22:	e9 a3 f1 ff ff       	jmp    80105cca <alltraps>

80106b27 <vector236>:
.globl vector236
vector236:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $236
80106b29:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106b2e:	e9 97 f1 ff ff       	jmp    80105cca <alltraps>

80106b33 <vector237>:
.globl vector237
vector237:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $237
80106b35:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106b3a:	e9 8b f1 ff ff       	jmp    80105cca <alltraps>

80106b3f <vector238>:
.globl vector238
vector238:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $238
80106b41:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106b46:	e9 7f f1 ff ff       	jmp    80105cca <alltraps>

80106b4b <vector239>:
.globl vector239
vector239:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $239
80106b4d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106b52:	e9 73 f1 ff ff       	jmp    80105cca <alltraps>

80106b57 <vector240>:
.globl vector240
vector240:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $240
80106b59:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106b5e:	e9 67 f1 ff ff       	jmp    80105cca <alltraps>

80106b63 <vector241>:
.globl vector241
vector241:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $241
80106b65:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106b6a:	e9 5b f1 ff ff       	jmp    80105cca <alltraps>

80106b6f <vector242>:
.globl vector242
vector242:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $242
80106b71:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106b76:	e9 4f f1 ff ff       	jmp    80105cca <alltraps>

80106b7b <vector243>:
.globl vector243
vector243:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $243
80106b7d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106b82:	e9 43 f1 ff ff       	jmp    80105cca <alltraps>

80106b87 <vector244>:
.globl vector244
vector244:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $244
80106b89:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106b8e:	e9 37 f1 ff ff       	jmp    80105cca <alltraps>

80106b93 <vector245>:
.globl vector245
vector245:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $245
80106b95:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106b9a:	e9 2b f1 ff ff       	jmp    80105cca <alltraps>

80106b9f <vector246>:
.globl vector246
vector246:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $246
80106ba1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106ba6:	e9 1f f1 ff ff       	jmp    80105cca <alltraps>

80106bab <vector247>:
.globl vector247
vector247:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $247
80106bad:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106bb2:	e9 13 f1 ff ff       	jmp    80105cca <alltraps>

80106bb7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $248
80106bb9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106bbe:	e9 07 f1 ff ff       	jmp    80105cca <alltraps>

80106bc3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $249
80106bc5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106bca:	e9 fb f0 ff ff       	jmp    80105cca <alltraps>

80106bcf <vector250>:
.globl vector250
vector250:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $250
80106bd1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106bd6:	e9 ef f0 ff ff       	jmp    80105cca <alltraps>

80106bdb <vector251>:
.globl vector251
vector251:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $251
80106bdd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106be2:	e9 e3 f0 ff ff       	jmp    80105cca <alltraps>

80106be7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $252
80106be9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106bee:	e9 d7 f0 ff ff       	jmp    80105cca <alltraps>

80106bf3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $253
80106bf5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106bfa:	e9 cb f0 ff ff       	jmp    80105cca <alltraps>

80106bff <vector254>:
.globl vector254
vector254:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $254
80106c01:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106c06:	e9 bf f0 ff ff       	jmp    80105cca <alltraps>

80106c0b <vector255>:
.globl vector255
vector255:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $255
80106c0d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106c12:	e9 b3 f0 ff ff       	jmp    80105cca <alltraps>
80106c17:	66 90                	xchg   %ax,%ax
80106c19:	66 90                	xchg   %ax,%ax
80106c1b:	66 90                	xchg   %ax,%ax
80106c1d:	66 90                	xchg   %ax,%ax
80106c1f:	90                   	nop

80106c20 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	57                   	push   %edi
80106c24:	56                   	push   %esi
80106c25:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106c26:	89 d3                	mov    %edx,%ebx
{
80106c28:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106c2a:	c1 eb 16             	shr    $0x16,%ebx
80106c2d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106c30:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106c33:	8b 06                	mov    (%esi),%eax
80106c35:	a8 01                	test   $0x1,%al
80106c37:	74 27                	je     80106c60 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106c39:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c3e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106c44:	c1 ef 0a             	shr    $0xa,%edi
}
80106c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106c4a:	89 fa                	mov    %edi,%edx
80106c4c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106c52:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106c55:	5b                   	pop    %ebx
80106c56:	5e                   	pop    %esi
80106c57:	5f                   	pop    %edi
80106c58:	5d                   	pop    %ebp
80106c59:	c3                   	ret    
80106c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106c60:	85 c9                	test   %ecx,%ecx
80106c62:	74 2c                	je     80106c90 <walkpgdir+0x70>
80106c64:	e8 37 bc ff ff       	call   801028a0 <kalloc>
80106c69:	85 c0                	test   %eax,%eax
80106c6b:	89 c3                	mov    %eax,%ebx
80106c6d:	74 21                	je     80106c90 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106c6f:	83 ec 04             	sub    $0x4,%esp
80106c72:	68 00 10 00 00       	push   $0x1000
80106c77:	6a 00                	push   $0x0
80106c79:	50                   	push   %eax
80106c7a:	e8 31 de ff ff       	call   80104ab0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c7f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c85:	83 c4 10             	add    $0x10,%esp
80106c88:	83 c8 07             	or     $0x7,%eax
80106c8b:	89 06                	mov    %eax,(%esi)
80106c8d:	eb b5                	jmp    80106c44 <walkpgdir+0x24>
80106c8f:	90                   	nop
}
80106c90:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106c93:	31 c0                	xor    %eax,%eax
}
80106c95:	5b                   	pop    %ebx
80106c96:	5e                   	pop    %esi
80106c97:	5f                   	pop    %edi
80106c98:	5d                   	pop    %ebp
80106c99:	c3                   	ret    
80106c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ca0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	57                   	push   %edi
80106ca4:	56                   	push   %esi
80106ca5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106ca6:	89 d3                	mov    %edx,%ebx
80106ca8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106cae:	83 ec 1c             	sub    $0x1c,%esp
80106cb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106cb4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106cb8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106cbb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106cc3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106cc6:	29 df                	sub    %ebx,%edi
80106cc8:	83 c8 01             	or     $0x1,%eax
80106ccb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106cce:	eb 15                	jmp    80106ce5 <mappages+0x45>
    if(*pte & PTE_P)
80106cd0:	f6 00 01             	testb  $0x1,(%eax)
80106cd3:	75 45                	jne    80106d1a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106cd5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106cd8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106cdb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106cdd:	74 31                	je     80106d10 <mappages+0x70>
      break;
    a += PGSIZE;
80106cdf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106ce5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ce8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106ced:	89 da                	mov    %ebx,%edx
80106cef:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106cf2:	e8 29 ff ff ff       	call   80106c20 <walkpgdir>
80106cf7:	85 c0                	test   %eax,%eax
80106cf9:	75 d5                	jne    80106cd0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106cfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106cfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d03:	5b                   	pop    %ebx
80106d04:	5e                   	pop    %esi
80106d05:	5f                   	pop    %edi
80106d06:	5d                   	pop    %ebp
80106d07:	c3                   	ret    
80106d08:	90                   	nop
80106d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106d13:	31 c0                	xor    %eax,%eax
}
80106d15:	5b                   	pop    %ebx
80106d16:	5e                   	pop    %esi
80106d17:	5f                   	pop    %edi
80106d18:	5d                   	pop    %ebp
80106d19:	c3                   	ret    
      panic("remap");
80106d1a:	83 ec 0c             	sub    $0xc,%esp
80106d1d:	68 8c 86 10 80       	push   $0x8010868c
80106d22:	e8 69 96 ff ff       	call   80100390 <panic>
80106d27:	89 f6                	mov    %esi,%esi
80106d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106d36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106d3c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d42:	83 ec 1c             	sub    $0x1c,%esp
80106d45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106d48:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d4a:	89 55 e0             	mov    %edx,-0x20(%ebp)
80106d4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106d50:	72 3e                	jb     80106d90 <deallocuvm.part.0+0x60>
80106d52:	eb 65                	jmp    80106db9 <deallocuvm.part.0+0x89>
80106d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106d58:	8b 00                	mov    (%eax),%eax
80106d5a:	a8 01                	test   $0x1,%al
80106d5c:	74 27                	je     80106d85 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106d5e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d63:	0f 84 da 00 00 00    	je     80106e43 <deallocuvm.part.0+0x113>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106d69:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106d6c:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106d71:	50                   	push   %eax
80106d72:	e8 79 b9 ff ff       	call   801026f0 <kfree>
      if(myproc()->pid>2){
80106d77:	e8 c4 ce ff ff       	call   80103c40 <myproc>
80106d7c:	83 c4 10             	add    $0x10,%esp
80106d7f:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
80106d83:	7f 43                	jg     80106dc8 <deallocuvm.part.0+0x98>
  for(; a  < oldsz; a += PGSIZE){
80106d85:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d8b:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80106d8e:	73 29                	jae    80106db9 <deallocuvm.part.0+0x89>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106d90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d93:	31 c9                	xor    %ecx,%ecx
80106d95:	89 da                	mov    %ebx,%edx
80106d97:	e8 84 fe ff ff       	call   80106c20 <walkpgdir>
    if(!pte)
80106d9c:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
80106d9e:	89 c7                	mov    %eax,%edi
    if(!pte)
80106da0:	75 b6                	jne    80106d58 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106da2:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106da8:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106dae:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106db4:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80106db7:	72 d7                	jb     80106d90 <deallocuvm.part.0+0x60>
        *pte = 0;
      }
    }
  }
  return newsz;
}
80106db9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80106dbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dbf:	5b                   	pop    %ebx
80106dc0:	5e                   	pop    %esi
80106dc1:	5f                   	pop    %edi
80106dc2:	5d                   	pop    %ebp
80106dc3:	c3                   	ret    
80106dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        int i =0;
80106dc8:	31 d2                	xor    %edx,%edx
80106dca:	89 7d dc             	mov    %edi,-0x24(%ebp)
80106dcd:	89 d7                	mov    %edx,%edi
80106dcf:	eb 0f                	jmp    80106de0 <deallocuvm.part.0+0xb0>
80106dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        while(((uint)myproc()->main_mem_pages[i].v_addr != a) && i<16){
80106dd8:	83 ff 10             	cmp    $0x10,%edi
80106ddb:	74 3b                	je     80106e18 <deallocuvm.part.0+0xe8>
          i++;
80106ddd:	83 c7 01             	add    $0x1,%edi
        while(((uint)myproc()->main_mem_pages[i].v_addr != a) && i<16){
80106de0:	8d 77 08             	lea    0x8(%edi),%esi
80106de3:	e8 58 ce ff ff       	call   80103c40 <myproc>
80106de8:	c1 e6 04             	shl    $0x4,%esi
80106deb:	39 5c 30 04          	cmp    %ebx,0x4(%eax,%esi,1)
80106def:	75 e7                	jne    80106dd8 <deallocuvm.part.0+0xa8>
80106df1:	89 fa                	mov    %edi,%edx
80106df3:	8b 7d dc             	mov    -0x24(%ebp),%edi
        if(i<16 && myproc()->main_mem_pages[i].page_dir == pgdir){
80106df6:	83 fa 10             	cmp    $0x10,%edx
80106df9:	74 0e                	je     80106e09 <deallocuvm.part.0+0xd9>
80106dfb:	e8 40 ce ff ff       	call   80103c40 <myproc>
80106e00:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106e03:	3b 4c 30 08          	cmp    0x8(%eax,%esi,1),%ecx
80106e07:	74 1d                	je     80106e26 <deallocuvm.part.0+0xf6>
        *pte = 0;
80106e09:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80106e0f:	e9 71 ff ff ff       	jmp    80106d85 <deallocuvm.part.0+0x55>
80106e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e18:	8b 7d dc             	mov    -0x24(%ebp),%edi
80106e1b:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80106e21:	e9 5f ff ff ff       	jmp    80106d85 <deallocuvm.part.0+0x55>
          myproc()->main_mem_pages[i].state_used = 0;
80106e26:	e8 15 ce ff ff       	call   80103c40 <myproc>
80106e2b:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
          myproc()->main_mem_pages[i].page_dir = 0;
80106e2f:	e8 0c ce ff ff       	call   80103c40 <myproc>
80106e34:	c7 44 30 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,1)
80106e3b:	00 
          ResetPageCounter(myproc(), i);
80106e3c:	e8 ff cd ff ff       	call   80103c40 <myproc>
80106e41:	eb c6                	jmp    80106e09 <deallocuvm.part.0+0xd9>
        panic("kfree");
80106e43:	83 ec 0c             	sub    $0xc,%esp
80106e46:	68 aa 7f 10 80       	push   $0x80107faa
80106e4b:	e8 40 95 ff ff       	call   80100390 <panic>

80106e50 <seginit>:
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106e56:	e8 c5 cd ff ff       	call   80103c20 <cpuid>
80106e5b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106e61:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106e66:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e6a:	c7 80 38 58 11 80 ff 	movl   $0xffff,-0x7feea7c8(%eax)
80106e71:	ff 00 00 
80106e74:	c7 80 3c 58 11 80 00 	movl   $0xcf9a00,-0x7feea7c4(%eax)
80106e7b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e7e:	c7 80 40 58 11 80 ff 	movl   $0xffff,-0x7feea7c0(%eax)
80106e85:	ff 00 00 
80106e88:	c7 80 44 58 11 80 00 	movl   $0xcf9200,-0x7feea7bc(%eax)
80106e8f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e92:	c7 80 48 58 11 80 ff 	movl   $0xffff,-0x7feea7b8(%eax)
80106e99:	ff 00 00 
80106e9c:	c7 80 4c 58 11 80 00 	movl   $0xcffa00,-0x7feea7b4(%eax)
80106ea3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ea6:	c7 80 50 58 11 80 ff 	movl   $0xffff,-0x7feea7b0(%eax)
80106ead:	ff 00 00 
80106eb0:	c7 80 54 58 11 80 00 	movl   $0xcff200,-0x7feea7ac(%eax)
80106eb7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106eba:	05 30 58 11 80       	add    $0x80115830,%eax
  pd[1] = (uint)p;
80106ebf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ec3:	c1 e8 10             	shr    $0x10,%eax
80106ec6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106eca:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ecd:	0f 01 10             	lgdtl  (%eax)
}
80106ed0:	c9                   	leave  
80106ed1:	c3                   	ret    
80106ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ee0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ee0:	a1 e4 07 12 80       	mov    0x801207e4,%eax
{
80106ee5:	55                   	push   %ebp
80106ee6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ee8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106eed:	0f 22 d8             	mov    %eax,%cr3
}
80106ef0:	5d                   	pop    %ebp
80106ef1:	c3                   	ret    
80106ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f00 <switchuvm>:
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	57                   	push   %edi
80106f04:	56                   	push   %esi
80106f05:	53                   	push   %ebx
80106f06:	83 ec 1c             	sub    $0x1c,%esp
80106f09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106f0c:	85 db                	test   %ebx,%ebx
80106f0e:	0f 84 cb 00 00 00    	je     80106fdf <switchuvm+0xdf>
  if(p->kstack == 0)
80106f14:	8b 43 08             	mov    0x8(%ebx),%eax
80106f17:	85 c0                	test   %eax,%eax
80106f19:	0f 84 da 00 00 00    	je     80106ff9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106f1f:	8b 43 04             	mov    0x4(%ebx),%eax
80106f22:	85 c0                	test   %eax,%eax
80106f24:	0f 84 c2 00 00 00    	je     80106fec <switchuvm+0xec>
  pushcli();
80106f2a:	e8 a1 d9 ff ff       	call   801048d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f2f:	e8 6c cc ff ff       	call   80103ba0 <mycpu>
80106f34:	89 c6                	mov    %eax,%esi
80106f36:	e8 65 cc ff ff       	call   80103ba0 <mycpu>
80106f3b:	89 c7                	mov    %eax,%edi
80106f3d:	e8 5e cc ff ff       	call   80103ba0 <mycpu>
80106f42:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f45:	83 c7 08             	add    $0x8,%edi
80106f48:	e8 53 cc ff ff       	call   80103ba0 <mycpu>
80106f4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f50:	83 c0 08             	add    $0x8,%eax
80106f53:	ba 67 00 00 00       	mov    $0x67,%edx
80106f58:	c1 e8 18             	shr    $0x18,%eax
80106f5b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106f62:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106f69:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106f6f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f74:	83 c1 08             	add    $0x8,%ecx
80106f77:	c1 e9 10             	shr    $0x10,%ecx
80106f7a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106f80:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106f85:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106f8c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106f91:	e8 0a cc ff ff       	call   80103ba0 <mycpu>
80106f96:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106f9d:	e8 fe cb ff ff       	call   80103ba0 <mycpu>
80106fa2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106fa6:	8b 73 08             	mov    0x8(%ebx),%esi
80106fa9:	e8 f2 cb ff ff       	call   80103ba0 <mycpu>
80106fae:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fb4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106fb7:	e8 e4 cb ff ff       	call   80103ba0 <mycpu>
80106fbc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106fc0:	b8 28 00 00 00       	mov    $0x28,%eax
80106fc5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106fc8:	8b 43 04             	mov    0x4(%ebx),%eax
80106fcb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fd0:	0f 22 d8             	mov    %eax,%cr3
}
80106fd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fd6:	5b                   	pop    %ebx
80106fd7:	5e                   	pop    %esi
80106fd8:	5f                   	pop    %edi
80106fd9:	5d                   	pop    %ebp
  popcli();
80106fda:	e9 31 d9 ff ff       	jmp    80104910 <popcli>
    panic("switchuvm: no process");
80106fdf:	83 ec 0c             	sub    $0xc,%esp
80106fe2:	68 92 86 10 80       	push   $0x80108692
80106fe7:	e8 a4 93 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106fec:	83 ec 0c             	sub    $0xc,%esp
80106fef:	68 bd 86 10 80       	push   $0x801086bd
80106ff4:	e8 97 93 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106ff9:	83 ec 0c             	sub    $0xc,%esp
80106ffc:	68 a8 86 10 80       	push   $0x801086a8
80107001:	e8 8a 93 ff ff       	call   80100390 <panic>
80107006:	8d 76 00             	lea    0x0(%esi),%esi
80107009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107010 <inituvm>:
{
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
80107016:	83 ec 1c             	sub    $0x1c,%esp
80107019:	8b 75 10             	mov    0x10(%ebp),%esi
8010701c:	8b 45 08             	mov    0x8(%ebp),%eax
8010701f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107022:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107028:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010702b:	77 49                	ja     80107076 <inituvm+0x66>
  mem = kalloc();
8010702d:	e8 6e b8 ff ff       	call   801028a0 <kalloc>
  memset(mem, 0, PGSIZE);
80107032:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107035:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107037:	68 00 10 00 00       	push   $0x1000
8010703c:	6a 00                	push   $0x0
8010703e:	50                   	push   %eax
8010703f:	e8 6c da ff ff       	call   80104ab0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107044:	58                   	pop    %eax
80107045:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010704b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107050:	5a                   	pop    %edx
80107051:	6a 06                	push   $0x6
80107053:	50                   	push   %eax
80107054:	31 d2                	xor    %edx,%edx
80107056:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107059:	e8 42 fc ff ff       	call   80106ca0 <mappages>
  memmove(mem, init, sz);
8010705e:	89 75 10             	mov    %esi,0x10(%ebp)
80107061:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107064:	83 c4 10             	add    $0x10,%esp
80107067:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010706a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010706d:	5b                   	pop    %ebx
8010706e:	5e                   	pop    %esi
8010706f:	5f                   	pop    %edi
80107070:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107071:	e9 ea da ff ff       	jmp    80104b60 <memmove>
    panic("inituvm: more than a page");
80107076:	83 ec 0c             	sub    $0xc,%esp
80107079:	68 d1 86 10 80       	push   $0x801086d1
8010707e:	e8 0d 93 ff ff       	call   80100390 <panic>
80107083:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107090 <loaduvm>:
{
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	57                   	push   %edi
80107094:	56                   	push   %esi
80107095:	53                   	push   %ebx
80107096:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107099:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801070a0:	0f 85 91 00 00 00    	jne    80107137 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
801070a6:	8b 75 18             	mov    0x18(%ebp),%esi
801070a9:	31 db                	xor    %ebx,%ebx
801070ab:	85 f6                	test   %esi,%esi
801070ad:	75 1a                	jne    801070c9 <loaduvm+0x39>
801070af:	eb 6f                	jmp    80107120 <loaduvm+0x90>
801070b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070b8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070be:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801070c4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801070c7:	76 57                	jbe    80107120 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801070c9:	8b 55 0c             	mov    0xc(%ebp),%edx
801070cc:	8b 45 08             	mov    0x8(%ebp),%eax
801070cf:	31 c9                	xor    %ecx,%ecx
801070d1:	01 da                	add    %ebx,%edx
801070d3:	e8 48 fb ff ff       	call   80106c20 <walkpgdir>
801070d8:	85 c0                	test   %eax,%eax
801070da:	74 4e                	je     8010712a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
801070dc:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070de:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801070e1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801070e6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801070eb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801070f1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070f4:	01 d9                	add    %ebx,%ecx
801070f6:	05 00 00 00 80       	add    $0x80000000,%eax
801070fb:	57                   	push   %edi
801070fc:	51                   	push   %ecx
801070fd:	50                   	push   %eax
801070fe:	ff 75 10             	pushl  0x10(%ebp)
80107101:	e8 9a a8 ff ff       	call   801019a0 <readi>
80107106:	83 c4 10             	add    $0x10,%esp
80107109:	39 f8                	cmp    %edi,%eax
8010710b:	74 ab                	je     801070b8 <loaduvm+0x28>
}
8010710d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107115:	5b                   	pop    %ebx
80107116:	5e                   	pop    %esi
80107117:	5f                   	pop    %edi
80107118:	5d                   	pop    %ebp
80107119:	c3                   	ret    
8010711a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107120:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107123:	31 c0                	xor    %eax,%eax
}
80107125:	5b                   	pop    %ebx
80107126:	5e                   	pop    %esi
80107127:	5f                   	pop    %edi
80107128:	5d                   	pop    %ebp
80107129:	c3                   	ret    
      panic("loaduvm: address should exist");
8010712a:	83 ec 0c             	sub    $0xc,%esp
8010712d:	68 eb 86 10 80       	push   $0x801086eb
80107132:	e8 59 92 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107137:	83 ec 0c             	sub    $0xc,%esp
8010713a:	68 00 88 10 80       	push   $0x80108800
8010713f:	e8 4c 92 ff ff       	call   80100390 <panic>
80107144:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010714a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107150 <ResetPageCounter>:
ResetPageCounter(struct proc *p, int index){
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
}
80107153:	5d                   	pop    %ebp
80107154:	c3                   	ret    
80107155:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107160 <InitPage>:
InitPage(pde_t *pgdir, void *va, uint pa, int index){
80107160:	55                   	push   %ebp
  if(mappages(pgdir, va, PGSIZE, pa, PTE_W|PTE_U) < 0){
80107161:	b9 00 10 00 00       	mov    $0x1000,%ecx
InitPage(pde_t *pgdir, void *va, uint pa, int index){
80107166:	89 e5                	mov    %esp,%ebp
80107168:	57                   	push   %edi
80107169:	56                   	push   %esi
8010716a:	53                   	push   %ebx
8010716b:	83 ec 14             	sub    $0x14,%esp
8010716e:	8b 5d 10             	mov    0x10(%ebp),%ebx
80107171:	8b 75 08             	mov    0x8(%ebp),%esi
80107174:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(mappages(pgdir, va, PGSIZE, pa, PTE_W|PTE_U) < 0){
80107177:	6a 06                	push   $0x6
80107179:	53                   	push   %ebx
8010717a:	89 f0                	mov    %esi,%eax
8010717c:	89 fa                	mov    %edi,%edx
8010717e:	e8 1d fb ff ff       	call   80106ca0 <mappages>
80107183:	83 c4 10             	add    $0x10,%esp
80107186:	85 c0                	test   %eax,%eax
80107188:	78 36                	js     801071c0 <InitPage+0x60>
    myproc()->main_mem_pages[index].state_used = 1;
8010718a:	e8 b1 ca ff ff       	call   80103c40 <myproc>
8010718f:	8b 55 14             	mov    0x14(%ebp),%edx
80107192:	8d 5a 08             	lea    0x8(%edx),%ebx
80107195:	c1 e3 04             	shl    $0x4,%ebx
80107198:	c6 04 18 01          	movb   $0x1,(%eax,%ebx,1)
    myproc()->main_mem_pages[index].v_addr = va;
8010719c:	e8 9f ca ff ff       	call   80103c40 <myproc>
801071a1:	89 7c 18 04          	mov    %edi,0x4(%eax,%ebx,1)
    myproc()->main_mem_pages[index].page_dir = pgdir;
801071a5:	e8 96 ca ff ff       	call   80103c40 <myproc>
801071aa:	89 74 18 08          	mov    %esi,0x8(%eax,%ebx,1)
    ResetPageCounter( myproc(), index);
801071ae:	e8 8d ca ff ff       	call   80103c40 <myproc>
}
801071b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801071b6:	31 c0                	xor    %eax,%eax
}
801071b8:	5b                   	pop    %ebx
801071b9:	5e                   	pop    %esi
801071ba:	5f                   	pop    %edi
801071bb:	5d                   	pop    %ebp
801071bc:	c3                   	ret    
801071bd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801071c0:	83 ec 0c             	sub    $0xc,%esp
801071c3:	68 09 87 10 80       	push   $0x80108709
801071c8:	e8 93 94 ff ff       	call   80100660 <cprintf>
      char *v = P2V(pa);
801071cd:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
      kfree(v);
801071d3:	89 04 24             	mov    %eax,(%esp)
801071d6:	e8 15 b5 ff ff       	call   801026f0 <kfree>
801071db:	83 c4 10             	add    $0x10,%esp
}
801071de:	8d 65 f4             	lea    -0xc(%ebp),%esp
      kfree(v);
801071e1:	b8 01 00 00 00       	mov    $0x1,%eax
}
801071e6:	5b                   	pop    %ebx
801071e7:	5e                   	pop    %esi
801071e8:	5f                   	pop    %edi
801071e9:	5d                   	pop    %ebp
801071ea:	c3                   	ret    
801071eb:	90                   	nop
801071ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801071f0 <NFU_AGING_Algo>:
NFU_AGING_Algo(struct proc *p){
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	57                   	push   %edi
801071f4:	56                   	push   %esi
801071f5:	53                   	push   %ebx
801071f6:	83 ec 0c             	sub    $0xc,%esp
801071f9:	8b 55 08             	mov    0x8(%ebp),%edx
  if(p->main_mem_pages[mm_index].state_used == 0){
801071fc:	80 ba 80 00 00 00 00 	cmpb   $0x0,0x80(%edx)
  uint minCounter = p->main_mem_pages[mm_index].counter;
80107203:	8b b2 8c 00 00 00    	mov    0x8c(%edx),%esi
  if(p->main_mem_pages[mm_index].state_used == 0){
80107209:	74 48                	je     80107253 <NFU_AGING_Algo+0x63>
8010720b:	81 c2 90 00 00 00    	add    $0x90,%edx
  i++;
80107211:	b9 01 00 00 00       	mov    $0x1,%ecx
  int mm_index = 0;
80107216:	31 ff                	xor    %edi,%edi
80107218:	90                   	nop
80107219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->main_mem_pages[i].state_used == 0)
80107220:	80 3a 00             	cmpb   $0x0,(%edx)
80107223:	74 2e                	je     80107253 <NFU_AGING_Algo+0x63>
    if(p->main_mem_pages[i].counter< minCounter){
80107225:	8b 5a 0c             	mov    0xc(%edx),%ebx
80107228:	39 f3                	cmp    %esi,%ebx
8010722a:	73 04                	jae    80107230 <NFU_AGING_Algo+0x40>
8010722c:	89 de                	mov    %ebx,%esi
8010722e:	89 cf                	mov    %ecx,%edi
    i++;
80107230:	83 c1 01             	add    $0x1,%ecx
80107233:	83 c2 10             	add    $0x10,%edx
  while(i<16){
80107236:	83 f9 10             	cmp    $0x10,%ecx
80107239:	75 e5                	jne    80107220 <NFU_AGING_Algo+0x30>
  cprintf("page min counter index=%d\n", mm_index);
8010723b:	83 ec 08             	sub    $0x8,%esp
8010723e:	57                   	push   %edi
8010723f:	68 25 87 10 80       	push   $0x80108725
80107244:	e8 17 94 ff ff       	call   80100660 <cprintf>
}
80107249:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010724c:	89 f8                	mov    %edi,%eax
8010724e:	5b                   	pop    %ebx
8010724f:	5e                   	pop    %esi
80107250:	5f                   	pop    %edi
80107251:	5d                   	pop    %ebp
80107252:	c3                   	ret    
    panic("NFU_AGING_Algo: found unused page in main_mem_pages arr");
80107253:	83 ec 0c             	sub    $0xc,%esp
80107256:	68 24 88 10 80       	push   $0x80108824
8010725b:	e8 30 91 ff ff       	call   80100390 <panic>

80107260 <GetSetBits>:
GetSetBits(int num){
80107260:	55                   	push   %ebp
	int count=0;
80107261:	31 c0                	xor    %eax,%eax
GetSetBits(int num){
80107263:	89 e5                	mov    %esp,%ebp
80107265:	8b 55 08             	mov    0x8(%ebp),%edx
	while(num!=0){
80107268:	85 d2                	test   %edx,%edx
8010726a:	74 13                	je     8010727f <GetSetBits+0x1f>
8010726c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(((uint)num & 1) == 1){ //if current bit 1
80107270:	89 d1                	mov    %edx,%ecx
80107272:	83 e1 01             	and    $0x1,%ecx
			count++;//increase count
80107275:	83 f9 01             	cmp    $0x1,%ecx
80107278:	83 d8 ff             	sbb    $0xffffffff,%eax
	while(num!=0){
8010727b:	d1 fa                	sar    %edx
8010727d:	75 f1                	jne    80107270 <GetSetBits+0x10>
}
8010727f:	5d                   	pop    %ebp
80107280:	c3                   	ret    
80107281:	eb 0d                	jmp    80107290 <LAP_AGING_Algo>
80107283:	90                   	nop
80107284:	90                   	nop
80107285:	90                   	nop
80107286:	90                   	nop
80107287:	90                   	nop
80107288:	90                   	nop
80107289:	90                   	nop
8010728a:	90                   	nop
8010728b:	90                   	nop
8010728c:	90                   	nop
8010728d:	90                   	nop
8010728e:	90                   	nop
8010728f:	90                   	nop

80107290 <LAP_AGING_Algo>:
LAP_AGING_Algo(struct proc *p){
80107290:	55                   	push   %ebp
80107291:	89 e5                	mov    %esp,%ebp
80107293:	57                   	push   %edi
80107294:	56                   	push   %esi
80107295:	53                   	push   %ebx
80107296:	83 ec 1c             	sub    $0x1c,%esp
80107299:	8b 75 08             	mov    0x8(%ebp),%esi
  uint minCounter_1 = p->main_mem_pages[mm_index].counter;
8010729c:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
	while(num!=0){
801072a2:	85 c0                	test   %eax,%eax
  uint minCounter_1 = p->main_mem_pages[mm_index].counter;
801072a4:	89 45 dc             	mov    %eax,-0x24(%ebp)
	while(num!=0){
801072a7:	0f 84 b6 00 00 00    	je     80107363 <LAP_AGING_Algo+0xd3>
	int count=0;
801072ad:	31 d2                	xor    %edx,%edx
801072af:	90                   	nop
		if(((uint)num & 1) == 1){ //if current bit 1
801072b0:	89 c1                	mov    %eax,%ecx
801072b2:	83 e1 01             	and    $0x1,%ecx
			count++;//increase count
801072b5:	83 f9 01             	cmp    $0x1,%ecx
801072b8:	83 da ff             	sbb    $0xffffffff,%edx
	while(num!=0){
801072bb:	d1 f8                	sar    %eax
801072bd:	75 f1                	jne    801072b0 <LAP_AGING_Algo+0x20>
801072bf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  if(p->main_mem_pages[mm_index].state_used == 0){
801072c2:	80 be 80 00 00 00 00 	cmpb   $0x0,0x80(%esi)
801072c9:	0f 84 a0 00 00 00    	je     8010736f <LAP_AGING_Algo+0xdf>
801072cf:	81 c6 90 00 00 00    	add    $0x90,%esi
  i++;
801072d5:	bf 01 00 00 00       	mov    $0x1,%edi
  int mm_index = 0;
801072da:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801072e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->main_mem_pages[i].state_used == 0)
801072e8:	80 3e 00             	cmpb   $0x0,(%esi)
801072eb:	0f 84 7e 00 00 00    	je     8010736f <LAP_AGING_Algo+0xdf>
    int curr_num_of_1 = GetSetBits(p->main_mem_pages[i].counter);
801072f1:	8b 5e 0c             	mov    0xc(%esi),%ebx
	int count=0;
801072f4:	31 d2                	xor    %edx,%edx
	while(num!=0){
801072f6:	85 db                	test   %ebx,%ebx
    int curr_num_of_1 = GetSetBits(p->main_mem_pages[i].counter);
801072f8:	89 d8                	mov    %ebx,%eax
	while(num!=0){
801072fa:	74 13                	je     8010730f <LAP_AGING_Algo+0x7f>
801072fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if(((uint)num & 1) == 1){ //if current bit 1
80107300:	89 c1                	mov    %eax,%ecx
80107302:	83 e1 01             	and    $0x1,%ecx
			count++;//increase count
80107305:	83 f9 01             	cmp    $0x1,%ecx
80107308:	83 da ff             	sbb    $0xffffffff,%edx
	while(num!=0){
8010730b:	d1 f8                	sar    %eax
8010730d:	75 f1                	jne    80107300 <LAP_AGING_Algo+0x70>
    if(curr_num_of_1 < num_of_1){
8010730f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107312:	39 c2                	cmp    %eax,%edx
80107314:	7c 42                	jl     80107358 <LAP_AGING_Algo+0xc8>
      if(p->main_mem_pages[i].counter < minCounter_1){
80107316:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80107319:	39 cb                	cmp    %ecx,%ebx
8010731b:	73 11                	jae    8010732e <LAP_AGING_Algo+0x9e>
    else if(curr_num_of_1 == num_of_1){
8010731d:	39 c2                	cmp    %eax,%edx
8010731f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107322:	0f 45 d9             	cmovne %ecx,%ebx
80107325:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80107328:	0f 44 c7             	cmove  %edi,%eax
8010732b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    i++;
8010732e:	83 c7 01             	add    $0x1,%edi
80107331:	83 c6 10             	add    $0x10,%esi
  while(i<16){
80107334:	83 ff 10             	cmp    $0x10,%edi
80107337:	75 af                	jne    801072e8 <LAP_AGING_Algo+0x58>
  cprintf("page min counter index=%d\n", mm_index);
80107339:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010733c:	83 ec 08             	sub    $0x8,%esp
8010733f:	56                   	push   %esi
80107340:	68 25 87 10 80       	push   $0x80108725
80107345:	e8 16 93 ff ff       	call   80100660 <cprintf>
}
8010734a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010734d:	89 f0                	mov    %esi,%eax
8010734f:	5b                   	pop    %ebx
80107350:	5e                   	pop    %esi
80107351:	5f                   	pop    %edi
80107352:	5d                   	pop    %ebp
80107353:	c3                   	ret    
80107354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int curr_num_of_1 = GetSetBits(p->main_mem_pages[i].counter);
80107358:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010735b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010735e:	89 7d e0             	mov    %edi,-0x20(%ebp)
80107361:	eb cb                	jmp    8010732e <LAP_AGING_Algo+0x9e>
	int count=0;
80107363:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010736a:	e9 53 ff ff ff       	jmp    801072c2 <LAP_AGING_Algo+0x32>
    panic("LAP_AGING_Algo: found unused page in main_mem_pages arr");
8010736f:	83 ec 0c             	sub    $0xc,%esp
80107372:	68 5c 88 10 80       	push   $0x8010885c
80107377:	e8 14 90 ff ff       	call   80100390 <panic>
8010737c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107380 <GetSwapPageIndex>:
GetSwapPageIndex(struct proc *p){
80107380:	55                   	push   %ebp
80107381:	89 e5                	mov    %esp,%ebp
}
80107383:	5d                   	pop    %ebp
  return NFU_AGING_Algo(p);// TODO: replace
80107384:	e9 67 fe ff ff       	jmp    801071f0 <NFU_AGING_Algo>
80107389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107390 <SwapOutPage>:
SwapOutPage(pde_t *pgdir){
80107390:	55                   	push   %ebp
80107391:	89 e5                	mov    %esp,%ebp
80107393:	57                   	push   %edi
80107394:	56                   	push   %esi
80107395:	53                   	push   %ebx
  int sp_index = 0;
80107396:	31 f6                	xor    %esi,%esi
SwapOutPage(pde_t *pgdir){
80107398:	83 ec 1c             	sub    $0x1c,%esp
8010739b:	eb 0f                	jmp    801073ac <SwapOutPage+0x1c>
8010739d:	8d 76 00             	lea    0x0(%esi),%esi
    sp_index++;
801073a0:	83 c6 01             	add    $0x1,%esi
  while(sp_index<16){
801073a3:	83 fe 10             	cmp    $0x10,%esi
801073a6:	0f 84 04 01 00 00    	je     801074b0 <SwapOutPage+0x120>
    if(!myproc()->swap_file_pages[sp_index].state_used){
801073ac:	8d 5e 18             	lea    0x18(%esi),%ebx
801073af:	e8 8c c8 ff ff       	call   80103c40 <myproc>
801073b4:	c1 e3 04             	shl    $0x4,%ebx
801073b7:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
801073bb:	75 e3                	jne    801073a0 <SwapOutPage+0x10>
  mm_index = GetSwapPageIndex(myproc());
801073bd:	e8 7e c8 ff ff       	call   80103c40 <myproc>
  return NFU_AGING_Algo(p);// TODO: replace
801073c2:	83 ec 0c             	sub    $0xc,%esp
801073c5:	50                   	push   %eax
801073c6:	e8 25 fe ff ff       	call   801071f0 <NFU_AGING_Algo>
  if(mm_index <0 || mm_index>15)
801073cb:	83 c4 10             	add    $0x10,%esp
801073ce:	83 f8 0f             	cmp    $0xf,%eax
  return NFU_AGING_Algo(p);// TODO: replace
801073d1:	89 c7                	mov    %eax,%edi
  if(mm_index <0 || mm_index>15)
801073d3:	0f 87 e3 00 00 00    	ja     801074bc <SwapOutPage+0x12c>
  void *mm_va = myproc()->main_mem_pages[mm_index].v_addr; // TODO: here we choose page to swapout
801073d9:	e8 62 c8 ff ff       	call   80103c40 <myproc>
801073de:	8d 57 08             	lea    0x8(%edi),%edx
  writeToSwapFile(myproc(), mm_va, sp_index*PGSIZE, PGSIZE); 
801073e1:	c1 e6 0c             	shl    $0xc,%esi
  void *mm_va = myproc()->main_mem_pages[mm_index].v_addr; // TODO: here we choose page to swapout
801073e4:	c1 e2 04             	shl    $0x4,%edx
801073e7:	8b 7c 10 04          	mov    0x4(%eax,%edx,1),%edi
801073eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  writeToSwapFile(myproc(), mm_va, sp_index*PGSIZE, PGSIZE); 
801073ee:	e8 4d c8 ff ff       	call   80103c40 <myproc>
801073f3:	68 00 10 00 00       	push   $0x1000
801073f8:	56                   	push   %esi
801073f9:	57                   	push   %edi
801073fa:	50                   	push   %eax
801073fb:	e8 90 ae ff ff       	call   80102290 <writeToSwapFile>
  myproc()->swap_file_pages[sp_index].state_used =1;
80107400:	e8 3b c8 ff ff       	call   80103c40 <myproc>
80107405:	c6 04 18 01          	movb   $0x1,(%eax,%ebx,1)
  myproc()->swap_file_pages[sp_index].page_dir = myproc()->main_mem_pages[mm_index].page_dir;
80107409:	e8 32 c8 ff ff       	call   80103c40 <myproc>
8010740e:	89 c6                	mov    %eax,%esi
80107410:	e8 2b c8 ff ff       	call   80103c40 <myproc>
80107415:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107418:	8b 4c 16 08          	mov    0x8(%esi,%edx,1),%ecx
8010741c:	89 4c 18 08          	mov    %ecx,0x8(%eax,%ebx,1)
  myproc()->swap_file_pages[sp_index].v_addr = mm_va;
80107420:	e8 1b c8 ff ff       	call   80103c40 <myproc>
80107425:	89 7c 18 04          	mov    %edi,0x4(%eax,%ebx,1)
  myproc()->swap_file_pages[sp_index].counter = 0; 
80107429:	e8 12 c8 ff ff       	call   80103c40 <myproc>
8010742e:	c7 44 18 0c 00 00 00 	movl   $0x0,0xc(%eax,%ebx,1)
80107435:	00 
  myproc()->main_mem_pages[mm_index].state_used = 0;
80107436:	e8 05 c8 ff ff       	call   80103c40 <myproc>
8010743b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010743e:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
  ResetPageCounter(myproc(), mm_index);
80107442:	e8 f9 c7 ff ff       	call   80103c40 <myproc>
  pte_t *pte = walkpgdir(pgdir, mm_va, 0);
80107447:	8b 45 08             	mov    0x8(%ebp),%eax
8010744a:	31 c9                	xor    %ecx,%ecx
8010744c:	89 fa                	mov    %edi,%edx
8010744e:	e8 cd f7 ff ff       	call   80106c20 <walkpgdir>
  uint pa = PTE_ADDR(*pte);
80107453:	8b 18                	mov    (%eax),%ebx
  pte_t *pte = walkpgdir(pgdir, mm_va, 0);
80107455:	89 c6                	mov    %eax,%esi
  memset((void *)P2V(pa), 0, PGSIZE);//Todo: pa or va?
80107457:	83 c4 0c             	add    $0xc,%esp
8010745a:	68 00 10 00 00       	push   $0x1000
8010745f:	6a 00                	push   $0x0
  uint pa = PTE_ADDR(*pte);
80107461:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  memset((void *)P2V(pa), 0, PGSIZE);//Todo: pa or va?
80107467:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010746d:	50                   	push   %eax
8010746e:	e8 3d d6 ff ff       	call   80104ab0 <memset>
  *pte &= ~PTE_P;
80107473:	8b 06                	mov    (%esi),%eax
80107475:	83 e0 fe             	and    $0xfffffffe,%eax
80107478:	80 cc 02             	or     $0x2,%ah
8010747b:	89 06                	mov    %eax,(%esi)
  lcr3(V2P(myproc()->pgdir));
8010747d:	e8 be c7 ff ff       	call   80103c40 <myproc>
80107482:	8b 40 04             	mov    0x4(%eax),%eax
80107485:	05 00 00 00 80       	add    $0x80000000,%eax
8010748a:	0f 22 d8             	mov    %eax,%cr3
  myproc()->swaps_out_counter+=1;
8010748d:	e8 ae c7 ff ff       	call   80103c40 <myproc>
  return pa;
80107492:	83 c4 10             	add    $0x10,%esp
  myproc()->swaps_out_counter+=1;
80107495:	83 80 84 02 00 00 01 	addl   $0x1,0x284(%eax)
}
8010749c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010749f:	89 d8                	mov    %ebx,%eax
801074a1:	5b                   	pop    %ebx
801074a2:	5e                   	pop    %esi
801074a3:	5f                   	pop    %edi
801074a4:	5d                   	pop    %ebp
801074a5:	c3                   	ret    
801074a6:	8d 76 00             	lea    0x0(%esi),%esi
801074a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801074b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801074b3:	31 db                	xor    %ebx,%ebx
}
801074b5:	89 d8                	mov    %ebx,%eax
801074b7:	5b                   	pop    %ebx
801074b8:	5e                   	pop    %esi
801074b9:	5f                   	pop    %edi
801074ba:	5d                   	pop    %ebp
801074bb:	c3                   	ret    
    panic("swappage: somthing wrong");
801074bc:	83 ec 0c             	sub    $0xc,%esp
801074bf:	68 40 87 10 80       	push   $0x80108740
801074c4:	e8 c7 8e ff ff       	call   80100390 <panic>
801074c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801074d0 <InitFreeMemPage>:
InitFreeMemPage(uint pa, void *va){
801074d0:	55                   	push   %ebp
801074d1:	89 e5                	mov    %esp,%ebp
801074d3:	53                   	push   %ebx
  int i =0;
801074d4:	31 db                	xor    %ebx,%ebx
InitFreeMemPage(uint pa, void *va){
801074d6:	83 ec 04             	sub    $0x4,%esp
801074d9:	eb 0d                	jmp    801074e8 <InitFreeMemPage+0x18>
801074db:	90                   	nop
801074dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    i++;
801074e0:	83 c3 01             	add    $0x1,%ebx
  while(i<16){
801074e3:	83 fb 10             	cmp    $0x10,%ebx
801074e6:	74 30                	je     80107518 <InitFreeMemPage+0x48>
    if(!myproc()->main_mem_pages[i].state_used){
801074e8:	e8 53 c7 ff ff       	call   80103c40 <myproc>
801074ed:	8d 53 08             	lea    0x8(%ebx),%edx
801074f0:	c1 e2 04             	shl    $0x4,%edx
801074f3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
801074f7:	75 e7                	jne    801074e0 <InitFreeMemPage+0x10>
      return InitPage(myproc()->pgdir, va, pa, i);
801074f9:	e8 42 c7 ff ff       	call   80103c40 <myproc>
801074fe:	53                   	push   %ebx
801074ff:	ff 75 08             	pushl  0x8(%ebp)
80107502:	ff 75 0c             	pushl  0xc(%ebp)
80107505:	ff 70 04             	pushl  0x4(%eax)
80107508:	e8 53 fc ff ff       	call   80107160 <InitPage>
8010750d:	83 c4 10             	add    $0x10,%esp
}
80107510:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107513:	c9                   	leave  
80107514:	c3                   	ret    
80107515:	8d 76 00             	lea    0x0(%esi),%esi
  return -1;
80107518:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010751d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107520:	c9                   	leave  
80107521:	c3                   	ret    
80107522:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107530 <allocuvm>:
{
80107530:	55                   	push   %ebp
80107531:	89 e5                	mov    %esp,%ebp
80107533:	57                   	push   %edi
80107534:	56                   	push   %esi
80107535:	53                   	push   %ebx
80107536:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107539:	8b 45 10             	mov    0x10(%ebp),%eax
8010753c:	85 c0                	test   %eax,%eax
8010753e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107541:	0f 88 e5 00 00 00    	js     8010762c <allocuvm+0xfc>
  if(newsz < oldsz)
80107547:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010754a:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
8010754d:	0f 82 ad 00 00 00    	jb     80107600 <allocuvm+0xd0>
  a = PGROUNDUP(oldsz);
80107553:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107559:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
8010755f:	39 75 10             	cmp    %esi,0x10(%ebp)
80107562:	77 3d                	ja     801075a1 <allocuvm+0x71>
80107564:	e9 9a 00 00 00       	jmp    80107603 <allocuvm+0xd3>
80107569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107570:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107576:	83 ec 08             	sub    $0x8,%esp
80107579:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010757e:	6a 06                	push   $0x6
80107580:	89 f2                	mov    %esi,%edx
80107582:	50                   	push   %eax
80107583:	8b 45 08             	mov    0x8(%ebp),%eax
80107586:	e8 15 f7 ff ff       	call   80106ca0 <mappages>
8010758b:	83 c4 10             	add    $0x10,%esp
8010758e:	85 c0                	test   %eax,%eax
80107590:	0f 88 fa 00 00 00    	js     80107690 <allocuvm+0x160>
  for(; a < newsz; a += PGSIZE){
80107596:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010759c:	39 75 10             	cmp    %esi,0x10(%ebp)
8010759f:	76 62                	jbe    80107603 <allocuvm+0xd3>
    mem = kalloc();
801075a1:	e8 fa b2 ff ff       	call   801028a0 <kalloc>
    if(mem == 0){
801075a6:	85 c0                	test   %eax,%eax
    mem = kalloc();
801075a8:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801075aa:	74 64                	je     80107610 <allocuvm+0xe0>
    memset(mem, 0, PGSIZE);
801075ac:	83 ec 04             	sub    $0x4,%esp
801075af:	68 00 10 00 00       	push   $0x1000
801075b4:	6a 00                	push   $0x0
801075b6:	50                   	push   %eax
801075b7:	e8 f4 d4 ff ff       	call   80104ab0 <memset>
    if(myproc()->pid > 2){
801075bc:	e8 7f c6 ff ff       	call   80103c40 <myproc>
801075c1:	83 c4 10             	add    $0x10,%esp
801075c4:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
801075c8:	7e a6                	jle    80107570 <allocuvm+0x40>
    int i =0;
801075ca:	31 ff                	xor    %edi,%edi
801075cc:	eb 0a                	jmp    801075d8 <allocuvm+0xa8>
801075ce:	66 90                	xchg   %ax,%ax
        i++;
801075d0:	83 c7 01             	add    $0x1,%edi
      while(i<16){
801075d3:	83 ff 10             	cmp    $0x10,%edi
801075d6:	74 68                	je     80107640 <allocuvm+0x110>
        if(!myproc()->main_mem_pages[i].state_used){
801075d8:	e8 63 c6 ff ff       	call   80103c40 <myproc>
801075dd:	8d 57 08             	lea    0x8(%edi),%edx
801075e0:	c1 e2 04             	shl    $0x4,%edx
801075e3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
801075e7:	75 e7                	jne    801075d0 <allocuvm+0xa0>
          InitPage(pgdir, (char*)a, V2P(mem), i);
801075e9:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801075ef:	57                   	push   %edi
801075f0:	53                   	push   %ebx
801075f1:	56                   	push   %esi
801075f2:	ff 75 08             	pushl  0x8(%ebp)
801075f5:	e8 66 fb ff ff       	call   80107160 <InitPage>
801075fa:	83 c4 10             	add    $0x10,%esp
801075fd:	eb 97                	jmp    80107596 <allocuvm+0x66>
801075ff:	90                   	nop
    return oldsz;
80107600:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107603:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107606:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107609:	5b                   	pop    %ebx
8010760a:	5e                   	pop    %esi
8010760b:	5f                   	pop    %edi
8010760c:	5d                   	pop    %ebp
8010760d:	c3                   	ret    
8010760e:	66 90                	xchg   %ax,%ax
      cprintf("allocuvm out of memory\n");
80107610:	83 ec 0c             	sub    $0xc,%esp
80107613:	68 59 87 10 80       	push   $0x80108759
80107618:	e8 43 90 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010761d:	83 c4 10             	add    $0x10,%esp
80107620:	8b 45 0c             	mov    0xc(%ebp),%eax
80107623:	39 45 10             	cmp    %eax,0x10(%ebp)
80107626:	0f 87 a1 00 00 00    	ja     801076cd <allocuvm+0x19d>
    return 0;
8010762c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107633:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107636:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107639:	5b                   	pop    %ebx
8010763a:	5e                   	pop    %esi
8010763b:	5f                   	pop    %edi
8010763c:	5d                   	pop    %ebp
8010763d:	c3                   	ret    
8010763e:	66 90                	xchg   %ax,%ax
        kfree(mem);
80107640:	83 ec 0c             	sub    $0xc,%esp
80107643:	53                   	push   %ebx
80107644:	e8 a7 b0 ff ff       	call   801026f0 <kfree>
        uint pa = SwapOutPage(pgdir);
80107649:	58                   	pop    %eax
8010764a:	ff 75 08             	pushl  0x8(%ebp)
8010764d:	e8 3e fd ff ff       	call   80107390 <SwapOutPage>
        if(pa == 0){
80107652:	83 c4 10             	add    $0x10,%esp
80107655:	85 c0                	test   %eax,%eax
        uint pa = SwapOutPage(pgdir);
80107657:	89 c3                	mov    %eax,%ebx
        if(pa == 0){
80107659:	74 15                	je     80107670 <allocuvm+0x140>
        InitFreeMemPage(pa, (char*)a);
8010765b:	83 ec 08             	sub    $0x8,%esp
8010765e:	56                   	push   %esi
8010765f:	53                   	push   %ebx
80107660:	e8 6b fe ff ff       	call   801074d0 <InitFreeMemPage>
80107665:	83 c4 10             	add    $0x10,%esp
80107668:	e9 29 ff ff ff       	jmp    80107596 <allocuvm+0x66>
8010766d:	8d 76 00             	lea    0x0(%esi),%esi
          cprintf("error: process %d needs more than 32 page, exits...", myproc()->pid);
80107670:	e8 cb c5 ff ff       	call   80103c40 <myproc>
80107675:	83 ec 08             	sub    $0x8,%esp
80107678:	ff 70 10             	pushl  0x10(%eax)
8010767b:	68 94 88 10 80       	push   $0x80108894
80107680:	e8 db 8f ff ff       	call   80100660 <cprintf>
          exit();
80107685:	e8 c6 ca ff ff       	call   80104150 <exit>
8010768a:	83 c4 10             	add    $0x10,%esp
8010768d:	eb cc                	jmp    8010765b <allocuvm+0x12b>
8010768f:	90                   	nop
        cprintf("allocuvm out of memory (2)\n");
80107690:	83 ec 0c             	sub    $0xc,%esp
80107693:	68 09 87 10 80       	push   $0x80108709
80107698:	e8 c3 8f ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010769d:	83 c4 10             	add    $0x10,%esp
801076a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801076a3:	39 45 10             	cmp    %eax,0x10(%ebp)
801076a6:	76 0d                	jbe    801076b5 <allocuvm+0x185>
801076a8:	89 c1                	mov    %eax,%ecx
801076aa:	8b 55 10             	mov    0x10(%ebp),%edx
801076ad:	8b 45 08             	mov    0x8(%ebp),%eax
801076b0:	e8 7b f6 ff ff       	call   80106d30 <deallocuvm.part.0>
        kfree(mem);
801076b5:	83 ec 0c             	sub    $0xc,%esp
801076b8:	53                   	push   %ebx
801076b9:	e8 32 b0 ff ff       	call   801026f0 <kfree>
        return 0;
801076be:	83 c4 10             	add    $0x10,%esp
801076c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801076c8:	e9 36 ff ff ff       	jmp    80107603 <allocuvm+0xd3>
801076cd:	89 c1                	mov    %eax,%ecx
801076cf:	8b 55 10             	mov    0x10(%ebp),%edx
801076d2:	8b 45 08             	mov    0x8(%ebp),%eax
801076d5:	e8 56 f6 ff ff       	call   80106d30 <deallocuvm.part.0>
      return 0;
801076da:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801076e1:	e9 1d ff ff ff       	jmp    80107603 <allocuvm+0xd3>
801076e6:	8d 76 00             	lea    0x0(%esi),%esi
801076e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076f0 <ImportFromFilePageToBuffer>:
ImportFromFilePageToBuffer(void *va){
801076f0:	55                   	push   %ebp
801076f1:	89 e5                	mov    %esp,%ebp
801076f3:	57                   	push   %edi
801076f4:	56                   	push   %esi
801076f5:	53                   	push   %ebx
  int  i = 0;
801076f6:	31 ff                	xor    %edi,%edi
ImportFromFilePageToBuffer(void *va){
801076f8:	83 ec 0c             	sub    $0xc,%esp
801076fb:	8b 75 08             	mov    0x8(%ebp),%esi
  while((myproc()->swap_file_pages[i].v_addr != va || myproc()->swap_file_pages[i].state_used == 0) && i< 16){
801076fe:	eb 08                	jmp    80107708 <ImportFromFilePageToBuffer+0x18>
80107700:	83 ff 10             	cmp    $0x10,%edi
80107703:	74 73                	je     80107778 <ImportFromFilePageToBuffer+0x88>
    i++;
80107705:	83 c7 01             	add    $0x1,%edi
  while((myproc()->swap_file_pages[i].v_addr != va || myproc()->swap_file_pages[i].state_used == 0) && i< 16){
80107708:	8d 5f 18             	lea    0x18(%edi),%ebx
8010770b:	e8 30 c5 ff ff       	call   80103c40 <myproc>
80107710:	c1 e3 04             	shl    $0x4,%ebx
80107713:	39 74 18 04          	cmp    %esi,0x4(%eax,%ebx,1)
80107717:	75 e7                	jne    80107700 <ImportFromFilePageToBuffer+0x10>
80107719:	e8 22 c5 ff ff       	call   80103c40 <myproc>
8010771e:	80 3c 18 00          	cmpb   $0x0,(%eax,%ebx,1)
80107722:	74 dc                	je     80107700 <ImportFromFilePageToBuffer+0x10>
  if(i>15){
80107724:	83 ff 10             	cmp    $0x10,%edi
80107727:	74 4f                	je     80107778 <ImportFromFilePageToBuffer+0x88>
  readFromSwapFile(myproc(), buffer, i*PGSIZE, PGSIZE); 
80107729:	e8 12 c5 ff ff       	call   80103c40 <myproc>
8010772e:	89 fa                	mov    %edi,%edx
80107730:	68 00 10 00 00       	push   $0x1000
80107735:	c1 e2 0c             	shl    $0xc,%edx
80107738:	52                   	push   %edx
80107739:	68 00 c6 10 80       	push   $0x8010c600
8010773e:	50                   	push   %eax
8010773f:	e8 7c ab ff ff       	call   801022c0 <readFromSwapFile>
  myproc()->swap_file_pages[i].state_used = 0;
80107744:	e8 f7 c4 ff ff       	call   80103c40 <myproc>
80107749:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  myproc()->swap_file_pages[i].v_addr = 0;
8010774d:	e8 ee c4 ff ff       	call   80103c40 <myproc>
80107752:	c7 44 18 04 00 00 00 	movl   $0x0,0x4(%eax,%ebx,1)
80107759:	00 
  myproc()->swap_file_pages[i].counter = 0;
8010775a:	e8 e1 c4 ff ff       	call   80103c40 <myproc>
8010775f:	c7 44 18 0c 00 00 00 	movl   $0x0,0xc(%eax,%ebx,1)
80107766:	00 
}
80107767:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010776a:	89 f8                	mov    %edi,%eax
8010776c:	5b                   	pop    %ebx
8010776d:	5e                   	pop    %esi
8010776e:	5f                   	pop    %edi
8010776f:	5d                   	pop    %ebp
80107770:	c3                   	ret    
80107771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("wow somthing wrong happend in PGFLT");
80107778:	83 ec 0c             	sub    $0xc,%esp
8010777b:	68 c8 88 10 80       	push   $0x801088c8
80107780:	e8 0b 8c ff ff       	call   80100390 <panic>
80107785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107790 <Handle_PGFLT>:
Handle_PGFLT(uint va){
80107790:	55                   	push   %ebp
80107791:	89 e5                	mov    %esp,%ebp
80107793:	57                   	push   %edi
80107794:	56                   	push   %esi
80107795:	53                   	push   %ebx
80107796:	83 ec 24             	sub    $0x24,%esp
80107799:	8b 5d 08             	mov    0x8(%ebp),%ebx
  cprintf("<PF 0x%x>\n", va);
8010779c:	53                   	push   %ebx
8010779d:	68 71 87 10 80       	push   $0x80108771
  void * align_va = (void *)PGROUNDDOWN(va);
801077a2:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  cprintf("<PF 0x%x>\n", va);
801077a8:	e8 b3 8e ff ff       	call   80100660 <cprintf>
  pde_t *pgdir = myproc()->pgdir;
801077ad:	e8 8e c4 ff ff       	call   80103c40 <myproc>
801077b2:	8b 70 04             	mov    0x4(%eax),%esi
  pte_t *pte = walkpgdir(pgdir, align_va, 0);
801077b5:	31 c9                	xor    %ecx,%ecx
801077b7:	89 da                	mov    %ebx,%edx
801077b9:	89 f0                	mov    %esi,%eax
801077bb:	e8 60 f4 ff ff       	call   80106c20 <walkpgdir>
  void *align_va_kernel_vir = P2V(PTE_ADDR(*pte));
801077c0:	8b 38                	mov    (%eax),%edi
801077c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801077c5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801077cb:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
801077d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  myproc()->page_fault_counter+=1;
801077d4:	e8 67 c4 ff ff       	call   80103c40 <myproc>
  } else if(!(*pte & PTE_PG)){
801077d9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  myproc()->page_fault_counter+=1;
801077dc:	83 80 80 02 00 00 01 	addl   $0x1,0x280(%eax)
  } else if(!(*pte & PTE_PG)){
801077e3:	83 c4 10             	add    $0x10,%esp
801077e6:	8b 01                	mov    (%ecx),%eax
801077e8:	f6 c4 02             	test   $0x2,%ah
801077eb:	0f 84 d3 00 00 00    	je     801078c4 <Handle_PGFLT+0x134>
  } else if(align_va_kernel_vir == 0){
801077f1:	81 ff 00 00 00 80    	cmp    $0x80000000,%edi
801077f7:	0f 84 fb 00 00 00    	je     801078f8 <Handle_PGFLT+0x168>
  ImportFromFilePageToBuffer(align_va);
801077fd:	83 ec 0c             	sub    $0xc,%esp
  int mm_index = 0;
80107800:	31 ff                	xor    %edi,%edi
  ImportFromFilePageToBuffer(align_va);
80107802:	53                   	push   %ebx
80107803:	e8 e8 fe ff ff       	call   801076f0 <ImportFromFilePageToBuffer>
80107808:	83 c4 10             	add    $0x10,%esp
8010780b:	eb 0f                	jmp    8010781c <Handle_PGFLT+0x8c>
8010780d:	8d 76 00             	lea    0x0(%esi),%esi
    mm_index++;
80107810:	83 c7 01             	add    $0x1,%edi
  while(mm_index<16){
80107813:	83 ff 10             	cmp    $0x10,%edi
80107816:	0f 84 84 00 00 00    	je     801078a0 <Handle_PGFLT+0x110>
    if(!myproc()->main_mem_pages[mm_index].state_used){
8010781c:	e8 1f c4 ff ff       	call   80103c40 <myproc>
80107821:	8d 57 08             	lea    0x8(%edi),%edx
80107824:	c1 e2 04             	shl    $0x4,%edx
80107827:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
8010782b:	75 e3                	jne    80107810 <Handle_PGFLT+0x80>
      pa = V2P(kalloc());
8010782d:	e8 6e b0 ff ff       	call   801028a0 <kalloc>
80107832:	05 00 00 00 80       	add    $0x80000000,%eax
  if(InitFreeMemPage(pa, align_va)){
80107837:	83 ec 08             	sub    $0x8,%esp
8010783a:	53                   	push   %ebx
8010783b:	50                   	push   %eax
8010783c:	e8 8f fc ff ff       	call   801074d0 <InitFreeMemPage>
80107841:	83 c4 10             	add    $0x10,%esp
80107844:	85 c0                	test   %eax,%eax
80107846:	0f 85 9f 00 00 00    	jne    801078eb <Handle_PGFLT+0x15b>
  cprintf("before memove in handle page fault\n");
8010784c:	83 ec 0c             	sub    $0xc,%esp
8010784f:	68 f4 89 10 80       	push   $0x801089f4
80107854:	e8 07 8e ff ff       	call   80100660 <cprintf>
  memmove(align_va_kernel_vir, buffer, PGSIZE);
80107859:	83 c4 0c             	add    $0xc,%esp
8010785c:	68 00 10 00 00       	push   $0x1000
80107861:	68 00 c6 10 80       	push   $0x8010c600
80107866:	ff 75 e4             	pushl  -0x1c(%ebp)
80107869:	e8 f2 d2 ff ff       	call   80104b60 <memmove>
  if( (pte = walkpgdir(pgdir, align_va, 0)) == 0){
8010786e:	31 c9                	xor    %ecx,%ecx
80107870:	89 da                	mov    %ebx,%edx
80107872:	89 f0                	mov    %esi,%eax
80107874:	e8 a7 f3 ff ff       	call   80106c20 <walkpgdir>
80107879:	83 c4 10             	add    $0x10,%esp
8010787c:	85 c0                	test   %eax,%eax
8010787e:	74 5e                	je     801078de <Handle_PGFLT+0x14e>
  } else if( (*pte & PTE_P) == 0){
80107880:	f6 00 01             	testb  $0x1,(%eax)
80107883:	74 4c                	je     801078d1 <Handle_PGFLT+0x141>
  cprintf("finish handle page fault\n");
80107885:	c7 45 08 7c 87 10 80 	movl   $0x8010877c,0x8(%ebp)
}
8010788c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010788f:	5b                   	pop    %ebx
80107890:	5e                   	pop    %esi
80107891:	5f                   	pop    %edi
80107892:	5d                   	pop    %ebp
  cprintf("finish handle page fault\n");
80107893:	e9 c8 8d ff ff       	jmp    80100660 <cprintf>
80107898:	90                   	nop
80107899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pa = SwapOutPage(myproc()->pgdir);
801078a0:	e8 9b c3 ff ff       	call   80103c40 <myproc>
801078a5:	83 ec 0c             	sub    $0xc,%esp
801078a8:	ff 70 04             	pushl  0x4(%eax)
801078ab:	e8 e0 fa ff ff       	call   80107390 <SwapOutPage>
    if(pa==0){
801078b0:	83 c4 10             	add    $0x10,%esp
801078b3:	85 c0                	test   %eax,%eax
801078b5:	75 80                	jne    80107837 <Handle_PGFLT+0xa7>
      panic("in Handle_PGFLT, unexpectedly no unused page in swap file");
801078b7:	83 ec 0c             	sub    $0xc,%esp
801078ba:	68 5c 89 10 80       	push   $0x8010895c
801078bf:	e8 cc 8a ff ff       	call   80100390 <panic>
    panic("in Handle_PGFLT, got T_PGFLT but page isnt in the swap file"); // TODO: check this case
801078c4:	83 ec 0c             	sub    $0xc,%esp
801078c7:	68 ec 88 10 80       	push   $0x801088ec
801078cc:	e8 bf 8a ff ff       	call   80100390 <panic>
    panic("user page isnt in physical memery after Handle_PGFLT\n");
801078d1:	83 ec 0c             	sub    $0xc,%esp
801078d4:	68 50 8a 10 80       	push   $0x80108a50
801078d9:	e8 b2 8a ff ff       	call   80100390 <panic>
    panic("page table isnt in physical memery after Handle_PGFLT\n");
801078de:	83 ec 0c             	sub    $0xc,%esp
801078e1:	68 18 8a 10 80       	push   $0x80108a18
801078e6:	e8 a5 8a ff ff       	call   80100390 <panic>
    panic("in Handle_PGFLT, unexpectedly failed to find unused entry in main_mem array of the process");
801078eb:	83 ec 0c             	sub    $0xc,%esp
801078ee:	68 98 89 10 80       	push   $0x80108998
801078f3:	e8 98 8a ff ff       	call   80100390 <panic>
    panic("in Handle_PGFLT, page table unexpectedly isnt exist");
801078f8:	83 ec 0c             	sub    $0xc,%esp
801078fb:	68 28 89 10 80       	push   $0x80108928
80107900:	e8 8b 8a ff ff       	call   80100390 <panic>
80107905:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107910 <deallocuvm>:
{
80107910:	55                   	push   %ebp
80107911:	89 e5                	mov    %esp,%ebp
80107913:	8b 55 0c             	mov    0xc(%ebp),%edx
80107916:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107919:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010791c:	39 d1                	cmp    %edx,%ecx
8010791e:	73 10                	jae    80107930 <deallocuvm+0x20>
}
80107920:	5d                   	pop    %ebp
80107921:	e9 0a f4 ff ff       	jmp    80106d30 <deallocuvm.part.0>
80107926:	8d 76 00             	lea    0x0(%esi),%esi
80107929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107930:	89 d0                	mov    %edx,%eax
80107932:	5d                   	pop    %ebp
80107933:	c3                   	ret    
80107934:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010793a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107940 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107940:	55                   	push   %ebp
80107941:	89 e5                	mov    %esp,%ebp
80107943:	57                   	push   %edi
80107944:	56                   	push   %esi
80107945:	53                   	push   %ebx
80107946:	83 ec 0c             	sub    $0xc,%esp
80107949:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010794c:	85 f6                	test   %esi,%esi
8010794e:	74 59                	je     801079a9 <freevm+0x69>
80107950:	31 c9                	xor    %ecx,%ecx
80107952:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107957:	89 f0                	mov    %esi,%eax
80107959:	e8 d2 f3 ff ff       	call   80106d30 <deallocuvm.part.0>
8010795e:	89 f3                	mov    %esi,%ebx
80107960:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107966:	eb 0f                	jmp    80107977 <freevm+0x37>
80107968:	90                   	nop
80107969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107970:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107973:	39 fb                	cmp    %edi,%ebx
80107975:	74 23                	je     8010799a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107977:	8b 03                	mov    (%ebx),%eax
80107979:	a8 01                	test   $0x1,%al
8010797b:	74 f3                	je     80107970 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010797d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107982:	83 ec 0c             	sub    $0xc,%esp
80107985:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107988:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010798d:	50                   	push   %eax
8010798e:	e8 5d ad ff ff       	call   801026f0 <kfree>
80107993:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107996:	39 fb                	cmp    %edi,%ebx
80107998:	75 dd                	jne    80107977 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010799a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010799d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079a0:	5b                   	pop    %ebx
801079a1:	5e                   	pop    %esi
801079a2:	5f                   	pop    %edi
801079a3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801079a4:	e9 47 ad ff ff       	jmp    801026f0 <kfree>
    panic("freevm: no pgdir");
801079a9:	83 ec 0c             	sub    $0xc,%esp
801079ac:	68 96 87 10 80       	push   $0x80108796
801079b1:	e8 da 89 ff ff       	call   80100390 <panic>
801079b6:	8d 76 00             	lea    0x0(%esi),%esi
801079b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801079c0 <setupkvm>:
{
801079c0:	55                   	push   %ebp
801079c1:	89 e5                	mov    %esp,%ebp
801079c3:	56                   	push   %esi
801079c4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801079c5:	e8 d6 ae ff ff       	call   801028a0 <kalloc>
801079ca:	85 c0                	test   %eax,%eax
801079cc:	89 c6                	mov    %eax,%esi
801079ce:	74 42                	je     80107a12 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801079d0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801079d3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801079d8:	68 00 10 00 00       	push   $0x1000
801079dd:	6a 00                	push   $0x0
801079df:	50                   	push   %eax
801079e0:	e8 cb d0 ff ff       	call   80104ab0 <memset>
801079e5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801079e8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801079eb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801079ee:	83 ec 08             	sub    $0x8,%esp
801079f1:	8b 13                	mov    (%ebx),%edx
801079f3:	ff 73 0c             	pushl  0xc(%ebx)
801079f6:	50                   	push   %eax
801079f7:	29 c1                	sub    %eax,%ecx
801079f9:	89 f0                	mov    %esi,%eax
801079fb:	e8 a0 f2 ff ff       	call   80106ca0 <mappages>
80107a00:	83 c4 10             	add    $0x10,%esp
80107a03:	85 c0                	test   %eax,%eax
80107a05:	78 19                	js     80107a20 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a07:	83 c3 10             	add    $0x10,%ebx
80107a0a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107a10:	75 d6                	jne    801079e8 <setupkvm+0x28>
}
80107a12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a15:	89 f0                	mov    %esi,%eax
80107a17:	5b                   	pop    %ebx
80107a18:	5e                   	pop    %esi
80107a19:	5d                   	pop    %ebp
80107a1a:	c3                   	ret    
80107a1b:	90                   	nop
80107a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107a20:	83 ec 0c             	sub    $0xc,%esp
80107a23:	56                   	push   %esi
      return 0;
80107a24:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107a26:	e8 15 ff ff ff       	call   80107940 <freevm>
      return 0;
80107a2b:	83 c4 10             	add    $0x10,%esp
}
80107a2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a31:	89 f0                	mov    %esi,%eax
80107a33:	5b                   	pop    %ebx
80107a34:	5e                   	pop    %esi
80107a35:	5d                   	pop    %ebp
80107a36:	c3                   	ret    
80107a37:	89 f6                	mov    %esi,%esi
80107a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a40 <kvmalloc>:
{
80107a40:	55                   	push   %ebp
80107a41:	89 e5                	mov    %esp,%ebp
80107a43:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107a46:	e8 75 ff ff ff       	call   801079c0 <setupkvm>
80107a4b:	a3 e4 07 12 80       	mov    %eax,0x801207e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107a50:	05 00 00 00 80       	add    $0x80000000,%eax
80107a55:	0f 22 d8             	mov    %eax,%cr3
}
80107a58:	c9                   	leave  
80107a59:	c3                   	ret    
80107a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a60 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107a60:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107a61:	31 c9                	xor    %ecx,%ecx
{
80107a63:	89 e5                	mov    %esp,%ebp
80107a65:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107a68:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a6b:	8b 45 08             	mov    0x8(%ebp),%eax
80107a6e:	e8 ad f1 ff ff       	call   80106c20 <walkpgdir>
  if(pte == 0)
80107a73:	85 c0                	test   %eax,%eax
80107a75:	74 05                	je     80107a7c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107a77:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107a7a:	c9                   	leave  
80107a7b:	c3                   	ret    
    panic("clearpteu");
80107a7c:	83 ec 0c             	sub    $0xc,%esp
80107a7f:	68 a7 87 10 80       	push   $0x801087a7
80107a84:	e8 07 89 ff ff       	call   80100390 <panic>
80107a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107a90 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107a90:	55                   	push   %ebp
80107a91:	89 e5                	mov    %esp,%ebp
80107a93:	57                   	push   %edi
80107a94:	56                   	push   %esi
80107a95:	53                   	push   %ebx
80107a96:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107a99:	e8 22 ff ff ff       	call   801079c0 <setupkvm>
80107a9e:	85 c0                	test   %eax,%eax
80107aa0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107aa3:	0f 84 9f 00 00 00    	je     80107b48 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107aa9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107aac:	85 c9                	test   %ecx,%ecx
80107aae:	0f 84 94 00 00 00    	je     80107b48 <copyuvm+0xb8>
80107ab4:	31 ff                	xor    %edi,%edi
80107ab6:	eb 4a                	jmp    80107b02 <copyuvm+0x72>
80107ab8:	90                   	nop
80107ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107ac0:	83 ec 04             	sub    $0x4,%esp
80107ac3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107ac9:	68 00 10 00 00       	push   $0x1000
80107ace:	53                   	push   %ebx
80107acf:	50                   	push   %eax
80107ad0:	e8 8b d0 ff ff       	call   80104b60 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107ad5:	58                   	pop    %eax
80107ad6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107adc:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107ae1:	5a                   	pop    %edx
80107ae2:	ff 75 e4             	pushl  -0x1c(%ebp)
80107ae5:	50                   	push   %eax
80107ae6:	89 fa                	mov    %edi,%edx
80107ae8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107aeb:	e8 b0 f1 ff ff       	call   80106ca0 <mappages>
80107af0:	83 c4 10             	add    $0x10,%esp
80107af3:	85 c0                	test   %eax,%eax
80107af5:	78 61                	js     80107b58 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107af7:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107afd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107b00:	76 46                	jbe    80107b48 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107b02:	8b 45 08             	mov    0x8(%ebp),%eax
80107b05:	31 c9                	xor    %ecx,%ecx
80107b07:	89 fa                	mov    %edi,%edx
80107b09:	e8 12 f1 ff ff       	call   80106c20 <walkpgdir>
80107b0e:	85 c0                	test   %eax,%eax
80107b10:	74 61                	je     80107b73 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107b12:	8b 00                	mov    (%eax),%eax
80107b14:	a8 01                	test   $0x1,%al
80107b16:	74 4e                	je     80107b66 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107b18:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80107b1a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80107b1f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107b25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107b28:	e8 73 ad ff ff       	call   801028a0 <kalloc>
80107b2d:	85 c0                	test   %eax,%eax
80107b2f:	89 c6                	mov    %eax,%esi
80107b31:	75 8d                	jne    80107ac0 <copyuvm+0x30>
    // }
  }
  return d;

bad:
  freevm(d);
80107b33:	83 ec 0c             	sub    $0xc,%esp
80107b36:	ff 75 e0             	pushl  -0x20(%ebp)
80107b39:	e8 02 fe ff ff       	call   80107940 <freevm>
  return 0;
80107b3e:	83 c4 10             	add    $0x10,%esp
80107b41:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107b48:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b4e:	5b                   	pop    %ebx
80107b4f:	5e                   	pop    %esi
80107b50:	5f                   	pop    %edi
80107b51:	5d                   	pop    %ebp
80107b52:	c3                   	ret    
80107b53:	90                   	nop
80107b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107b58:	83 ec 0c             	sub    $0xc,%esp
80107b5b:	56                   	push   %esi
80107b5c:	e8 8f ab ff ff       	call   801026f0 <kfree>
      goto bad;
80107b61:	83 c4 10             	add    $0x10,%esp
80107b64:	eb cd                	jmp    80107b33 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107b66:	83 ec 0c             	sub    $0xc,%esp
80107b69:	68 cb 87 10 80       	push   $0x801087cb
80107b6e:	e8 1d 88 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107b73:	83 ec 0c             	sub    $0xc,%esp
80107b76:	68 b1 87 10 80       	push   $0x801087b1
80107b7b:	e8 10 88 ff ff       	call   80100390 <panic>

80107b80 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107b80:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b81:	31 c9                	xor    %ecx,%ecx
{
80107b83:	89 e5                	mov    %esp,%ebp
80107b85:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107b88:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b8b:	8b 45 08             	mov    0x8(%ebp),%eax
80107b8e:	e8 8d f0 ff ff       	call   80106c20 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107b93:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107b95:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107b96:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107b98:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107b9d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ba0:	05 00 00 00 80       	add    $0x80000000,%eax
80107ba5:	83 fa 05             	cmp    $0x5,%edx
80107ba8:	ba 00 00 00 00       	mov    $0x0,%edx
80107bad:	0f 45 c2             	cmovne %edx,%eax
}
80107bb0:	c3                   	ret    
80107bb1:	eb 0d                	jmp    80107bc0 <copyout>
80107bb3:	90                   	nop
80107bb4:	90                   	nop
80107bb5:	90                   	nop
80107bb6:	90                   	nop
80107bb7:	90                   	nop
80107bb8:	90                   	nop
80107bb9:	90                   	nop
80107bba:	90                   	nop
80107bbb:	90                   	nop
80107bbc:	90                   	nop
80107bbd:	90                   	nop
80107bbe:	90                   	nop
80107bbf:	90                   	nop

80107bc0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	57                   	push   %edi
80107bc4:	56                   	push   %esi
80107bc5:	53                   	push   %ebx
80107bc6:	83 ec 1c             	sub    $0x1c,%esp
80107bc9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107bcc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bcf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107bd2:	85 db                	test   %ebx,%ebx
80107bd4:	75 40                	jne    80107c16 <copyout+0x56>
80107bd6:	eb 70                	jmp    80107c48 <copyout+0x88>
80107bd8:	90                   	nop
80107bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107be0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107be3:	89 f1                	mov    %esi,%ecx
80107be5:	29 d1                	sub    %edx,%ecx
80107be7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107bed:	39 d9                	cmp    %ebx,%ecx
80107bef:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107bf2:	29 f2                	sub    %esi,%edx
80107bf4:	83 ec 04             	sub    $0x4,%esp
80107bf7:	01 d0                	add    %edx,%eax
80107bf9:	51                   	push   %ecx
80107bfa:	57                   	push   %edi
80107bfb:	50                   	push   %eax
80107bfc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107bff:	e8 5c cf ff ff       	call   80104b60 <memmove>
    len -= n;
    buf += n;
80107c04:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107c07:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107c0a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107c10:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107c12:	29 cb                	sub    %ecx,%ebx
80107c14:	74 32                	je     80107c48 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107c16:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c18:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107c1b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107c1e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c24:	56                   	push   %esi
80107c25:	ff 75 08             	pushl  0x8(%ebp)
80107c28:	e8 53 ff ff ff       	call   80107b80 <uva2ka>
    if(pa0 == 0)
80107c2d:	83 c4 10             	add    $0x10,%esp
80107c30:	85 c0                	test   %eax,%eax
80107c32:	75 ac                	jne    80107be0 <copyout+0x20>
  }
  return 0;
}
80107c34:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c3c:	5b                   	pop    %ebx
80107c3d:	5e                   	pop    %esi
80107c3e:	5f                   	pop    %edi
80107c3f:	5d                   	pop    %ebp
80107c40:	c3                   	ret    
80107c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c48:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107c4b:	31 c0                	xor    %eax,%eax
}
80107c4d:	5b                   	pop    %ebx
80107c4e:	5e                   	pop    %esi
80107c4f:	5f                   	pop    %edi
80107c50:	5d                   	pop    %ebp
80107c51:	c3                   	ret    
80107c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c60 <UpdatePageCounters>:
//PAGEBREAK!
// Blank page.


void
UpdatePageCounters(){
80107c60:	55                   	push   %ebp
80107c61:	89 e5                	mov    %esp,%ebp
80107c63:	57                   	push   %edi
80107c64:	56                   	push   %esi
80107c65:	53                   	push   %ebx
80107c66:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107c69:	e8 d2 bf ff ff       	call   80103c40 <myproc>
80107c6e:	89 c7                	mov    %eax,%edi
80107c70:	8b 40 04             	mov    0x4(%eax),%eax
80107c73:	8d 9f 80 00 00 00    	lea    0x80(%edi),%ebx
80107c79:	8d b7 80 01 00 00    	lea    0x180(%edi),%esi
80107c7f:	eb 0e                	jmp    80107c8f <UpdatePageCounters+0x2f>
80107c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c88:	83 c3 10             	add    $0x10,%ebx
  pte_t *pte;
  for(int i=0; i<16; i++){
80107c8b:	39 f3                	cmp    %esi,%ebx
80107c8d:	74 3c                	je     80107ccb <UpdatePageCounters+0x6b>
    if(p->main_mem_pages[i].state_used){
80107c8f:	80 3b 00             	cmpb   $0x0,(%ebx)
80107c92:	74 f4                	je     80107c88 <UpdatePageCounters+0x28>
      pte = walkpgdir(p->pgdir, p->main_mem_pages[i].v_addr, 0);
80107c94:	8b 53 04             	mov    0x4(%ebx),%edx
80107c97:	31 c9                	xor    %ecx,%ecx
80107c99:	e8 82 ef ff ff       	call   80106c20 <walkpgdir>
      if(pte==0){
80107c9e:	85 c0                	test   %eax,%eax
80107ca0:	74 39                	je     80107cdb <UpdatePageCounters+0x7b>
        panic("panic: UpdatePageCounters");
      }
      p->main_mem_pages[i].counter >>= 1;
80107ca2:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80107ca5:	d1 e9                	shr    %ecx
80107ca7:	89 4b 0c             	mov    %ecx,0xc(%ebx)
      if(*pte & PTE_A){
80107caa:	8b 10                	mov    (%eax),%edx
80107cac:	f6 c2 20             	test   $0x20,%dl
80107caf:	74 0b                	je     80107cbc <UpdatePageCounters+0x5c>
        //shift right with 1 on msb
        p->main_mem_pages[i].counter |= 1<<31;
80107cb1:	81 c9 00 00 00 80    	or     $0x80000000,%ecx
80107cb7:	89 4b 0c             	mov    %ecx,0xc(%ebx)
80107cba:	8b 10                	mov    (%eax),%edx
80107cbc:	83 c3 10             	add    $0x10,%ebx
      }
      *pte = *pte & ~PTE_A;// reset the flag
80107cbf:	83 e2 df             	and    $0xffffffdf,%edx
  for(int i=0; i<16; i++){
80107cc2:	39 f3                	cmp    %esi,%ebx
      *pte = *pte & ~PTE_A;// reset the flag
80107cc4:	89 10                	mov    %edx,(%eax)
80107cc6:	8b 47 04             	mov    0x4(%edi),%eax
  for(int i=0; i<16; i++){
80107cc9:	75 c4                	jne    80107c8f <UpdatePageCounters+0x2f>
    }
  }
  lcr3(V2P(p->pgdir));
80107ccb:	05 00 00 00 80       	add    $0x80000000,%eax
80107cd0:	0f 22 d8             	mov    %eax,%cr3
}
80107cd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107cd6:	5b                   	pop    %ebx
80107cd7:	5e                   	pop    %esi
80107cd8:	5f                   	pop    %edi
80107cd9:	5d                   	pop    %ebp
80107cda:	c3                   	ret    
        panic("panic: UpdatePageCounters");
80107cdb:	83 ec 0c             	sub    $0xc,%esp
80107cde:	68 e5 87 10 80       	push   $0x801087e5
80107ce3:	e8 a8 86 ff ff       	call   80100390 <panic>
