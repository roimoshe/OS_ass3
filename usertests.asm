
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 3;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 1c             	sub    $0x1c,%esp
  printf(1,"-------------Task 1 Test-----------\n");
      11:	68 88 3d 00 00       	push   $0x3d88
      16:	6a 01                	push   $0x1
      18:	e8 13 3a 00 00       	call   3a30 <printf>
  // sleep(100);
  char *a = (char *)sbrk(4*PGSIZE);
      1d:	c7 04 24 00 40 00 00 	movl   $0x4000,(%esp)
      24:	e8 41 39 00 00       	call   396a <sbrk>
      29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  printf(1,"-------------after sbrk1-----------\n");
      2c:	58                   	pop    %eax
      2d:	5a                   	pop    %edx
      2e:	68 b0 3d 00 00       	push   $0x3db0
      33:	6a 01                	push   $0x1
      35:	e8 f6 39 00 00       	call   3a30 <printf>
  // sleep(100);
  volatile int *pointer;
  pointer = (int *)(a + 3*PGSIZE);
      3a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  printf(1,"---pointer = 0x%x, &pointer = 0x%x, a = 0x%x, &a = 0x%x, main = 0x%x---\n", pointer, &pointer, a, &a, main);
      3d:	8d 4d f0             	lea    -0x10(%ebp),%ecx
      40:	83 c4 0c             	add    $0xc,%esp
      43:	68 00 00 00 00       	push   $0x0
      48:	51                   	push   %ecx
  pointer = (int *)(a + 3*PGSIZE);
      49:	8d 82 00 30 00 00    	lea    0x3000(%edx),%eax
  printf(1,"---pointer = 0x%x, &pointer = 0x%x, a = 0x%x, &a = 0x%x, main = 0x%x---\n", pointer, &pointer, a, &a, main);
      4f:	52                   	push   %edx
      50:	8d 55 f4             	lea    -0xc(%ebp),%edx
      53:	52                   	push   %edx
      54:	50                   	push   %eax
      55:	68 d8 3d 00 00       	push   $0x3dd8
      5a:	6a 01                	push   $0x1
  pointer = (int *)(a + 3*PGSIZE);
      5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"---pointer = 0x%x, &pointer = 0x%x, a = 0x%x, &a = 0x%x, main = 0x%x---\n", pointer, &pointer, a, &a, main);
      5f:	e8 cc 39 00 00       	call   3a30 <printf>
  printf(1, "----accessing memory----\n");// problem ------------>
      64:	83 c4 18             	add    $0x18,%esp
      67:	68 b4 45 00 00       	push   $0x45b4
      6c:	6a 01                	push   $0x1
      6e:	e8 bd 39 00 00       	call   3a30 <printf>
  *pointer = 12;
      73:	8b 45 f4             	mov    -0xc(%ebp),%eax
  printf(1, "----%d----\n", *pointer);
      76:	83 c4 0c             	add    $0xc,%esp
  *pointer = 12;
      79:	c7 00 0c 00 00 00    	movl   $0xc,(%eax)
  printf(1, "----%d----\n", *pointer);
      7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      82:	8b 00                	mov    (%eax),%eax
      84:	50                   	push   %eax
      85:	68 ce 45 00 00       	push   $0x45ce
      8a:	6a 01                	push   $0x1
      8c:	e8 9f 39 00 00       	call   3a30 <printf>
  printf(1, "----allocating more memory----\n");
      91:	59                   	pop    %ecx
      92:	58                   	pop    %eax
      93:	68 24 3e 00 00       	push   $0x3e24
      98:	6a 01                	push   $0x1
      9a:	e8 91 39 00 00       	call   3a30 <printf>
  sbrk(PGSIZE);
      9f:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
      a6:	e8 bf 38 00 00       	call   396a <sbrk>
  printf(1, "----accessing memory----\n");
      ab:	58                   	pop    %eax
      ac:	5a                   	pop    %edx
      ad:	68 b4 45 00 00       	push   $0x45b4
      b2:	6a 01                	push   $0x1
      b4:	e8 77 39 00 00       	call   3a30 <printf>
  *pointer = (*pointer) + 8;
      b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  printf(1, "----%d----\n", *pointer);
      bc:	83 c4 0c             	add    $0xc,%esp
  *pointer = (*pointer) + 8;
      bf:	8b 02                	mov    (%edx),%eax
      c1:	83 c0 08             	add    $0x8,%eax
      c4:	89 02                	mov    %eax,(%edx)
  printf(1, "----%d----\n", *pointer);
      c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c9:	8b 00                	mov    (%eax),%eax
      cb:	50                   	push   %eax
      cc:	68 ce 45 00 00       	push   $0x45ce
      d1:	6a 01                	push   $0x1
      d3:	e8 58 39 00 00       	call   3a30 <printf>
  sbrk(14*PGSIZE);
      d8:	c7 04 24 00 e0 00 00 	movl   $0xe000,(%esp)
      df:	e8 86 38 00 00       	call   396a <sbrk>
  printf(1,"-------------after sbrk2-----------\n");
      e4:	59                   	pop    %ecx
      e5:	58                   	pop    %eax
      e6:	68 44 3e 00 00       	push   $0x3e44
      eb:	6a 01                	push   $0x1
      ed:	e8 3e 39 00 00       	call   3a30 <printf>
  sleep(2000);
      f2:	c7 04 24 d0 07 00 00 	movl   $0x7d0,(%esp)
      f9:	e8 74 38 00 00       	call   3972 <sleep>
  pointer = (int *)(a + PGSIZE * 10);
      fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  *pointer = 99;
  func(pointer);
  printf(1, "----%d----\n", *pointer);
     101:	83 c4 0c             	add    $0xc,%esp
  pointer = (int *)(a + PGSIZE * 10);
     104:	8d 90 00 a0 00 00    	lea    0xa000(%eax),%edx
  *pointer = 99;
     10a:	c7 80 00 a0 00 00 63 	movl   $0x63,0xa000(%eax)
     111:	00 00 00 
  pointer = (int *)(a + PGSIZE * 10);
     114:	89 55 f4             	mov    %edx,-0xc(%ebp)
  *tmp = *tmp + 1;
     117:	8b 90 00 a0 00 00    	mov    0xa000(%eax),%edx
     11d:	83 c2 01             	add    $0x1,%edx
     120:	89 90 00 a0 00 00    	mov    %edx,0xa000(%eax)
  printf(1, "----%d----\n", *pointer);
     126:	8b 80 00 a0 00 00    	mov    0xa000(%eax),%eax
     12c:	50                   	push   %eax
     12d:	68 ce 45 00 00       	push   $0x45ce
     132:	6a 01                	push   $0x1
     134:	e8 f7 38 00 00       	call   3a30 <printf>
  exit();
     139:	e8 a4 37 00 00       	call   38e2 <exit>
     13e:	66 90                	xchg   %ax,%ax

00000140 <iputtest>:
{
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     146:	68 6e 46 00 00       	push   $0x466e
     14b:	ff 35 10 5f 00 00    	pushl  0x5f10
     151:	e8 da 38 00 00       	call   3a30 <printf>
  if(mkdir("iputdir") < 0){
     156:	c7 04 24 01 46 00 00 	movl   $0x4601,(%esp)
     15d:	e8 e8 37 00 00       	call   394a <mkdir>
     162:	83 c4 10             	add    $0x10,%esp
     165:	85 c0                	test   %eax,%eax
     167:	78 58                	js     1c1 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	68 01 46 00 00       	push   $0x4601
     171:	e8 dc 37 00 00       	call   3952 <chdir>
     176:	83 c4 10             	add    $0x10,%esp
     179:	85 c0                	test   %eax,%eax
     17b:	0f 88 85 00 00 00    	js     206 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     181:	83 ec 0c             	sub    $0xc,%esp
     184:	68 fe 45 00 00       	push   $0x45fe
     189:	e8 a4 37 00 00       	call   3932 <unlink>
     18e:	83 c4 10             	add    $0x10,%esp
     191:	85 c0                	test   %eax,%eax
     193:	78 5a                	js     1ef <iputtest+0xaf>
  if(chdir("/") < 0){
     195:	83 ec 0c             	sub    $0xc,%esp
     198:	68 23 46 00 00       	push   $0x4623
     19d:	e8 b0 37 00 00       	call   3952 <chdir>
     1a2:	83 c4 10             	add    $0x10,%esp
     1a5:	85 c0                	test   %eax,%eax
     1a7:	78 2f                	js     1d8 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     1a9:	83 ec 08             	sub    $0x8,%esp
     1ac:	68 a6 46 00 00       	push   $0x46a6
     1b1:	ff 35 10 5f 00 00    	pushl  0x5f10
     1b7:	e8 74 38 00 00       	call   3a30 <printf>
}
     1bc:	83 c4 10             	add    $0x10,%esp
     1bf:	c9                   	leave  
     1c0:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     1c1:	50                   	push   %eax
     1c2:	50                   	push   %eax
     1c3:	68 da 45 00 00       	push   $0x45da
     1c8:	ff 35 10 5f 00 00    	pushl  0x5f10
     1ce:	e8 5d 38 00 00       	call   3a30 <printf>
    exit();
     1d3:	e8 0a 37 00 00       	call   38e2 <exit>
    printf(stdout, "chdir / failed\n");
     1d8:	50                   	push   %eax
     1d9:	50                   	push   %eax
     1da:	68 25 46 00 00       	push   $0x4625
     1df:	ff 35 10 5f 00 00    	pushl  0x5f10
     1e5:	e8 46 38 00 00       	call   3a30 <printf>
    exit();
     1ea:	e8 f3 36 00 00       	call   38e2 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1ef:	52                   	push   %edx
     1f0:	52                   	push   %edx
     1f1:	68 09 46 00 00       	push   $0x4609
     1f6:	ff 35 10 5f 00 00    	pushl  0x5f10
     1fc:	e8 2f 38 00 00       	call   3a30 <printf>
    exit();
     201:	e8 dc 36 00 00       	call   38e2 <exit>
    printf(stdout, "chdir iputdir failed\n");
     206:	51                   	push   %ecx
     207:	51                   	push   %ecx
     208:	68 e8 45 00 00       	push   $0x45e8
     20d:	ff 35 10 5f 00 00    	pushl  0x5f10
     213:	e8 18 38 00 00       	call   3a30 <printf>
    exit();
     218:	e8 c5 36 00 00       	call   38e2 <exit>
     21d:	8d 76 00             	lea    0x0(%esi),%esi

00000220 <exitiputtest>:
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     226:	68 35 46 00 00       	push   $0x4635
     22b:	ff 35 10 5f 00 00    	pushl  0x5f10
     231:	e8 fa 37 00 00       	call   3a30 <printf>
  pid = fork();
     236:	e8 9f 36 00 00       	call   38da <fork>
  if(pid < 0){
     23b:	83 c4 10             	add    $0x10,%esp
     23e:	85 c0                	test   %eax,%eax
     240:	0f 88 82 00 00 00    	js     2c8 <exitiputtest+0xa8>
  if(pid == 0){
     246:	75 48                	jne    290 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     248:	83 ec 0c             	sub    $0xc,%esp
     24b:	68 01 46 00 00       	push   $0x4601
     250:	e8 f5 36 00 00       	call   394a <mkdir>
     255:	83 c4 10             	add    $0x10,%esp
     258:	85 c0                	test   %eax,%eax
     25a:	0f 88 96 00 00 00    	js     2f6 <exitiputtest+0xd6>
    if(chdir("iputdir") < 0){
     260:	83 ec 0c             	sub    $0xc,%esp
     263:	68 01 46 00 00       	push   $0x4601
     268:	e8 e5 36 00 00       	call   3952 <chdir>
     26d:	83 c4 10             	add    $0x10,%esp
     270:	85 c0                	test   %eax,%eax
     272:	78 6b                	js     2df <exitiputtest+0xbf>
    if(unlink("../iputdir") < 0){
     274:	83 ec 0c             	sub    $0xc,%esp
     277:	68 fe 45 00 00       	push   $0x45fe
     27c:	e8 b1 36 00 00       	call   3932 <unlink>
     281:	83 c4 10             	add    $0x10,%esp
     284:	85 c0                	test   %eax,%eax
     286:	78 28                	js     2b0 <exitiputtest+0x90>
    exit();
     288:	e8 55 36 00 00       	call   38e2 <exit>
     28d:	8d 76 00             	lea    0x0(%esi),%esi
  wait();
     290:	e8 55 36 00 00       	call   38ea <wait>
  printf(stdout, "exitiput test ok\n");
     295:	83 ec 08             	sub    $0x8,%esp
     298:	68 58 46 00 00       	push   $0x4658
     29d:	ff 35 10 5f 00 00    	pushl  0x5f10
     2a3:	e8 88 37 00 00       	call   3a30 <printf>
}
     2a8:	83 c4 10             	add    $0x10,%esp
     2ab:	c9                   	leave  
     2ac:	c3                   	ret    
     2ad:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     2b0:	83 ec 08             	sub    $0x8,%esp
     2b3:	68 09 46 00 00       	push   $0x4609
     2b8:	ff 35 10 5f 00 00    	pushl  0x5f10
     2be:	e8 6d 37 00 00       	call   3a30 <printf>
      exit();
     2c3:	e8 1a 36 00 00       	call   38e2 <exit>
    printf(stdout, "fork failed\n");
     2c8:	51                   	push   %ecx
     2c9:	51                   	push   %ecx
     2ca:	68 1b 55 00 00       	push   $0x551b
     2cf:	ff 35 10 5f 00 00    	pushl  0x5f10
     2d5:	e8 56 37 00 00       	call   3a30 <printf>
    exit();
     2da:	e8 03 36 00 00       	call   38e2 <exit>
      printf(stdout, "child chdir failed\n");
     2df:	50                   	push   %eax
     2e0:	50                   	push   %eax
     2e1:	68 44 46 00 00       	push   $0x4644
     2e6:	ff 35 10 5f 00 00    	pushl  0x5f10
     2ec:	e8 3f 37 00 00       	call   3a30 <printf>
      exit();
     2f1:	e8 ec 35 00 00       	call   38e2 <exit>
      printf(stdout, "mkdir failed\n");
     2f6:	52                   	push   %edx
     2f7:	52                   	push   %edx
     2f8:	68 da 45 00 00       	push   $0x45da
     2fd:	ff 35 10 5f 00 00    	pushl  0x5f10
     303:	e8 28 37 00 00       	call   3a30 <printf>
      exit();
     308:	e8 d5 35 00 00       	call   38e2 <exit>
     30d:	8d 76 00             	lea    0x0(%esi),%esi

00000310 <openiputtest>:
{
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     316:	68 6a 46 00 00       	push   $0x466a
     31b:	ff 35 10 5f 00 00    	pushl  0x5f10
     321:	e8 0a 37 00 00       	call   3a30 <printf>
  if(mkdir("oidir") < 0){
     326:	c7 04 24 79 46 00 00 	movl   $0x4679,(%esp)
     32d:	e8 18 36 00 00       	call   394a <mkdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	0f 88 88 00 00 00    	js     3c5 <openiputtest+0xb5>
  pid = fork();
     33d:	e8 98 35 00 00       	call   38da <fork>
  if(pid < 0){
     342:	85 c0                	test   %eax,%eax
     344:	0f 88 92 00 00 00    	js     3dc <openiputtest+0xcc>
  if(pid == 0){
     34a:	75 34                	jne    380 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     34c:	83 ec 08             	sub    $0x8,%esp
     34f:	6a 02                	push   $0x2
     351:	68 79 46 00 00       	push   $0x4679
     356:	e8 c7 35 00 00       	call   3922 <open>
    if(fd >= 0){
     35b:	83 c4 10             	add    $0x10,%esp
     35e:	85 c0                	test   %eax,%eax
     360:	78 5e                	js     3c0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     362:	83 ec 08             	sub    $0x8,%esp
     365:	68 6c 3e 00 00       	push   $0x3e6c
     36a:	ff 35 10 5f 00 00    	pushl  0x5f10
     370:	e8 bb 36 00 00       	call   3a30 <printf>
      exit();
     375:	e8 68 35 00 00       	call   38e2 <exit>
     37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  sleep(1);
     380:	83 ec 0c             	sub    $0xc,%esp
     383:	6a 01                	push   $0x1
     385:	e8 e8 35 00 00       	call   3972 <sleep>
  if(unlink("oidir") != 0){
     38a:	c7 04 24 79 46 00 00 	movl   $0x4679,(%esp)
     391:	e8 9c 35 00 00       	call   3932 <unlink>
     396:	83 c4 10             	add    $0x10,%esp
     399:	85 c0                	test   %eax,%eax
     39b:	75 56                	jne    3f3 <openiputtest+0xe3>
  wait();
     39d:	e8 48 35 00 00       	call   38ea <wait>
  printf(stdout, "openiput test ok\n");
     3a2:	83 ec 08             	sub    $0x8,%esp
     3a5:	68 a2 46 00 00       	push   $0x46a2
     3aa:	ff 35 10 5f 00 00    	pushl  0x5f10
     3b0:	e8 7b 36 00 00       	call   3a30 <printf>
}
     3b5:	83 c4 10             	add    $0x10,%esp
     3b8:	c9                   	leave  
     3b9:	c3                   	ret    
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     3c0:	e8 1d 35 00 00       	call   38e2 <exit>
    printf(stdout, "mkdir oidir failed\n");
     3c5:	51                   	push   %ecx
     3c6:	51                   	push   %ecx
     3c7:	68 7f 46 00 00       	push   $0x467f
     3cc:	ff 35 10 5f 00 00    	pushl  0x5f10
     3d2:	e8 59 36 00 00       	call   3a30 <printf>
    exit();
     3d7:	e8 06 35 00 00       	call   38e2 <exit>
    printf(stdout, "fork failed\n");
     3dc:	52                   	push   %edx
     3dd:	52                   	push   %edx
     3de:	68 1b 55 00 00       	push   $0x551b
     3e3:	ff 35 10 5f 00 00    	pushl  0x5f10
     3e9:	e8 42 36 00 00       	call   3a30 <printf>
    exit();
     3ee:	e8 ef 34 00 00       	call   38e2 <exit>
    printf(stdout, "unlink failed\n");
     3f3:	50                   	push   %eax
     3f4:	50                   	push   %eax
     3f5:	68 93 46 00 00       	push   $0x4693
     3fa:	ff 35 10 5f 00 00    	pushl  0x5f10
     400:	e8 2b 36 00 00       	call   3a30 <printf>
    exit();
     405:	e8 d8 34 00 00       	call   38e2 <exit>
     40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000410 <opentest>:
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     416:	68 b4 46 00 00       	push   $0x46b4
     41b:	ff 35 10 5f 00 00    	pushl  0x5f10
     421:	e8 0a 36 00 00       	call   3a30 <printf>
  fd = open("echo", 0);
     426:	58                   	pop    %eax
     427:	5a                   	pop    %edx
     428:	6a 00                	push   $0x0
     42a:	68 bf 46 00 00       	push   $0x46bf
     42f:	e8 ee 34 00 00       	call   3922 <open>
  if(fd < 0){
     434:	83 c4 10             	add    $0x10,%esp
     437:	85 c0                	test   %eax,%eax
     439:	78 36                	js     471 <opentest+0x61>
  close(fd);
     43b:	83 ec 0c             	sub    $0xc,%esp
     43e:	50                   	push   %eax
     43f:	e8 c6 34 00 00       	call   390a <close>
  fd = open("doesnotexist", 0);
     444:	5a                   	pop    %edx
     445:	59                   	pop    %ecx
     446:	6a 00                	push   $0x0
     448:	68 d7 46 00 00       	push   $0x46d7
     44d:	e8 d0 34 00 00       	call   3922 <open>
  if(fd >= 0){
     452:	83 c4 10             	add    $0x10,%esp
     455:	85 c0                	test   %eax,%eax
     457:	79 2f                	jns    488 <opentest+0x78>
  printf(stdout, "open test ok\n");
     459:	83 ec 08             	sub    $0x8,%esp
     45c:	68 02 47 00 00       	push   $0x4702
     461:	ff 35 10 5f 00 00    	pushl  0x5f10
     467:	e8 c4 35 00 00       	call   3a30 <printf>
}
     46c:	83 c4 10             	add    $0x10,%esp
     46f:	c9                   	leave  
     470:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     471:	50                   	push   %eax
     472:	50                   	push   %eax
     473:	68 c4 46 00 00       	push   $0x46c4
     478:	ff 35 10 5f 00 00    	pushl  0x5f10
     47e:	e8 ad 35 00 00       	call   3a30 <printf>
    exit();
     483:	e8 5a 34 00 00       	call   38e2 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     488:	50                   	push   %eax
     489:	50                   	push   %eax
     48a:	68 e4 46 00 00       	push   $0x46e4
     48f:	ff 35 10 5f 00 00    	pushl  0x5f10
     495:	e8 96 35 00 00       	call   3a30 <printf>
    exit();
     49a:	e8 43 34 00 00       	call   38e2 <exit>
     49f:	90                   	nop

000004a0 <writetest>:
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	56                   	push   %esi
     4a4:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     4a5:	83 ec 08             	sub    $0x8,%esp
     4a8:	68 10 47 00 00       	push   $0x4710
     4ad:	ff 35 10 5f 00 00    	pushl  0x5f10
     4b3:	e8 78 35 00 00       	call   3a30 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     4b8:	58                   	pop    %eax
     4b9:	5a                   	pop    %edx
     4ba:	68 02 02 00 00       	push   $0x202
     4bf:	68 21 47 00 00       	push   $0x4721
     4c4:	e8 59 34 00 00       	call   3922 <open>
  if(fd >= 0){
     4c9:	83 c4 10             	add    $0x10,%esp
     4cc:	85 c0                	test   %eax,%eax
     4ce:	0f 88 88 01 00 00    	js     65c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     4d4:	83 ec 08             	sub    $0x8,%esp
     4d7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4d9:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4db:	68 27 47 00 00       	push   $0x4727
     4e0:	ff 35 10 5f 00 00    	pushl  0x5f10
     4e6:	e8 45 35 00 00       	call   3a30 <printf>
     4eb:	83 c4 10             	add    $0x10,%esp
     4ee:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4f0:	83 ec 04             	sub    $0x4,%esp
     4f3:	6a 0a                	push   $0xa
     4f5:	68 5e 47 00 00       	push   $0x475e
     4fa:	56                   	push   %esi
     4fb:	e8 02 34 00 00       	call   3902 <write>
     500:	83 c4 10             	add    $0x10,%esp
     503:	83 f8 0a             	cmp    $0xa,%eax
     506:	0f 85 d9 00 00 00    	jne    5e5 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     50c:	83 ec 04             	sub    $0x4,%esp
     50f:	6a 0a                	push   $0xa
     511:	68 69 47 00 00       	push   $0x4769
     516:	56                   	push   %esi
     517:	e8 e6 33 00 00       	call   3902 <write>
     51c:	83 c4 10             	add    $0x10,%esp
     51f:	83 f8 0a             	cmp    $0xa,%eax
     522:	0f 85 d6 00 00 00    	jne    5fe <writetest+0x15e>
  for(i = 0; i < 100; i++){
     528:	83 c3 01             	add    $0x1,%ebx
     52b:	83 fb 64             	cmp    $0x64,%ebx
     52e:	75 c0                	jne    4f0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     530:	83 ec 08             	sub    $0x8,%esp
     533:	68 74 47 00 00       	push   $0x4774
     538:	ff 35 10 5f 00 00    	pushl  0x5f10
     53e:	e8 ed 34 00 00       	call   3a30 <printf>
  close(fd);
     543:	89 34 24             	mov    %esi,(%esp)
     546:	e8 bf 33 00 00       	call   390a <close>
  fd = open("small", O_RDONLY);
     54b:	5b                   	pop    %ebx
     54c:	5e                   	pop    %esi
     54d:	6a 00                	push   $0x0
     54f:	68 21 47 00 00       	push   $0x4721
     554:	e8 c9 33 00 00       	call   3922 <open>
  if(fd >= 0){
     559:	83 c4 10             	add    $0x10,%esp
     55c:	85 c0                	test   %eax,%eax
  fd = open("small", O_RDONLY);
     55e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     560:	0f 88 b1 00 00 00    	js     617 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     566:	83 ec 08             	sub    $0x8,%esp
     569:	68 7f 47 00 00       	push   $0x477f
     56e:	ff 35 10 5f 00 00    	pushl  0x5f10
     574:	e8 b7 34 00 00       	call   3a30 <printf>
  i = read(fd, buf, 2000);
     579:	83 c4 0c             	add    $0xc,%esp
     57c:	68 d0 07 00 00       	push   $0x7d0
     581:	68 00 87 00 00       	push   $0x8700
     586:	53                   	push   %ebx
     587:	e8 6e 33 00 00       	call   38fa <read>
  if(i == 2000){
     58c:	83 c4 10             	add    $0x10,%esp
     58f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     594:	0f 85 94 00 00 00    	jne    62e <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     59a:	83 ec 08             	sub    $0x8,%esp
     59d:	68 b3 47 00 00       	push   $0x47b3
     5a2:	ff 35 10 5f 00 00    	pushl  0x5f10
     5a8:	e8 83 34 00 00       	call   3a30 <printf>
  close(fd);
     5ad:	89 1c 24             	mov    %ebx,(%esp)
     5b0:	e8 55 33 00 00       	call   390a <close>
  if(unlink("small") < 0){
     5b5:	c7 04 24 21 47 00 00 	movl   $0x4721,(%esp)
     5bc:	e8 71 33 00 00       	call   3932 <unlink>
     5c1:	83 c4 10             	add    $0x10,%esp
     5c4:	85 c0                	test   %eax,%eax
     5c6:	78 7d                	js     645 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     5c8:	83 ec 08             	sub    $0x8,%esp
     5cb:	68 db 47 00 00       	push   $0x47db
     5d0:	ff 35 10 5f 00 00    	pushl  0x5f10
     5d6:	e8 55 34 00 00       	call   3a30 <printf>
}
     5db:	83 c4 10             	add    $0x10,%esp
     5de:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5e1:	5b                   	pop    %ebx
     5e2:	5e                   	pop    %esi
     5e3:	5d                   	pop    %ebp
     5e4:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5e5:	83 ec 04             	sub    $0x4,%esp
     5e8:	53                   	push   %ebx
     5e9:	68 90 3e 00 00       	push   $0x3e90
     5ee:	ff 35 10 5f 00 00    	pushl  0x5f10
     5f4:	e8 37 34 00 00       	call   3a30 <printf>
      exit();
     5f9:	e8 e4 32 00 00       	call   38e2 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5fe:	83 ec 04             	sub    $0x4,%esp
     601:	53                   	push   %ebx
     602:	68 b4 3e 00 00       	push   $0x3eb4
     607:	ff 35 10 5f 00 00    	pushl  0x5f10
     60d:	e8 1e 34 00 00       	call   3a30 <printf>
      exit();
     612:	e8 cb 32 00 00       	call   38e2 <exit>
    printf(stdout, "error: open small failed!\n");
     617:	51                   	push   %ecx
     618:	51                   	push   %ecx
     619:	68 98 47 00 00       	push   $0x4798
     61e:	ff 35 10 5f 00 00    	pushl  0x5f10
     624:	e8 07 34 00 00       	call   3a30 <printf>
    exit();
     629:	e8 b4 32 00 00       	call   38e2 <exit>
    printf(stdout, "read failed\n");
     62e:	52                   	push   %edx
     62f:	52                   	push   %edx
     630:	68 df 4a 00 00       	push   $0x4adf
     635:	ff 35 10 5f 00 00    	pushl  0x5f10
     63b:	e8 f0 33 00 00       	call   3a30 <printf>
    exit();
     640:	e8 9d 32 00 00       	call   38e2 <exit>
    printf(stdout, "unlink small failed\n");
     645:	50                   	push   %eax
     646:	50                   	push   %eax
     647:	68 c6 47 00 00       	push   $0x47c6
     64c:	ff 35 10 5f 00 00    	pushl  0x5f10
     652:	e8 d9 33 00 00       	call   3a30 <printf>
    exit();
     657:	e8 86 32 00 00       	call   38e2 <exit>
    printf(stdout, "error: creat small failed!\n");
     65c:	50                   	push   %eax
     65d:	50                   	push   %eax
     65e:	68 42 47 00 00       	push   $0x4742
     663:	ff 35 10 5f 00 00    	pushl  0x5f10
     669:	e8 c2 33 00 00       	call   3a30 <printf>
    exit();
     66e:	e8 6f 32 00 00       	call   38e2 <exit>
     673:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000680 <writetest1>:
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	56                   	push   %esi
     684:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     685:	83 ec 08             	sub    $0x8,%esp
     688:	68 ef 47 00 00       	push   $0x47ef
     68d:	ff 35 10 5f 00 00    	pushl  0x5f10
     693:	e8 98 33 00 00       	call   3a30 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     698:	58                   	pop    %eax
     699:	5a                   	pop    %edx
     69a:	68 02 02 00 00       	push   $0x202
     69f:	68 69 48 00 00       	push   $0x4869
     6a4:	e8 79 32 00 00       	call   3922 <open>
  if(fd < 0){
     6a9:	83 c4 10             	add    $0x10,%esp
     6ac:	85 c0                	test   %eax,%eax
     6ae:	0f 88 61 01 00 00    	js     815 <writetest1+0x195>
     6b4:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     6b6:	31 db                	xor    %ebx,%ebx
     6b8:	90                   	nop
     6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(write(fd, buf, 512) != 512){
     6c0:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     6c3:	89 1d 00 87 00 00    	mov    %ebx,0x8700
    if(write(fd, buf, 512) != 512){
     6c9:	68 00 02 00 00       	push   $0x200
     6ce:	68 00 87 00 00       	push   $0x8700
     6d3:	56                   	push   %esi
     6d4:	e8 29 32 00 00       	call   3902 <write>
     6d9:	83 c4 10             	add    $0x10,%esp
     6dc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6e1:	0f 85 b3 00 00 00    	jne    79a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6e7:	83 c3 01             	add    $0x1,%ebx
     6ea:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6f0:	75 ce                	jne    6c0 <writetest1+0x40>
  close(fd);
     6f2:	83 ec 0c             	sub    $0xc,%esp
     6f5:	56                   	push   %esi
     6f6:	e8 0f 32 00 00       	call   390a <close>
  fd = open("big", O_RDONLY);
     6fb:	5b                   	pop    %ebx
     6fc:	5e                   	pop    %esi
     6fd:	6a 00                	push   $0x0
     6ff:	68 69 48 00 00       	push   $0x4869
     704:	e8 19 32 00 00       	call   3922 <open>
  if(fd < 0){
     709:	83 c4 10             	add    $0x10,%esp
     70c:	85 c0                	test   %eax,%eax
  fd = open("big", O_RDONLY);
     70e:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     710:	0f 88 e8 00 00 00    	js     7fe <writetest1+0x17e>
  n = 0;
     716:	31 db                	xor    %ebx,%ebx
     718:	eb 1d                	jmp    737 <writetest1+0xb7>
     71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     720:	3d 00 02 00 00       	cmp    $0x200,%eax
     725:	0f 85 9f 00 00 00    	jne    7ca <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     72b:	a1 00 87 00 00       	mov    0x8700,%eax
     730:	39 d8                	cmp    %ebx,%eax
     732:	75 7f                	jne    7b3 <writetest1+0x133>
    n++;
     734:	83 c3 01             	add    $0x1,%ebx
    i = read(fd, buf, 512);
     737:	83 ec 04             	sub    $0x4,%esp
     73a:	68 00 02 00 00       	push   $0x200
     73f:	68 00 87 00 00       	push   $0x8700
     744:	56                   	push   %esi
     745:	e8 b0 31 00 00       	call   38fa <read>
    if(i == 0){
     74a:	83 c4 10             	add    $0x10,%esp
     74d:	85 c0                	test   %eax,%eax
     74f:	75 cf                	jne    720 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     751:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     757:	0f 84 86 00 00 00    	je     7e3 <writetest1+0x163>
  close(fd);
     75d:	83 ec 0c             	sub    $0xc,%esp
     760:	56                   	push   %esi
     761:	e8 a4 31 00 00       	call   390a <close>
  if(unlink("big") < 0){
     766:	c7 04 24 69 48 00 00 	movl   $0x4869,(%esp)
     76d:	e8 c0 31 00 00       	call   3932 <unlink>
     772:	83 c4 10             	add    $0x10,%esp
     775:	85 c0                	test   %eax,%eax
     777:	0f 88 af 00 00 00    	js     82c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     77d:	83 ec 08             	sub    $0x8,%esp
     780:	68 90 48 00 00       	push   $0x4890
     785:	ff 35 10 5f 00 00    	pushl  0x5f10
     78b:	e8 a0 32 00 00       	call   3a30 <printf>
}
     790:	83 c4 10             	add    $0x10,%esp
     793:	8d 65 f8             	lea    -0x8(%ebp),%esp
     796:	5b                   	pop    %ebx
     797:	5e                   	pop    %esi
     798:	5d                   	pop    %ebp
     799:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     79a:	83 ec 04             	sub    $0x4,%esp
     79d:	53                   	push   %ebx
     79e:	68 19 48 00 00       	push   $0x4819
     7a3:	ff 35 10 5f 00 00    	pushl  0x5f10
     7a9:	e8 82 32 00 00       	call   3a30 <printf>
      exit();
     7ae:	e8 2f 31 00 00       	call   38e2 <exit>
      printf(stdout, "read content of block %d is %d\n",
     7b3:	50                   	push   %eax
     7b4:	53                   	push   %ebx
     7b5:	68 d8 3e 00 00       	push   $0x3ed8
     7ba:	ff 35 10 5f 00 00    	pushl  0x5f10
     7c0:	e8 6b 32 00 00       	call   3a30 <printf>
      exit();
     7c5:	e8 18 31 00 00       	call   38e2 <exit>
      printf(stdout, "read failed %d\n", i);
     7ca:	83 ec 04             	sub    $0x4,%esp
     7cd:	50                   	push   %eax
     7ce:	68 6d 48 00 00       	push   $0x486d
     7d3:	ff 35 10 5f 00 00    	pushl  0x5f10
     7d9:	e8 52 32 00 00       	call   3a30 <printf>
      exit();
     7de:	e8 ff 30 00 00       	call   38e2 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7e3:	52                   	push   %edx
     7e4:	68 8b 00 00 00       	push   $0x8b
     7e9:	68 50 48 00 00       	push   $0x4850
     7ee:	ff 35 10 5f 00 00    	pushl  0x5f10
     7f4:	e8 37 32 00 00       	call   3a30 <printf>
        exit();
     7f9:	e8 e4 30 00 00       	call   38e2 <exit>
    printf(stdout, "error: open big failed!\n");
     7fe:	51                   	push   %ecx
     7ff:	51                   	push   %ecx
     800:	68 37 48 00 00       	push   $0x4837
     805:	ff 35 10 5f 00 00    	pushl  0x5f10
     80b:	e8 20 32 00 00       	call   3a30 <printf>
    exit();
     810:	e8 cd 30 00 00       	call   38e2 <exit>
    printf(stdout, "error: creat big failed!\n");
     815:	50                   	push   %eax
     816:	50                   	push   %eax
     817:	68 ff 47 00 00       	push   $0x47ff
     81c:	ff 35 10 5f 00 00    	pushl  0x5f10
     822:	e8 09 32 00 00       	call   3a30 <printf>
    exit();
     827:	e8 b6 30 00 00       	call   38e2 <exit>
    printf(stdout, "unlink big failed\n");
     82c:	50                   	push   %eax
     82d:	50                   	push   %eax
     82e:	68 7d 48 00 00       	push   $0x487d
     833:	ff 35 10 5f 00 00    	pushl  0x5f10
     839:	e8 f2 31 00 00       	call   3a30 <printf>
    exit();
     83e:	e8 9f 30 00 00       	call   38e2 <exit>
     843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000850 <createtest>:
{
     850:	55                   	push   %ebp
     851:	89 e5                	mov    %esp,%ebp
     853:	53                   	push   %ebx
  name[2] = '\0';
     854:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     859:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     85c:	68 f8 3e 00 00       	push   $0x3ef8
     861:	ff 35 10 5f 00 00    	pushl  0x5f10
     867:	e8 c4 31 00 00       	call   3a30 <printf>
  name[0] = 'a';
     86c:	c6 05 00 a7 00 00 61 	movb   $0x61,0xa700
  name[2] = '\0';
     873:	c6 05 02 a7 00 00 00 	movb   $0x0,0xa702
     87a:	83 c4 10             	add    $0x10,%esp
     87d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     880:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     883:	88 1d 01 a7 00 00    	mov    %bl,0xa701
     889:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     88c:	68 02 02 00 00       	push   $0x202
     891:	68 00 a7 00 00       	push   $0xa700
     896:	e8 87 30 00 00       	call   3922 <open>
    close(fd);
     89b:	89 04 24             	mov    %eax,(%esp)
     89e:	e8 67 30 00 00       	call   390a <close>
  for(i = 0; i < 52; i++){
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	80 fb 64             	cmp    $0x64,%bl
     8a9:	75 d5                	jne    880 <createtest+0x30>
  name[0] = 'a';
     8ab:	c6 05 00 a7 00 00 61 	movb   $0x61,0xa700
  name[2] = '\0';
     8b2:	c6 05 02 a7 00 00 00 	movb   $0x0,0xa702
     8b9:	bb 30 00 00 00       	mov    $0x30,%ebx
     8be:	66 90                	xchg   %ax,%ax
    unlink(name);
     8c0:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     8c3:	88 1d 01 a7 00 00    	mov    %bl,0xa701
     8c9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8cc:	68 00 a7 00 00       	push   $0xa700
     8d1:	e8 5c 30 00 00       	call   3932 <unlink>
  for(i = 0; i < 52; i++){
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	80 fb 64             	cmp    $0x64,%bl
     8dc:	75 e2                	jne    8c0 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8de:	83 ec 08             	sub    $0x8,%esp
     8e1:	68 20 3f 00 00       	push   $0x3f20
     8e6:	ff 35 10 5f 00 00    	pushl  0x5f10
     8ec:	e8 3f 31 00 00       	call   3a30 <printf>
}
     8f1:	83 c4 10             	add    $0x10,%esp
     8f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8f7:	c9                   	leave  
     8f8:	c3                   	ret    
     8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000900 <dirtest>:
{
     900:	55                   	push   %ebp
     901:	89 e5                	mov    %esp,%ebp
     903:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     906:	68 9e 48 00 00       	push   $0x489e
     90b:	ff 35 10 5f 00 00    	pushl  0x5f10
     911:	e8 1a 31 00 00       	call   3a30 <printf>
  if(mkdir("dir0") < 0){
     916:	c7 04 24 aa 48 00 00 	movl   $0x48aa,(%esp)
     91d:	e8 28 30 00 00       	call   394a <mkdir>
     922:	83 c4 10             	add    $0x10,%esp
     925:	85 c0                	test   %eax,%eax
     927:	78 58                	js     981 <dirtest+0x81>
  if(chdir("dir0") < 0){
     929:	83 ec 0c             	sub    $0xc,%esp
     92c:	68 aa 48 00 00       	push   $0x48aa
     931:	e8 1c 30 00 00       	call   3952 <chdir>
     936:	83 c4 10             	add    $0x10,%esp
     939:	85 c0                	test   %eax,%eax
     93b:	0f 88 85 00 00 00    	js     9c6 <dirtest+0xc6>
  if(chdir("..") < 0){
     941:	83 ec 0c             	sub    $0xc,%esp
     944:	68 4f 4e 00 00       	push   $0x4e4f
     949:	e8 04 30 00 00       	call   3952 <chdir>
     94e:	83 c4 10             	add    $0x10,%esp
     951:	85 c0                	test   %eax,%eax
     953:	78 5a                	js     9af <dirtest+0xaf>
  if(unlink("dir0") < 0){
     955:	83 ec 0c             	sub    $0xc,%esp
     958:	68 aa 48 00 00       	push   $0x48aa
     95d:	e8 d0 2f 00 00       	call   3932 <unlink>
     962:	83 c4 10             	add    $0x10,%esp
     965:	85 c0                	test   %eax,%eax
     967:	78 2f                	js     998 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     969:	83 ec 08             	sub    $0x8,%esp
     96c:	68 e7 48 00 00       	push   $0x48e7
     971:	ff 35 10 5f 00 00    	pushl  0x5f10
     977:	e8 b4 30 00 00       	call   3a30 <printf>
}
     97c:	83 c4 10             	add    $0x10,%esp
     97f:	c9                   	leave  
     980:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     981:	50                   	push   %eax
     982:	50                   	push   %eax
     983:	68 da 45 00 00       	push   $0x45da
     988:	ff 35 10 5f 00 00    	pushl  0x5f10
     98e:	e8 9d 30 00 00       	call   3a30 <printf>
    exit();
     993:	e8 4a 2f 00 00       	call   38e2 <exit>
    printf(stdout, "unlink dir0 failed\n");
     998:	50                   	push   %eax
     999:	50                   	push   %eax
     99a:	68 d3 48 00 00       	push   $0x48d3
     99f:	ff 35 10 5f 00 00    	pushl  0x5f10
     9a5:	e8 86 30 00 00       	call   3a30 <printf>
    exit();
     9aa:	e8 33 2f 00 00       	call   38e2 <exit>
    printf(stdout, "chdir .. failed\n");
     9af:	52                   	push   %edx
     9b0:	52                   	push   %edx
     9b1:	68 c2 48 00 00       	push   $0x48c2
     9b6:	ff 35 10 5f 00 00    	pushl  0x5f10
     9bc:	e8 6f 30 00 00       	call   3a30 <printf>
    exit();
     9c1:	e8 1c 2f 00 00       	call   38e2 <exit>
    printf(stdout, "chdir dir0 failed\n");
     9c6:	51                   	push   %ecx
     9c7:	51                   	push   %ecx
     9c8:	68 af 48 00 00       	push   $0x48af
     9cd:	ff 35 10 5f 00 00    	pushl  0x5f10
     9d3:	e8 58 30 00 00       	call   3a30 <printf>
    exit();
     9d8:	e8 05 2f 00 00       	call   38e2 <exit>
     9dd:	8d 76 00             	lea    0x0(%esi),%esi

000009e0 <exectest>:
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9e6:	68 f6 48 00 00       	push   $0x48f6
     9eb:	ff 35 10 5f 00 00    	pushl  0x5f10
     9f1:	e8 3a 30 00 00       	call   3a30 <printf>
  if(exec("echo", echoargv) < 0){
     9f6:	5a                   	pop    %edx
     9f7:	59                   	pop    %ecx
     9f8:	68 14 5f 00 00       	push   $0x5f14
     9fd:	68 bf 46 00 00       	push   $0x46bf
     a02:	e8 13 2f 00 00       	call   391a <exec>
     a07:	83 c4 10             	add    $0x10,%esp
     a0a:	85 c0                	test   %eax,%eax
     a0c:	78 02                	js     a10 <exectest+0x30>
}
     a0e:	c9                   	leave  
     a0f:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     a10:	50                   	push   %eax
     a11:	50                   	push   %eax
     a12:	68 01 49 00 00       	push   $0x4901
     a17:	ff 35 10 5f 00 00    	pushl  0x5f10
     a1d:	e8 0e 30 00 00       	call   3a30 <printf>
    exit();
     a22:	e8 bb 2e 00 00       	call   38e2 <exit>
     a27:	89 f6                	mov    %esi,%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a30 <pipe1>:
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
     a35:	53                   	push   %ebx
  if(pipe(fds) != 0){
     a36:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a39:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     a3c:	50                   	push   %eax
     a3d:	e8 b0 2e 00 00       	call   38f2 <pipe>
     a42:	83 c4 10             	add    $0x10,%esp
     a45:	85 c0                	test   %eax,%eax
     a47:	0f 85 3e 01 00 00    	jne    b8b <pipe1+0x15b>
     a4d:	89 c3                	mov    %eax,%ebx
  pid = fork();
     a4f:	e8 86 2e 00 00       	call   38da <fork>
  if(pid == 0){
     a54:	83 f8 00             	cmp    $0x0,%eax
     a57:	0f 84 84 00 00 00    	je     ae1 <pipe1+0xb1>
  } else if(pid > 0){
     a5d:	0f 8e 3b 01 00 00    	jle    b9e <pipe1+0x16e>
    close(fds[1]);
     a63:	83 ec 0c             	sub    $0xc,%esp
     a66:	ff 75 e4             	pushl  -0x1c(%ebp)
    cc = 1;
     a69:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
     a6e:	e8 97 2e 00 00       	call   390a <close>
    while((n = read(fds[0], buf, cc)) > 0){
     a73:	83 c4 10             	add    $0x10,%esp
    total = 0;
     a76:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a7d:	83 ec 04             	sub    $0x4,%esp
     a80:	57                   	push   %edi
     a81:	68 00 87 00 00       	push   $0x8700
     a86:	ff 75 e0             	pushl  -0x20(%ebp)
     a89:	e8 6c 2e 00 00       	call   38fa <read>
     a8e:	83 c4 10             	add    $0x10,%esp
     a91:	85 c0                	test   %eax,%eax
     a93:	0f 8e ab 00 00 00    	jle    b44 <pipe1+0x114>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a99:	89 d9                	mov    %ebx,%ecx
     a9b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a9e:	f7 d9                	neg    %ecx
     aa0:	38 9c 0b 00 87 00 00 	cmp    %bl,0x8700(%ebx,%ecx,1)
     aa7:	8d 53 01             	lea    0x1(%ebx),%edx
     aaa:	75 1b                	jne    ac7 <pipe1+0x97>
      for(i = 0; i < n; i++){
     aac:	39 f2                	cmp    %esi,%edx
     aae:	89 d3                	mov    %edx,%ebx
     ab0:	75 ee                	jne    aa0 <pipe1+0x70>
      cc = cc * 2;
     ab2:	01 ff                	add    %edi,%edi
      total += n;
     ab4:	01 45 d4             	add    %eax,-0x2c(%ebp)
     ab7:	b8 00 20 00 00       	mov    $0x2000,%eax
     abc:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     ac2:	0f 4f f8             	cmovg  %eax,%edi
     ac5:	eb b6                	jmp    a7d <pipe1+0x4d>
          printf(1, "pipe1 oops 2\n");
     ac7:	83 ec 08             	sub    $0x8,%esp
     aca:	68 30 49 00 00       	push   $0x4930
     acf:	6a 01                	push   $0x1
     ad1:	e8 5a 2f 00 00       	call   3a30 <printf>
          return;
     ad6:	83 c4 10             	add    $0x10,%esp
}
     ad9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     adc:	5b                   	pop    %ebx
     add:	5e                   	pop    %esi
     ade:	5f                   	pop    %edi
     adf:	5d                   	pop    %ebp
     ae0:	c3                   	ret    
    close(fds[0]);
     ae1:	83 ec 0c             	sub    $0xc,%esp
     ae4:	ff 75 e0             	pushl  -0x20(%ebp)
     ae7:	31 db                	xor    %ebx,%ebx
     ae9:	be 09 04 00 00       	mov    $0x409,%esi
     aee:	e8 17 2e 00 00       	call   390a <close>
     af3:	83 c4 10             	add    $0x10,%esp
     af6:	89 d8                	mov    %ebx,%eax
     af8:	89 f2                	mov    %esi,%edx
     afa:	f7 d8                	neg    %eax
     afc:	29 da                	sub    %ebx,%edx
     afe:	66 90                	xchg   %ax,%ax
        buf[i] = seq++;
     b00:	88 84 03 00 87 00 00 	mov    %al,0x8700(%ebx,%eax,1)
     b07:	83 c0 01             	add    $0x1,%eax
      for(i = 0; i < 1033; i++)
     b0a:	39 d0                	cmp    %edx,%eax
     b0c:	75 f2                	jne    b00 <pipe1+0xd0>
      if(write(fds[1], buf, 1033) != 1033){
     b0e:	83 ec 04             	sub    $0x4,%esp
     b11:	68 09 04 00 00       	push   $0x409
     b16:	68 00 87 00 00       	push   $0x8700
     b1b:	ff 75 e4             	pushl  -0x1c(%ebp)
     b1e:	e8 df 2d 00 00       	call   3902 <write>
     b23:	83 c4 10             	add    $0x10,%esp
     b26:	3d 09 04 00 00       	cmp    $0x409,%eax
     b2b:	0f 85 80 00 00 00    	jne    bb1 <pipe1+0x181>
     b31:	81 eb 09 04 00 00    	sub    $0x409,%ebx
    for(n = 0; n < 5; n++){
     b37:	81 fb d3 eb ff ff    	cmp    $0xffffebd3,%ebx
     b3d:	75 b7                	jne    af6 <pipe1+0xc6>
    exit();
     b3f:	e8 9e 2d 00 00       	call   38e2 <exit>
    if(total != 5 * 1033){
     b44:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b4b:	75 29                	jne    b76 <pipe1+0x146>
    close(fds[0]);
     b4d:	83 ec 0c             	sub    $0xc,%esp
     b50:	ff 75 e0             	pushl  -0x20(%ebp)
     b53:	e8 b2 2d 00 00       	call   390a <close>
    wait();
     b58:	e8 8d 2d 00 00       	call   38ea <wait>
  printf(1, "pipe1 ok\n");
     b5d:	5a                   	pop    %edx
     b5e:	59                   	pop    %ecx
     b5f:	68 55 49 00 00       	push   $0x4955
     b64:	6a 01                	push   $0x1
     b66:	e8 c5 2e 00 00       	call   3a30 <printf>
     b6b:	83 c4 10             	add    $0x10,%esp
}
     b6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b71:	5b                   	pop    %ebx
     b72:	5e                   	pop    %esi
     b73:	5f                   	pop    %edi
     b74:	5d                   	pop    %ebp
     b75:	c3                   	ret    
      printf(1, "pipe1 oops 3 total %d\n", total);
     b76:	53                   	push   %ebx
     b77:	ff 75 d4             	pushl  -0x2c(%ebp)
     b7a:	68 3e 49 00 00       	push   $0x493e
     b7f:	6a 01                	push   $0x1
     b81:	e8 aa 2e 00 00       	call   3a30 <printf>
      exit();
     b86:	e8 57 2d 00 00       	call   38e2 <exit>
    printf(1, "pipe() failed\n");
     b8b:	57                   	push   %edi
     b8c:	57                   	push   %edi
     b8d:	68 13 49 00 00       	push   $0x4913
     b92:	6a 01                	push   $0x1
     b94:	e8 97 2e 00 00       	call   3a30 <printf>
    exit();
     b99:	e8 44 2d 00 00       	call   38e2 <exit>
    printf(1, "fork() failed\n");
     b9e:	50                   	push   %eax
     b9f:	50                   	push   %eax
     ba0:	68 5f 49 00 00       	push   $0x495f
     ba5:	6a 01                	push   $0x1
     ba7:	e8 84 2e 00 00       	call   3a30 <printf>
    exit();
     bac:	e8 31 2d 00 00       	call   38e2 <exit>
        printf(1, "pipe1 oops 1\n");
     bb1:	56                   	push   %esi
     bb2:	56                   	push   %esi
     bb3:	68 22 49 00 00       	push   $0x4922
     bb8:	6a 01                	push   $0x1
     bba:	e8 71 2e 00 00       	call   3a30 <printf>
        exit();
     bbf:	e8 1e 2d 00 00       	call   38e2 <exit>
     bc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000bd0 <preempt>:
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	56                   	push   %esi
     bd5:	53                   	push   %ebx
     bd6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     bd9:	68 6e 49 00 00       	push   $0x496e
     bde:	6a 01                	push   $0x1
     be0:	e8 4b 2e 00 00       	call   3a30 <printf>
  pid1 = fork();
     be5:	e8 f0 2c 00 00       	call   38da <fork>
  if(pid1 == 0)
     bea:	83 c4 10             	add    $0x10,%esp
     bed:	85 c0                	test   %eax,%eax
     bef:	75 02                	jne    bf3 <preempt+0x23>
     bf1:	eb fe                	jmp    bf1 <preempt+0x21>
     bf3:	89 c7                	mov    %eax,%edi
  pid2 = fork();
     bf5:	e8 e0 2c 00 00       	call   38da <fork>
  if(pid2 == 0)
     bfa:	85 c0                	test   %eax,%eax
  pid2 = fork();
     bfc:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     bfe:	75 02                	jne    c02 <preempt+0x32>
     c00:	eb fe                	jmp    c00 <preempt+0x30>
  pipe(pfds);
     c02:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c05:	83 ec 0c             	sub    $0xc,%esp
     c08:	50                   	push   %eax
     c09:	e8 e4 2c 00 00       	call   38f2 <pipe>
  pid3 = fork();
     c0e:	e8 c7 2c 00 00       	call   38da <fork>
  if(pid3 == 0){
     c13:	83 c4 10             	add    $0x10,%esp
     c16:	85 c0                	test   %eax,%eax
  pid3 = fork();
     c18:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c1a:	75 46                	jne    c62 <preempt+0x92>
    close(pfds[0]);
     c1c:	83 ec 0c             	sub    $0xc,%esp
     c1f:	ff 75 e0             	pushl  -0x20(%ebp)
     c22:	e8 e3 2c 00 00       	call   390a <close>
    if(write(pfds[1], "x", 1) != 1)
     c27:	83 c4 0c             	add    $0xc,%esp
     c2a:	6a 01                	push   $0x1
     c2c:	68 33 4f 00 00       	push   $0x4f33
     c31:	ff 75 e4             	pushl  -0x1c(%ebp)
     c34:	e8 c9 2c 00 00       	call   3902 <write>
     c39:	83 c4 10             	add    $0x10,%esp
     c3c:	83 e8 01             	sub    $0x1,%eax
     c3f:	74 11                	je     c52 <preempt+0x82>
      printf(1, "preempt write error");
     c41:	50                   	push   %eax
     c42:	50                   	push   %eax
     c43:	68 78 49 00 00       	push   $0x4978
     c48:	6a 01                	push   $0x1
     c4a:	e8 e1 2d 00 00       	call   3a30 <printf>
     c4f:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c52:	83 ec 0c             	sub    $0xc,%esp
     c55:	ff 75 e4             	pushl  -0x1c(%ebp)
     c58:	e8 ad 2c 00 00       	call   390a <close>
     c5d:	83 c4 10             	add    $0x10,%esp
     c60:	eb fe                	jmp    c60 <preempt+0x90>
  close(pfds[1]);
     c62:	83 ec 0c             	sub    $0xc,%esp
     c65:	ff 75 e4             	pushl  -0x1c(%ebp)
     c68:	e8 9d 2c 00 00       	call   390a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c6d:	83 c4 0c             	add    $0xc,%esp
     c70:	68 00 20 00 00       	push   $0x2000
     c75:	68 00 87 00 00       	push   $0x8700
     c7a:	ff 75 e0             	pushl  -0x20(%ebp)
     c7d:	e8 78 2c 00 00       	call   38fa <read>
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	83 e8 01             	sub    $0x1,%eax
     c88:	74 19                	je     ca3 <preempt+0xd3>
    printf(1, "preempt read error");
     c8a:	50                   	push   %eax
     c8b:	50                   	push   %eax
     c8c:	68 8c 49 00 00       	push   $0x498c
     c91:	6a 01                	push   $0x1
     c93:	e8 98 2d 00 00       	call   3a30 <printf>
    return;
     c98:	83 c4 10             	add    $0x10,%esp
}
     c9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c9e:	5b                   	pop    %ebx
     c9f:	5e                   	pop    %esi
     ca0:	5f                   	pop    %edi
     ca1:	5d                   	pop    %ebp
     ca2:	c3                   	ret    
  close(pfds[0]);
     ca3:	83 ec 0c             	sub    $0xc,%esp
     ca6:	ff 75 e0             	pushl  -0x20(%ebp)
     ca9:	e8 5c 2c 00 00       	call   390a <close>
  printf(1, "kill... ");
     cae:	58                   	pop    %eax
     caf:	5a                   	pop    %edx
     cb0:	68 9f 49 00 00       	push   $0x499f
     cb5:	6a 01                	push   $0x1
     cb7:	e8 74 2d 00 00       	call   3a30 <printf>
  kill(pid1);
     cbc:	89 3c 24             	mov    %edi,(%esp)
     cbf:	e8 4e 2c 00 00       	call   3912 <kill>
  kill(pid2);
     cc4:	89 34 24             	mov    %esi,(%esp)
     cc7:	e8 46 2c 00 00       	call   3912 <kill>
  kill(pid3);
     ccc:	89 1c 24             	mov    %ebx,(%esp)
     ccf:	e8 3e 2c 00 00       	call   3912 <kill>
  printf(1, "wait... ");
     cd4:	59                   	pop    %ecx
     cd5:	5b                   	pop    %ebx
     cd6:	68 a8 49 00 00       	push   $0x49a8
     cdb:	6a 01                	push   $0x1
     cdd:	e8 4e 2d 00 00       	call   3a30 <printf>
  wait();
     ce2:	e8 03 2c 00 00       	call   38ea <wait>
  wait();
     ce7:	e8 fe 2b 00 00       	call   38ea <wait>
  wait();
     cec:	e8 f9 2b 00 00       	call   38ea <wait>
  printf(1, "preempt ok\n");
     cf1:	5e                   	pop    %esi
     cf2:	5f                   	pop    %edi
     cf3:	68 b1 49 00 00       	push   $0x49b1
     cf8:	6a 01                	push   $0x1
     cfa:	e8 31 2d 00 00       	call   3a30 <printf>
     cff:	83 c4 10             	add    $0x10,%esp
     d02:	eb 97                	jmp    c9b <preempt+0xcb>
     d04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000d10 <exitwait>:
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	be 64 00 00 00       	mov    $0x64,%esi
     d19:	53                   	push   %ebx
     d1a:	eb 14                	jmp    d30 <exitwait+0x20>
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     d20:	74 6f                	je     d91 <exitwait+0x81>
      if(wait() != pid){
     d22:	e8 c3 2b 00 00       	call   38ea <wait>
     d27:	39 d8                	cmp    %ebx,%eax
     d29:	75 2d                	jne    d58 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     d2b:	83 ee 01             	sub    $0x1,%esi
     d2e:	74 48                	je     d78 <exitwait+0x68>
    pid = fork();
     d30:	e8 a5 2b 00 00       	call   38da <fork>
    if(pid < 0){
     d35:	85 c0                	test   %eax,%eax
    pid = fork();
     d37:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d39:	79 e5                	jns    d20 <exitwait+0x10>
      printf(1, "fork failed\n");
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 1b 55 00 00       	push   $0x551b
     d43:	6a 01                	push   $0x1
     d45:	e8 e6 2c 00 00       	call   3a30 <printf>
      return;
     d4a:	83 c4 10             	add    $0x10,%esp
}
     d4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d50:	5b                   	pop    %ebx
     d51:	5e                   	pop    %esi
     d52:	5d                   	pop    %ebp
     d53:	c3                   	ret    
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 bd 49 00 00       	push   $0x49bd
     d60:	6a 01                	push   $0x1
     d62:	e8 c9 2c 00 00       	call   3a30 <printf>
        return;
     d67:	83 c4 10             	add    $0x10,%esp
}
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
     d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "exitwait ok\n");
     d78:	83 ec 08             	sub    $0x8,%esp
     d7b:	68 cd 49 00 00       	push   $0x49cd
     d80:	6a 01                	push   $0x1
     d82:	e8 a9 2c 00 00       	call   3a30 <printf>
     d87:	83 c4 10             	add    $0x10,%esp
}
     d8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d8d:	5b                   	pop    %ebx
     d8e:	5e                   	pop    %esi
     d8f:	5d                   	pop    %ebp
     d90:	c3                   	ret    
      exit();
     d91:	e8 4c 2b 00 00       	call   38e2 <exit>
     d96:	8d 76 00             	lea    0x0(%esi),%esi
     d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000da0 <mem>:
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	57                   	push   %edi
     da4:	56                   	push   %esi
     da5:	53                   	push   %ebx
     da6:	31 db                	xor    %ebx,%ebx
     da8:	83 ec 14             	sub    $0x14,%esp
  printf(1, "mem test\n");
     dab:	68 da 49 00 00       	push   $0x49da
     db0:	6a 01                	push   $0x1
     db2:	e8 79 2c 00 00       	call   3a30 <printf>
  ppid = getpid();
     db7:	e8 a6 2b 00 00       	call   3962 <getpid>
     dbc:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     dbe:	e8 17 2b 00 00       	call   38da <fork>
     dc3:	83 c4 10             	add    $0x10,%esp
     dc6:	85 c0                	test   %eax,%eax
     dc8:	74 0a                	je     dd4 <mem+0x34>
     dca:	e9 89 00 00 00       	jmp    e58 <mem+0xb8>
     dcf:	90                   	nop
      *(char**)m2 = m1;
     dd0:	89 18                	mov    %ebx,(%eax)
     dd2:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
     dd4:	83 ec 0c             	sub    $0xc,%esp
     dd7:	68 11 27 00 00       	push   $0x2711
     ddc:	e8 af 2e 00 00       	call   3c90 <malloc>
     de1:	83 c4 10             	add    $0x10,%esp
     de4:	85 c0                	test   %eax,%eax
     de6:	75 e8                	jne    dd0 <mem+0x30>
    while(m1){
     de8:	85 db                	test   %ebx,%ebx
     dea:	74 18                	je     e04 <mem+0x64>
     dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     df0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     df2:	83 ec 0c             	sub    $0xc,%esp
     df5:	53                   	push   %ebx
     df6:	89 fb                	mov    %edi,%ebx
     df8:	e8 03 2e 00 00       	call   3c00 <free>
    while(m1){
     dfd:	83 c4 10             	add    $0x10,%esp
     e00:	85 db                	test   %ebx,%ebx
     e02:	75 ec                	jne    df0 <mem+0x50>
    m1 = malloc(1024*20);
     e04:	83 ec 0c             	sub    $0xc,%esp
     e07:	68 00 50 00 00       	push   $0x5000
     e0c:	e8 7f 2e 00 00       	call   3c90 <malloc>
    if(m1 == 0){
     e11:	83 c4 10             	add    $0x10,%esp
     e14:	85 c0                	test   %eax,%eax
     e16:	74 20                	je     e38 <mem+0x98>
    free(m1);
     e18:	83 ec 0c             	sub    $0xc,%esp
     e1b:	50                   	push   %eax
     e1c:	e8 df 2d 00 00       	call   3c00 <free>
    printf(1, "mem ok\n");
     e21:	58                   	pop    %eax
     e22:	5a                   	pop    %edx
     e23:	68 fe 49 00 00       	push   $0x49fe
     e28:	6a 01                	push   $0x1
     e2a:	e8 01 2c 00 00       	call   3a30 <printf>
    exit();
     e2f:	e8 ae 2a 00 00       	call   38e2 <exit>
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e38:	83 ec 08             	sub    $0x8,%esp
     e3b:	68 e4 49 00 00       	push   $0x49e4
     e40:	6a 01                	push   $0x1
     e42:	e8 e9 2b 00 00       	call   3a30 <printf>
      kill(ppid);
     e47:	89 34 24             	mov    %esi,(%esp)
     e4a:	e8 c3 2a 00 00       	call   3912 <kill>
      exit();
     e4f:	e8 8e 2a 00 00       	call   38e2 <exit>
     e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e58:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e5b:	5b                   	pop    %ebx
     e5c:	5e                   	pop    %esi
     e5d:	5f                   	pop    %edi
     e5e:	5d                   	pop    %ebp
    wait();
     e5f:	e9 86 2a 00 00       	jmp    38ea <wait>
     e64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e70 <sharedfd>:
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
     e74:	56                   	push   %esi
     e75:	53                   	push   %ebx
     e76:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     e79:	68 06 4a 00 00       	push   $0x4a06
     e7e:	6a 01                	push   $0x1
     e80:	e8 ab 2b 00 00       	call   3a30 <printf>
  unlink("sharedfd");
     e85:	c7 04 24 15 4a 00 00 	movl   $0x4a15,(%esp)
     e8c:	e8 a1 2a 00 00       	call   3932 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e91:	59                   	pop    %ecx
     e92:	5b                   	pop    %ebx
     e93:	68 02 02 00 00       	push   $0x202
     e98:	68 15 4a 00 00       	push   $0x4a15
     e9d:	e8 80 2a 00 00       	call   3922 <open>
  if(fd < 0){
     ea2:	83 c4 10             	add    $0x10,%esp
     ea5:	85 c0                	test   %eax,%eax
     ea7:	0f 88 33 01 00 00    	js     fe0 <sharedfd+0x170>
     ead:	89 c6                	mov    %eax,%esi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eaf:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     eb4:	e8 21 2a 00 00       	call   38da <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eb9:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     ebc:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ebe:	19 c0                	sbb    %eax,%eax
     ec0:	83 ec 04             	sub    $0x4,%esp
     ec3:	83 e0 f3             	and    $0xfffffff3,%eax
     ec6:	6a 0a                	push   $0xa
     ec8:	83 c0 70             	add    $0x70,%eax
     ecb:	50                   	push   %eax
     ecc:	8d 45 de             	lea    -0x22(%ebp),%eax
     ecf:	50                   	push   %eax
     ed0:	e8 6b 28 00 00       	call   3740 <memset>
     ed5:	83 c4 10             	add    $0x10,%esp
     ed8:	eb 0b                	jmp    ee5 <sharedfd+0x75>
     eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
     ee0:	83 eb 01             	sub    $0x1,%ebx
     ee3:	74 29                	je     f0e <sharedfd+0x9e>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ee5:	8d 45 de             	lea    -0x22(%ebp),%eax
     ee8:	83 ec 04             	sub    $0x4,%esp
     eeb:	6a 0a                	push   $0xa
     eed:	50                   	push   %eax
     eee:	56                   	push   %esi
     eef:	e8 0e 2a 00 00       	call   3902 <write>
     ef4:	83 c4 10             	add    $0x10,%esp
     ef7:	83 f8 0a             	cmp    $0xa,%eax
     efa:	74 e4                	je     ee0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     efc:	83 ec 08             	sub    $0x8,%esp
     eff:	68 74 3f 00 00       	push   $0x3f74
     f04:	6a 01                	push   $0x1
     f06:	e8 25 2b 00 00       	call   3a30 <printf>
      break;
     f0b:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     f0e:	85 ff                	test   %edi,%edi
     f10:	0f 84 fe 00 00 00    	je     1014 <sharedfd+0x1a4>
    wait();
     f16:	e8 cf 29 00 00       	call   38ea <wait>
  close(fd);
     f1b:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     f1e:	31 db                	xor    %ebx,%ebx
     f20:	31 ff                	xor    %edi,%edi
  close(fd);
     f22:	56                   	push   %esi
     f23:	8d 75 e8             	lea    -0x18(%ebp),%esi
     f26:	e8 df 29 00 00       	call   390a <close>
  fd = open("sharedfd", 0);
     f2b:	58                   	pop    %eax
     f2c:	5a                   	pop    %edx
     f2d:	6a 00                	push   $0x0
     f2f:	68 15 4a 00 00       	push   $0x4a15
     f34:	e8 e9 29 00 00       	call   3922 <open>
  if(fd < 0){
     f39:	83 c4 10             	add    $0x10,%esp
     f3c:	85 c0                	test   %eax,%eax
  fd = open("sharedfd", 0);
     f3e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
     f41:	0f 88 b3 00 00 00    	js     ffa <sharedfd+0x18a>
     f47:	89 f8                	mov    %edi,%eax
     f49:	89 df                	mov    %ebx,%edi
     f4b:	89 c3                	mov    %eax,%ebx
     f4d:	8d 76 00             	lea    0x0(%esi),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f50:	8d 45 de             	lea    -0x22(%ebp),%eax
     f53:	83 ec 04             	sub    $0x4,%esp
     f56:	6a 0a                	push   $0xa
     f58:	50                   	push   %eax
     f59:	ff 75 d4             	pushl  -0x2c(%ebp)
     f5c:	e8 99 29 00 00       	call   38fa <read>
     f61:	83 c4 10             	add    $0x10,%esp
     f64:	85 c0                	test   %eax,%eax
     f66:	7e 28                	jle    f90 <sharedfd+0x120>
     f68:	8d 45 de             	lea    -0x22(%ebp),%eax
     f6b:	eb 15                	jmp    f82 <sharedfd+0x112>
     f6d:	8d 76 00             	lea    0x0(%esi),%esi
        np++;
     f70:	80 fa 70             	cmp    $0x70,%dl
     f73:	0f 94 c2             	sete   %dl
     f76:	0f b6 d2             	movzbl %dl,%edx
     f79:	01 d7                	add    %edx,%edi
     f7b:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < sizeof(buf); i++){
     f7e:	39 f0                	cmp    %esi,%eax
     f80:	74 ce                	je     f50 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f82:	0f b6 10             	movzbl (%eax),%edx
     f85:	80 fa 63             	cmp    $0x63,%dl
     f88:	75 e6                	jne    f70 <sharedfd+0x100>
        nc++;
     f8a:	83 c3 01             	add    $0x1,%ebx
     f8d:	eb ec                	jmp    f7b <sharedfd+0x10b>
     f8f:	90                   	nop
  close(fd);
     f90:	83 ec 0c             	sub    $0xc,%esp
     f93:	89 d8                	mov    %ebx,%eax
     f95:	ff 75 d4             	pushl  -0x2c(%ebp)
     f98:	89 fb                	mov    %edi,%ebx
     f9a:	89 c7                	mov    %eax,%edi
     f9c:	e8 69 29 00 00       	call   390a <close>
  unlink("sharedfd");
     fa1:	c7 04 24 15 4a 00 00 	movl   $0x4a15,(%esp)
     fa8:	e8 85 29 00 00       	call   3932 <unlink>
  if(nc == 10000 && np == 10000){
     fad:	83 c4 10             	add    $0x10,%esp
     fb0:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     fb6:	75 61                	jne    1019 <sharedfd+0x1a9>
     fb8:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fbe:	75 59                	jne    1019 <sharedfd+0x1a9>
    printf(1, "sharedfd ok\n");
     fc0:	83 ec 08             	sub    $0x8,%esp
     fc3:	68 1e 4a 00 00       	push   $0x4a1e
     fc8:	6a 01                	push   $0x1
     fca:	e8 61 2a 00 00       	call   3a30 <printf>
     fcf:	83 c4 10             	add    $0x10,%esp
}
     fd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fd5:	5b                   	pop    %ebx
     fd6:	5e                   	pop    %esi
     fd7:	5f                   	pop    %edi
     fd8:	5d                   	pop    %ebp
     fd9:	c3                   	ret    
     fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "fstests: cannot open sharedfd for writing");
     fe0:	83 ec 08             	sub    $0x8,%esp
     fe3:	68 48 3f 00 00       	push   $0x3f48
     fe8:	6a 01                	push   $0x1
     fea:	e8 41 2a 00 00       	call   3a30 <printf>
    return;
     fef:	83 c4 10             	add    $0x10,%esp
}
     ff2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff5:	5b                   	pop    %ebx
     ff6:	5e                   	pop    %esi
     ff7:	5f                   	pop    %edi
     ff8:	5d                   	pop    %ebp
     ff9:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     ffa:	83 ec 08             	sub    $0x8,%esp
     ffd:	68 94 3f 00 00       	push   $0x3f94
    1002:	6a 01                	push   $0x1
    1004:	e8 27 2a 00 00       	call   3a30 <printf>
    return;
    1009:	83 c4 10             	add    $0x10,%esp
}
    100c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    100f:	5b                   	pop    %ebx
    1010:	5e                   	pop    %esi
    1011:	5f                   	pop    %edi
    1012:	5d                   	pop    %ebp
    1013:	c3                   	ret    
    exit();
    1014:	e8 c9 28 00 00       	call   38e2 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1019:	53                   	push   %ebx
    101a:	57                   	push   %edi
    101b:	68 2b 4a 00 00       	push   $0x4a2b
    1020:	6a 01                	push   $0x1
    1022:	e8 09 2a 00 00       	call   3a30 <printf>
    exit();
    1027:	e8 b6 28 00 00       	call   38e2 <exit>
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001030 <fourfiles>:
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	56                   	push   %esi
    1035:	53                   	push   %ebx
  printf(1, "fourfiles test\n");
    1036:	be 40 4a 00 00       	mov    $0x4a40,%esi
  for(pi = 0; pi < 4; pi++){
    103b:	31 db                	xor    %ebx,%ebx
{
    103d:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    1040:	c7 45 d8 40 4a 00 00 	movl   $0x4a40,-0x28(%ebp)
    1047:	c7 45 dc 89 4b 00 00 	movl   $0x4b89,-0x24(%ebp)
  printf(1, "fourfiles test\n");
    104e:	68 46 4a 00 00       	push   $0x4a46
    1053:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    1055:	c7 45 e0 8d 4b 00 00 	movl   $0x4b8d,-0x20(%ebp)
    105c:	c7 45 e4 43 4a 00 00 	movl   $0x4a43,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1063:	e8 c8 29 00 00       	call   3a30 <printf>
    1068:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    106b:	83 ec 0c             	sub    $0xc,%esp
    106e:	56                   	push   %esi
    106f:	e8 be 28 00 00       	call   3932 <unlink>
    pid = fork();
    1074:	e8 61 28 00 00       	call   38da <fork>
    if(pid < 0){
    1079:	83 c4 10             	add    $0x10,%esp
    107c:	85 c0                	test   %eax,%eax
    107e:	0f 88 68 01 00 00    	js     11ec <fourfiles+0x1bc>
    if(pid == 0){
    1084:	0f 84 df 00 00 00    	je     1169 <fourfiles+0x139>
  for(pi = 0; pi < 4; pi++){
    108a:	83 c3 01             	add    $0x1,%ebx
    108d:	83 fb 04             	cmp    $0x4,%ebx
    1090:	74 06                	je     1098 <fourfiles+0x68>
    1092:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1096:	eb d3                	jmp    106b <fourfiles+0x3b>
    wait();
    1098:	e8 4d 28 00 00       	call   38ea <wait>
  for(i = 0; i < 2; i++){
    109d:	31 ff                	xor    %edi,%edi
    wait();
    109f:	e8 46 28 00 00       	call   38ea <wait>
    10a4:	e8 41 28 00 00       	call   38ea <wait>
    10a9:	e8 3c 28 00 00       	call   38ea <wait>
    10ae:	c7 45 d0 40 4a 00 00 	movl   $0x4a40,-0x30(%ebp)
    fd = open(fname, 0);
    10b5:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    10b8:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    10ba:	6a 00                	push   $0x0
    10bc:	ff 75 d0             	pushl  -0x30(%ebp)
    10bf:	e8 5e 28 00 00       	call   3922 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10c4:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    10c7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10d0:	83 ec 04             	sub    $0x4,%esp
    10d3:	68 00 20 00 00       	push   $0x2000
    10d8:	68 00 87 00 00       	push   $0x8700
    10dd:	ff 75 d4             	pushl  -0x2c(%ebp)
    10e0:	e8 15 28 00 00       	call   38fa <read>
    10e5:	83 c4 10             	add    $0x10,%esp
    10e8:	85 c0                	test   %eax,%eax
    10ea:	7e 26                	jle    1112 <fourfiles+0xe2>
      for(j = 0; j < n; j++){
    10ec:	31 d2                	xor    %edx,%edx
    10ee:	66 90                	xchg   %ax,%ax
        if(buf[j] != '0'+i){
    10f0:	0f be b2 00 87 00 00 	movsbl 0x8700(%edx),%esi
    10f7:	83 ff 01             	cmp    $0x1,%edi
    10fa:	19 c9                	sbb    %ecx,%ecx
    10fc:	83 c1 31             	add    $0x31,%ecx
    10ff:	39 ce                	cmp    %ecx,%esi
    1101:	0f 85 be 00 00 00    	jne    11c5 <fourfiles+0x195>
      for(j = 0; j < n; j++){
    1107:	83 c2 01             	add    $0x1,%edx
    110a:	39 d0                	cmp    %edx,%eax
    110c:	75 e2                	jne    10f0 <fourfiles+0xc0>
      total += n;
    110e:	01 c3                	add    %eax,%ebx
    1110:	eb be                	jmp    10d0 <fourfiles+0xa0>
    close(fd);
    1112:	83 ec 0c             	sub    $0xc,%esp
    1115:	ff 75 d4             	pushl  -0x2c(%ebp)
    1118:	e8 ed 27 00 00       	call   390a <close>
    if(total != 12*500){
    111d:	83 c4 10             	add    $0x10,%esp
    1120:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1126:	0f 85 d3 00 00 00    	jne    11ff <fourfiles+0x1cf>
    unlink(fname);
    112c:	83 ec 0c             	sub    $0xc,%esp
    112f:	ff 75 d0             	pushl  -0x30(%ebp)
    1132:	e8 fb 27 00 00       	call   3932 <unlink>
  for(i = 0; i < 2; i++){
    1137:	83 c4 10             	add    $0x10,%esp
    113a:	83 ff 01             	cmp    $0x1,%edi
    113d:	75 1a                	jne    1159 <fourfiles+0x129>
  printf(1, "fourfiles ok\n");
    113f:	83 ec 08             	sub    $0x8,%esp
    1142:	68 84 4a 00 00       	push   $0x4a84
    1147:	6a 01                	push   $0x1
    1149:	e8 e2 28 00 00       	call   3a30 <printf>
}
    114e:	83 c4 10             	add    $0x10,%esp
    1151:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1154:	5b                   	pop    %ebx
    1155:	5e                   	pop    %esi
    1156:	5f                   	pop    %edi
    1157:	5d                   	pop    %ebp
    1158:	c3                   	ret    
    1159:	8b 45 dc             	mov    -0x24(%ebp),%eax
    115c:	bf 01 00 00 00       	mov    $0x1,%edi
    1161:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1164:	e9 4c ff ff ff       	jmp    10b5 <fourfiles+0x85>
      fd = open(fname, O_CREATE | O_RDWR);
    1169:	83 ec 08             	sub    $0x8,%esp
    116c:	68 02 02 00 00       	push   $0x202
    1171:	56                   	push   %esi
    1172:	e8 ab 27 00 00       	call   3922 <open>
      if(fd < 0){
    1177:	83 c4 10             	add    $0x10,%esp
    117a:	85 c0                	test   %eax,%eax
      fd = open(fname, O_CREATE | O_RDWR);
    117c:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    117e:	78 59                	js     11d9 <fourfiles+0x1a9>
      memset(buf, '0'+pi, 512);
    1180:	83 ec 04             	sub    $0x4,%esp
    1183:	83 c3 30             	add    $0x30,%ebx
    1186:	68 00 02 00 00       	push   $0x200
    118b:	53                   	push   %ebx
    118c:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1191:	68 00 87 00 00       	push   $0x8700
    1196:	e8 a5 25 00 00       	call   3740 <memset>
    119b:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    119e:	83 ec 04             	sub    $0x4,%esp
    11a1:	68 f4 01 00 00       	push   $0x1f4
    11a6:	68 00 87 00 00       	push   $0x8700
    11ab:	56                   	push   %esi
    11ac:	e8 51 27 00 00       	call   3902 <write>
    11b1:	83 c4 10             	add    $0x10,%esp
    11b4:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11b9:	75 57                	jne    1212 <fourfiles+0x1e2>
      for(i = 0; i < 12; i++){
    11bb:	83 eb 01             	sub    $0x1,%ebx
    11be:	75 de                	jne    119e <fourfiles+0x16e>
      exit();
    11c0:	e8 1d 27 00 00       	call   38e2 <exit>
          printf(1, "wrong char\n");
    11c5:	83 ec 08             	sub    $0x8,%esp
    11c8:	68 67 4a 00 00       	push   $0x4a67
    11cd:	6a 01                	push   $0x1
    11cf:	e8 5c 28 00 00       	call   3a30 <printf>
          exit();
    11d4:	e8 09 27 00 00       	call   38e2 <exit>
        printf(1, "create failed\n");
    11d9:	51                   	push   %ecx
    11da:	51                   	push   %ecx
    11db:	68 e1 4c 00 00       	push   $0x4ce1
    11e0:	6a 01                	push   $0x1
    11e2:	e8 49 28 00 00       	call   3a30 <printf>
        exit();
    11e7:	e8 f6 26 00 00       	call   38e2 <exit>
      printf(1, "fork failed\n");
    11ec:	53                   	push   %ebx
    11ed:	53                   	push   %ebx
    11ee:	68 1b 55 00 00       	push   $0x551b
    11f3:	6a 01                	push   $0x1
    11f5:	e8 36 28 00 00       	call   3a30 <printf>
      exit();
    11fa:	e8 e3 26 00 00       	call   38e2 <exit>
      printf(1, "wrong length %d\n", total);
    11ff:	50                   	push   %eax
    1200:	53                   	push   %ebx
    1201:	68 73 4a 00 00       	push   $0x4a73
    1206:	6a 01                	push   $0x1
    1208:	e8 23 28 00 00       	call   3a30 <printf>
      exit();
    120d:	e8 d0 26 00 00       	call   38e2 <exit>
          printf(1, "write failed %d\n", n);
    1212:	52                   	push   %edx
    1213:	50                   	push   %eax
    1214:	68 56 4a 00 00       	push   $0x4a56
    1219:	6a 01                	push   $0x1
    121b:	e8 10 28 00 00       	call   3a30 <printf>
          exit();
    1220:	e8 bd 26 00 00       	call   38e2 <exit>
    1225:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001230 <createdelete>:
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
    1235:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1236:	31 db                	xor    %ebx,%ebx
{
    1238:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    123b:	68 92 4a 00 00       	push   $0x4a92
    1240:	6a 01                	push   $0x1
    1242:	e8 e9 27 00 00       	call   3a30 <printf>
    1247:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    124a:	e8 8b 26 00 00       	call   38da <fork>
    if(pid < 0){
    124f:	85 c0                	test   %eax,%eax
    1251:	0f 88 be 01 00 00    	js     1415 <createdelete+0x1e5>
    if(pid == 0){
    1257:	0f 84 0b 01 00 00    	je     1368 <createdelete+0x138>
  for(pi = 0; pi < 4; pi++){
    125d:	83 c3 01             	add    $0x1,%ebx
    1260:	83 fb 04             	cmp    $0x4,%ebx
    1263:	75 e5                	jne    124a <createdelete+0x1a>
    1265:	8d 7d c8             	lea    -0x38(%ebp),%edi
  name[0] = name[1] = name[2] = 0;
    1268:	be ff ff ff ff       	mov    $0xffffffff,%esi
    wait();
    126d:	e8 78 26 00 00       	call   38ea <wait>
    1272:	e8 73 26 00 00       	call   38ea <wait>
    1277:	e8 6e 26 00 00       	call   38ea <wait>
    127c:	e8 69 26 00 00       	call   38ea <wait>
  name[0] = name[1] = name[2] = 0;
    1281:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1285:	8d 76 00             	lea    0x0(%esi),%esi
    1288:	8d 46 31             	lea    0x31(%esi),%eax
    128b:	88 45 c7             	mov    %al,-0x39(%ebp)
    128e:	8d 46 01             	lea    0x1(%esi),%eax
    1291:	83 f8 09             	cmp    $0x9,%eax
    1294:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1297:	0f 9f c3             	setg   %bl
    129a:	85 c0                	test   %eax,%eax
    129c:	0f 94 c0             	sete   %al
    129f:	09 c3                	or     %eax,%ebx
    12a1:	88 5d c6             	mov    %bl,-0x3a(%ebp)
      name[2] = '\0';
    12a4:	bb 70 00 00 00       	mov    $0x70,%ebx
      name[1] = '0' + i;
    12a9:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    12ad:	83 ec 08             	sub    $0x8,%esp
      name[0] = 'p' + pi;
    12b0:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    12b3:	6a 00                	push   $0x0
    12b5:	57                   	push   %edi
      name[1] = '0' + i;
    12b6:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    12b9:	e8 64 26 00 00       	call   3922 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    12be:	83 c4 10             	add    $0x10,%esp
    12c1:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12c5:	0f 84 85 00 00 00    	je     1350 <createdelete+0x120>
    12cb:	85 c0                	test   %eax,%eax
    12cd:	0f 88 1a 01 00 00    	js     13ed <createdelete+0x1bd>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12d3:	83 fe 08             	cmp    $0x8,%esi
    12d6:	0f 86 54 01 00 00    	jbe    1430 <createdelete+0x200>
        close(fd);
    12dc:	83 ec 0c             	sub    $0xc,%esp
    12df:	50                   	push   %eax
    12e0:	e8 25 26 00 00       	call   390a <close>
    12e5:	83 c4 10             	add    $0x10,%esp
    12e8:	83 c3 01             	add    $0x1,%ebx
    for(pi = 0; pi < 4; pi++){
    12eb:	80 fb 74             	cmp    $0x74,%bl
    12ee:	75 b9                	jne    12a9 <createdelete+0x79>
    12f0:	8b 75 c0             	mov    -0x40(%ebp),%esi
  for(i = 0; i < N; i++){
    12f3:	83 fe 13             	cmp    $0x13,%esi
    12f6:	75 90                	jne    1288 <createdelete+0x58>
    12f8:	be 70 00 00 00       	mov    $0x70,%esi
    12fd:	8d 76 00             	lea    0x0(%esi),%esi
    1300:	8d 46 c0             	lea    -0x40(%esi),%eax
  name[0] = name[1] = name[2] = 0;
    1303:	bb 04 00 00 00       	mov    $0x4,%ebx
    1308:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[0] = 'p' + i;
    130b:	89 f0                	mov    %esi,%eax
      unlink(name);
    130d:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    1310:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1313:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    1317:	57                   	push   %edi
      name[1] = '0' + i;
    1318:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    131b:	e8 12 26 00 00       	call   3932 <unlink>
    for(pi = 0; pi < 4; pi++){
    1320:	83 c4 10             	add    $0x10,%esp
    1323:	83 eb 01             	sub    $0x1,%ebx
    1326:	75 e3                	jne    130b <createdelete+0xdb>
    1328:	83 c6 01             	add    $0x1,%esi
  for(i = 0; i < N; i++){
    132b:	89 f0                	mov    %esi,%eax
    132d:	3c 84                	cmp    $0x84,%al
    132f:	75 cf                	jne    1300 <createdelete+0xd0>
  printf(1, "createdelete ok\n");
    1331:	83 ec 08             	sub    $0x8,%esp
    1334:	68 a5 4a 00 00       	push   $0x4aa5
    1339:	6a 01                	push   $0x1
    133b:	e8 f0 26 00 00       	call   3a30 <printf>
}
    1340:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1343:	5b                   	pop    %ebx
    1344:	5e                   	pop    %esi
    1345:	5f                   	pop    %edi
    1346:	5d                   	pop    %ebp
    1347:	c3                   	ret    
    1348:	90                   	nop
    1349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1350:	83 fe 08             	cmp    $0x8,%esi
    1353:	0f 86 cf 00 00 00    	jbe    1428 <createdelete+0x1f8>
      if(fd >= 0)
    1359:	85 c0                	test   %eax,%eax
    135b:	78 8b                	js     12e8 <createdelete+0xb8>
    135d:	e9 7a ff ff ff       	jmp    12dc <createdelete+0xac>
    1362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[0] = 'p' + pi;
    1368:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    136b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    136f:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    1372:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1375:	31 db                	xor    %ebx,%ebx
    1377:	eb 0f                	jmp    1388 <createdelete+0x158>
    1379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1380:	83 fb 13             	cmp    $0x13,%ebx
    1383:	74 63                	je     13e8 <createdelete+0x1b8>
    1385:	83 c3 01             	add    $0x1,%ebx
        fd = open(name, O_CREATE | O_RDWR);
    1388:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    138b:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    138e:	68 02 02 00 00       	push   $0x202
    1393:	57                   	push   %edi
        name[1] = '0' + i;
    1394:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1397:	e8 86 25 00 00       	call   3922 <open>
        if(fd < 0){
    139c:	83 c4 10             	add    $0x10,%esp
    139f:	85 c0                	test   %eax,%eax
    13a1:	78 5f                	js     1402 <createdelete+0x1d2>
        close(fd);
    13a3:	83 ec 0c             	sub    $0xc,%esp
    13a6:	50                   	push   %eax
    13a7:	e8 5e 25 00 00       	call   390a <close>
        if(i > 0 && (i % 2 ) == 0){
    13ac:	83 c4 10             	add    $0x10,%esp
    13af:	85 db                	test   %ebx,%ebx
    13b1:	74 d2                	je     1385 <createdelete+0x155>
    13b3:	f6 c3 01             	test   $0x1,%bl
    13b6:	75 c8                	jne    1380 <createdelete+0x150>
          if(unlink(name) < 0){
    13b8:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    13bb:	89 d8                	mov    %ebx,%eax
    13bd:	d1 f8                	sar    %eax
          if(unlink(name) < 0){
    13bf:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    13c0:	83 c0 30             	add    $0x30,%eax
    13c3:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13c6:	e8 67 25 00 00       	call   3932 <unlink>
    13cb:	83 c4 10             	add    $0x10,%esp
    13ce:	85 c0                	test   %eax,%eax
    13d0:	79 ae                	jns    1380 <createdelete+0x150>
            printf(1, "unlink failed\n");
    13d2:	52                   	push   %edx
    13d3:	52                   	push   %edx
    13d4:	68 93 46 00 00       	push   $0x4693
    13d9:	6a 01                	push   $0x1
    13db:	e8 50 26 00 00       	call   3a30 <printf>
            exit();
    13e0:	e8 fd 24 00 00       	call   38e2 <exit>
    13e5:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    13e8:	e8 f5 24 00 00       	call   38e2 <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    13ed:	83 ec 04             	sub    $0x4,%esp
    13f0:	57                   	push   %edi
    13f1:	68 c0 3f 00 00       	push   $0x3fc0
    13f6:	6a 01                	push   $0x1
    13f8:	e8 33 26 00 00       	call   3a30 <printf>
        exit();
    13fd:	e8 e0 24 00 00       	call   38e2 <exit>
          printf(1, "create failed\n");
    1402:	51                   	push   %ecx
    1403:	51                   	push   %ecx
    1404:	68 e1 4c 00 00       	push   $0x4ce1
    1409:	6a 01                	push   $0x1
    140b:	e8 20 26 00 00       	call   3a30 <printf>
          exit();
    1410:	e8 cd 24 00 00       	call   38e2 <exit>
      printf(1, "fork failed\n");
    1415:	53                   	push   %ebx
    1416:	53                   	push   %ebx
    1417:	68 1b 55 00 00       	push   $0x551b
    141c:	6a 01                	push   $0x1
    141e:	e8 0d 26 00 00       	call   3a30 <printf>
      exit();
    1423:	e8 ba 24 00 00       	call   38e2 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1428:	85 c0                	test   %eax,%eax
    142a:	0f 88 b8 fe ff ff    	js     12e8 <createdelete+0xb8>
        printf(1, "oops createdelete %s did exist\n", name);
    1430:	50                   	push   %eax
    1431:	57                   	push   %edi
    1432:	68 e4 3f 00 00       	push   $0x3fe4
    1437:	6a 01                	push   $0x1
    1439:	e8 f2 25 00 00       	call   3a30 <printf>
        exit();
    143e:	e8 9f 24 00 00       	call   38e2 <exit>
    1443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001450 <unlinkread>:
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	56                   	push   %esi
    1454:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1455:	83 ec 08             	sub    $0x8,%esp
    1458:	68 b6 4a 00 00       	push   $0x4ab6
    145d:	6a 01                	push   $0x1
    145f:	e8 cc 25 00 00       	call   3a30 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1464:	5b                   	pop    %ebx
    1465:	5e                   	pop    %esi
    1466:	68 02 02 00 00       	push   $0x202
    146b:	68 c7 4a 00 00       	push   $0x4ac7
    1470:	e8 ad 24 00 00       	call   3922 <open>
  if(fd < 0){
    1475:	83 c4 10             	add    $0x10,%esp
    1478:	85 c0                	test   %eax,%eax
    147a:	0f 88 e6 00 00 00    	js     1566 <unlinkread+0x116>
  write(fd, "hello", 5);
    1480:	83 ec 04             	sub    $0x4,%esp
    1483:	89 c3                	mov    %eax,%ebx
    1485:	6a 05                	push   $0x5
    1487:	68 ec 4a 00 00       	push   $0x4aec
    148c:	50                   	push   %eax
    148d:	e8 70 24 00 00       	call   3902 <write>
  close(fd);
    1492:	89 1c 24             	mov    %ebx,(%esp)
    1495:	e8 70 24 00 00       	call   390a <close>
  fd = open("unlinkread", O_RDWR);
    149a:	58                   	pop    %eax
    149b:	5a                   	pop    %edx
    149c:	6a 02                	push   $0x2
    149e:	68 c7 4a 00 00       	push   $0x4ac7
    14a3:	e8 7a 24 00 00       	call   3922 <open>
  if(fd < 0){
    14a8:	83 c4 10             	add    $0x10,%esp
    14ab:	85 c0                	test   %eax,%eax
  fd = open("unlinkread", O_RDWR);
    14ad:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    14af:	0f 88 10 01 00 00    	js     15c5 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    14b5:	83 ec 0c             	sub    $0xc,%esp
    14b8:	68 c7 4a 00 00       	push   $0x4ac7
    14bd:	e8 70 24 00 00       	call   3932 <unlink>
    14c2:	83 c4 10             	add    $0x10,%esp
    14c5:	85 c0                	test   %eax,%eax
    14c7:	0f 85 e5 00 00 00    	jne    15b2 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14cd:	83 ec 08             	sub    $0x8,%esp
    14d0:	68 02 02 00 00       	push   $0x202
    14d5:	68 c7 4a 00 00       	push   $0x4ac7
    14da:	e8 43 24 00 00       	call   3922 <open>
  write(fd1, "yyy", 3);
    14df:	83 c4 0c             	add    $0xc,%esp
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14e2:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14e4:	6a 03                	push   $0x3
    14e6:	68 24 4b 00 00       	push   $0x4b24
    14eb:	50                   	push   %eax
    14ec:	e8 11 24 00 00       	call   3902 <write>
  close(fd1);
    14f1:	89 34 24             	mov    %esi,(%esp)
    14f4:	e8 11 24 00 00       	call   390a <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    14f9:	83 c4 0c             	add    $0xc,%esp
    14fc:	68 00 20 00 00       	push   $0x2000
    1501:	68 00 87 00 00       	push   $0x8700
    1506:	53                   	push   %ebx
    1507:	e8 ee 23 00 00       	call   38fa <read>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	83 f8 05             	cmp    $0x5,%eax
    1512:	0f 85 87 00 00 00    	jne    159f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    1518:	80 3d 00 87 00 00 68 	cmpb   $0x68,0x8700
    151f:	75 6b                	jne    158c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1521:	83 ec 04             	sub    $0x4,%esp
    1524:	6a 0a                	push   $0xa
    1526:	68 00 87 00 00       	push   $0x8700
    152b:	53                   	push   %ebx
    152c:	e8 d1 23 00 00       	call   3902 <write>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	83 f8 0a             	cmp    $0xa,%eax
    1537:	75 40                	jne    1579 <unlinkread+0x129>
  close(fd);
    1539:	83 ec 0c             	sub    $0xc,%esp
    153c:	53                   	push   %ebx
    153d:	e8 c8 23 00 00       	call   390a <close>
  unlink("unlinkread");
    1542:	c7 04 24 c7 4a 00 00 	movl   $0x4ac7,(%esp)
    1549:	e8 e4 23 00 00       	call   3932 <unlink>
  printf(1, "unlinkread ok\n");
    154e:	58                   	pop    %eax
    154f:	5a                   	pop    %edx
    1550:	68 6f 4b 00 00       	push   $0x4b6f
    1555:	6a 01                	push   $0x1
    1557:	e8 d4 24 00 00       	call   3a30 <printf>
}
    155c:	83 c4 10             	add    $0x10,%esp
    155f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1562:	5b                   	pop    %ebx
    1563:	5e                   	pop    %esi
    1564:	5d                   	pop    %ebp
    1565:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1566:	51                   	push   %ecx
    1567:	51                   	push   %ecx
    1568:	68 d2 4a 00 00       	push   $0x4ad2
    156d:	6a 01                	push   $0x1
    156f:	e8 bc 24 00 00       	call   3a30 <printf>
    exit();
    1574:	e8 69 23 00 00       	call   38e2 <exit>
    printf(1, "unlinkread write failed\n");
    1579:	51                   	push   %ecx
    157a:	51                   	push   %ecx
    157b:	68 56 4b 00 00       	push   $0x4b56
    1580:	6a 01                	push   $0x1
    1582:	e8 a9 24 00 00       	call   3a30 <printf>
    exit();
    1587:	e8 56 23 00 00       	call   38e2 <exit>
    printf(1, "unlinkread wrong data\n");
    158c:	53                   	push   %ebx
    158d:	53                   	push   %ebx
    158e:	68 3f 4b 00 00       	push   $0x4b3f
    1593:	6a 01                	push   $0x1
    1595:	e8 96 24 00 00       	call   3a30 <printf>
    exit();
    159a:	e8 43 23 00 00       	call   38e2 <exit>
    printf(1, "unlinkread read failed");
    159f:	56                   	push   %esi
    15a0:	56                   	push   %esi
    15a1:	68 28 4b 00 00       	push   $0x4b28
    15a6:	6a 01                	push   $0x1
    15a8:	e8 83 24 00 00       	call   3a30 <printf>
    exit();
    15ad:	e8 30 23 00 00       	call   38e2 <exit>
    printf(1, "unlink unlinkread failed\n");
    15b2:	50                   	push   %eax
    15b3:	50                   	push   %eax
    15b4:	68 0a 4b 00 00       	push   $0x4b0a
    15b9:	6a 01                	push   $0x1
    15bb:	e8 70 24 00 00       	call   3a30 <printf>
    exit();
    15c0:	e8 1d 23 00 00       	call   38e2 <exit>
    printf(1, "open unlinkread failed\n");
    15c5:	50                   	push   %eax
    15c6:	50                   	push   %eax
    15c7:	68 f2 4a 00 00       	push   $0x4af2
    15cc:	6a 01                	push   $0x1
    15ce:	e8 5d 24 00 00       	call   3a30 <printf>
    exit();
    15d3:	e8 0a 23 00 00       	call   38e2 <exit>
    15d8:	90                   	nop
    15d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015e0 <linktest>:
{
    15e0:	55                   	push   %ebp
    15e1:	89 e5                	mov    %esp,%ebp
    15e3:	53                   	push   %ebx
    15e4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    15e7:	68 7e 4b 00 00       	push   $0x4b7e
    15ec:	6a 01                	push   $0x1
    15ee:	e8 3d 24 00 00       	call   3a30 <printf>
  unlink("lf1");
    15f3:	c7 04 24 88 4b 00 00 	movl   $0x4b88,(%esp)
    15fa:	e8 33 23 00 00       	call   3932 <unlink>
  unlink("lf2");
    15ff:	c7 04 24 8c 4b 00 00 	movl   $0x4b8c,(%esp)
    1606:	e8 27 23 00 00       	call   3932 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    160b:	58                   	pop    %eax
    160c:	5a                   	pop    %edx
    160d:	68 02 02 00 00       	push   $0x202
    1612:	68 88 4b 00 00       	push   $0x4b88
    1617:	e8 06 23 00 00       	call   3922 <open>
  if(fd < 0){
    161c:	83 c4 10             	add    $0x10,%esp
    161f:	85 c0                	test   %eax,%eax
    1621:	0f 88 1e 01 00 00    	js     1745 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    1627:	83 ec 04             	sub    $0x4,%esp
    162a:	89 c3                	mov    %eax,%ebx
    162c:	6a 05                	push   $0x5
    162e:	68 ec 4a 00 00       	push   $0x4aec
    1633:	50                   	push   %eax
    1634:	e8 c9 22 00 00       	call   3902 <write>
    1639:	83 c4 10             	add    $0x10,%esp
    163c:	83 f8 05             	cmp    $0x5,%eax
    163f:	0f 85 98 01 00 00    	jne    17dd <linktest+0x1fd>
  close(fd);
    1645:	83 ec 0c             	sub    $0xc,%esp
    1648:	53                   	push   %ebx
    1649:	e8 bc 22 00 00       	call   390a <close>
  if(link("lf1", "lf2") < 0){
    164e:	5b                   	pop    %ebx
    164f:	58                   	pop    %eax
    1650:	68 8c 4b 00 00       	push   $0x4b8c
    1655:	68 88 4b 00 00       	push   $0x4b88
    165a:	e8 e3 22 00 00       	call   3942 <link>
    165f:	83 c4 10             	add    $0x10,%esp
    1662:	85 c0                	test   %eax,%eax
    1664:	0f 88 60 01 00 00    	js     17ca <linktest+0x1ea>
  unlink("lf1");
    166a:	83 ec 0c             	sub    $0xc,%esp
    166d:	68 88 4b 00 00       	push   $0x4b88
    1672:	e8 bb 22 00 00       	call   3932 <unlink>
  if(open("lf1", 0) >= 0){
    1677:	58                   	pop    %eax
    1678:	5a                   	pop    %edx
    1679:	6a 00                	push   $0x0
    167b:	68 88 4b 00 00       	push   $0x4b88
    1680:	e8 9d 22 00 00       	call   3922 <open>
    1685:	83 c4 10             	add    $0x10,%esp
    1688:	85 c0                	test   %eax,%eax
    168a:	0f 89 27 01 00 00    	jns    17b7 <linktest+0x1d7>
  fd = open("lf2", 0);
    1690:	83 ec 08             	sub    $0x8,%esp
    1693:	6a 00                	push   $0x0
    1695:	68 8c 4b 00 00       	push   $0x4b8c
    169a:	e8 83 22 00 00       	call   3922 <open>
  if(fd < 0){
    169f:	83 c4 10             	add    $0x10,%esp
    16a2:	85 c0                	test   %eax,%eax
  fd = open("lf2", 0);
    16a4:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    16a6:	0f 88 f8 00 00 00    	js     17a4 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    16ac:	83 ec 04             	sub    $0x4,%esp
    16af:	68 00 20 00 00       	push   $0x2000
    16b4:	68 00 87 00 00       	push   $0x8700
    16b9:	50                   	push   %eax
    16ba:	e8 3b 22 00 00       	call   38fa <read>
    16bf:	83 c4 10             	add    $0x10,%esp
    16c2:	83 f8 05             	cmp    $0x5,%eax
    16c5:	0f 85 c6 00 00 00    	jne    1791 <linktest+0x1b1>
  close(fd);
    16cb:	83 ec 0c             	sub    $0xc,%esp
    16ce:	53                   	push   %ebx
    16cf:	e8 36 22 00 00       	call   390a <close>
  if(link("lf2", "lf2") >= 0){
    16d4:	58                   	pop    %eax
    16d5:	5a                   	pop    %edx
    16d6:	68 8c 4b 00 00       	push   $0x4b8c
    16db:	68 8c 4b 00 00       	push   $0x4b8c
    16e0:	e8 5d 22 00 00       	call   3942 <link>
    16e5:	83 c4 10             	add    $0x10,%esp
    16e8:	85 c0                	test   %eax,%eax
    16ea:	0f 89 8e 00 00 00    	jns    177e <linktest+0x19e>
  unlink("lf2");
    16f0:	83 ec 0c             	sub    $0xc,%esp
    16f3:	68 8c 4b 00 00       	push   $0x4b8c
    16f8:	e8 35 22 00 00       	call   3932 <unlink>
  if(link("lf2", "lf1") >= 0){
    16fd:	59                   	pop    %ecx
    16fe:	5b                   	pop    %ebx
    16ff:	68 88 4b 00 00       	push   $0x4b88
    1704:	68 8c 4b 00 00       	push   $0x4b8c
    1709:	e8 34 22 00 00       	call   3942 <link>
    170e:	83 c4 10             	add    $0x10,%esp
    1711:	85 c0                	test   %eax,%eax
    1713:	79 56                	jns    176b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    1715:	83 ec 08             	sub    $0x8,%esp
    1718:	68 88 4b 00 00       	push   $0x4b88
    171d:	68 50 4e 00 00       	push   $0x4e50
    1722:	e8 1b 22 00 00       	call   3942 <link>
    1727:	83 c4 10             	add    $0x10,%esp
    172a:	85 c0                	test   %eax,%eax
    172c:	79 2a                	jns    1758 <linktest+0x178>
  printf(1, "linktest ok\n");
    172e:	83 ec 08             	sub    $0x8,%esp
    1731:	68 26 4c 00 00       	push   $0x4c26
    1736:	6a 01                	push   $0x1
    1738:	e8 f3 22 00 00       	call   3a30 <printf>
}
    173d:	83 c4 10             	add    $0x10,%esp
    1740:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1743:	c9                   	leave  
    1744:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1745:	50                   	push   %eax
    1746:	50                   	push   %eax
    1747:	68 90 4b 00 00       	push   $0x4b90
    174c:	6a 01                	push   $0x1
    174e:	e8 dd 22 00 00       	call   3a30 <printf>
    exit();
    1753:	e8 8a 21 00 00       	call   38e2 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1758:	50                   	push   %eax
    1759:	50                   	push   %eax
    175a:	68 0a 4c 00 00       	push   $0x4c0a
    175f:	6a 01                	push   $0x1
    1761:	e8 ca 22 00 00       	call   3a30 <printf>
    exit();
    1766:	e8 77 21 00 00       	call   38e2 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    176b:	52                   	push   %edx
    176c:	52                   	push   %edx
    176d:	68 2c 40 00 00       	push   $0x402c
    1772:	6a 01                	push   $0x1
    1774:	e8 b7 22 00 00       	call   3a30 <printf>
    exit();
    1779:	e8 64 21 00 00       	call   38e2 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    177e:	50                   	push   %eax
    177f:	50                   	push   %eax
    1780:	68 ec 4b 00 00       	push   $0x4bec
    1785:	6a 01                	push   $0x1
    1787:	e8 a4 22 00 00       	call   3a30 <printf>
    exit();
    178c:	e8 51 21 00 00       	call   38e2 <exit>
    printf(1, "read lf2 failed\n");
    1791:	51                   	push   %ecx
    1792:	51                   	push   %ecx
    1793:	68 db 4b 00 00       	push   $0x4bdb
    1798:	6a 01                	push   $0x1
    179a:	e8 91 22 00 00       	call   3a30 <printf>
    exit();
    179f:	e8 3e 21 00 00       	call   38e2 <exit>
    printf(1, "open lf2 failed\n");
    17a4:	53                   	push   %ebx
    17a5:	53                   	push   %ebx
    17a6:	68 ca 4b 00 00       	push   $0x4bca
    17ab:	6a 01                	push   $0x1
    17ad:	e8 7e 22 00 00       	call   3a30 <printf>
    exit();
    17b2:	e8 2b 21 00 00       	call   38e2 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    17b7:	50                   	push   %eax
    17b8:	50                   	push   %eax
    17b9:	68 04 40 00 00       	push   $0x4004
    17be:	6a 01                	push   $0x1
    17c0:	e8 6b 22 00 00       	call   3a30 <printf>
    exit();
    17c5:	e8 18 21 00 00       	call   38e2 <exit>
    printf(1, "link lf1 lf2 failed\n");
    17ca:	51                   	push   %ecx
    17cb:	51                   	push   %ecx
    17cc:	68 b5 4b 00 00       	push   $0x4bb5
    17d1:	6a 01                	push   $0x1
    17d3:	e8 58 22 00 00       	call   3a30 <printf>
    exit();
    17d8:	e8 05 21 00 00       	call   38e2 <exit>
    printf(1, "write lf1 failed\n");
    17dd:	50                   	push   %eax
    17de:	50                   	push   %eax
    17df:	68 a3 4b 00 00       	push   $0x4ba3
    17e4:	6a 01                	push   $0x1
    17e6:	e8 45 22 00 00       	call   3a30 <printf>
    exit();
    17eb:	e8 f2 20 00 00       	call   38e2 <exit>

000017f0 <concreate>:
{
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	57                   	push   %edi
    17f4:	56                   	push   %esi
    17f5:	53                   	push   %ebx
  for(i = 0; i < 40; i++){
    17f6:	31 f6                	xor    %esi,%esi
    17f8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    if(pid && (i % 3) == 1){
    17fb:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
{
    1800:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    1803:	68 33 4c 00 00       	push   $0x4c33
    1808:	6a 01                	push   $0x1
    180a:	e8 21 22 00 00       	call   3a30 <printf>
  file[0] = 'C';
    180f:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1813:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1817:	83 c4 10             	add    $0x10,%esp
    181a:	eb 4c                	jmp    1868 <concreate+0x78>
    181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid && (i % 3) == 1){
    1820:	89 f0                	mov    %esi,%eax
    1822:	89 f1                	mov    %esi,%ecx
    1824:	f7 e7                	mul    %edi
    1826:	d1 ea                	shr    %edx
    1828:	8d 04 52             	lea    (%edx,%edx,2),%eax
    182b:	29 c1                	sub    %eax,%ecx
    182d:	83 f9 01             	cmp    $0x1,%ecx
    1830:	0f 84 ba 00 00 00    	je     18f0 <concreate+0x100>
      fd = open(file, O_CREATE | O_RDWR);
    1836:	83 ec 08             	sub    $0x8,%esp
    1839:	68 02 02 00 00       	push   $0x202
    183e:	53                   	push   %ebx
    183f:	e8 de 20 00 00       	call   3922 <open>
      if(fd < 0){
    1844:	83 c4 10             	add    $0x10,%esp
    1847:	85 c0                	test   %eax,%eax
    1849:	78 67                	js     18b2 <concreate+0xc2>
      close(fd);
    184b:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    184e:	83 c6 01             	add    $0x1,%esi
      close(fd);
    1851:	50                   	push   %eax
    1852:	e8 b3 20 00 00       	call   390a <close>
    1857:	83 c4 10             	add    $0x10,%esp
      wait();
    185a:	e8 8b 20 00 00       	call   38ea <wait>
  for(i = 0; i < 40; i++){
    185f:	83 fe 28             	cmp    $0x28,%esi
    1862:	0f 84 aa 00 00 00    	je     1912 <concreate+0x122>
    unlink(file);
    1868:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    186b:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    186e:	53                   	push   %ebx
    file[1] = '0' + i;
    186f:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    1872:	e8 bb 20 00 00       	call   3932 <unlink>
    pid = fork();
    1877:	e8 5e 20 00 00       	call   38da <fork>
    if(pid && (i % 3) == 1){
    187c:	83 c4 10             	add    $0x10,%esp
    187f:	85 c0                	test   %eax,%eax
    1881:	75 9d                	jne    1820 <concreate+0x30>
    } else if(pid == 0 && (i % 5) == 1){
    1883:	89 f0                	mov    %esi,%eax
    1885:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    188a:	f7 e2                	mul    %edx
    188c:	c1 ea 02             	shr    $0x2,%edx
    188f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1892:	29 c6                	sub    %eax,%esi
    1894:	83 fe 01             	cmp    $0x1,%esi
    1897:	74 37                	je     18d0 <concreate+0xe0>
      fd = open(file, O_CREATE | O_RDWR);
    1899:	83 ec 08             	sub    $0x8,%esp
    189c:	68 02 02 00 00       	push   $0x202
    18a1:	53                   	push   %ebx
    18a2:	e8 7b 20 00 00       	call   3922 <open>
      if(fd < 0){
    18a7:	83 c4 10             	add    $0x10,%esp
    18aa:	85 c0                	test   %eax,%eax
    18ac:	0f 89 28 02 00 00    	jns    1ada <concreate+0x2ea>
        printf(1, "concreate create %s failed\n", file);
    18b2:	83 ec 04             	sub    $0x4,%esp
    18b5:	53                   	push   %ebx
    18b6:	68 46 4c 00 00       	push   $0x4c46
    18bb:	6a 01                	push   $0x1
    18bd:	e8 6e 21 00 00       	call   3a30 <printf>
        exit();
    18c2:	e8 1b 20 00 00       	call   38e2 <exit>
    18c7:	89 f6                	mov    %esi,%esi
    18c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    18d0:	83 ec 08             	sub    $0x8,%esp
    18d3:	53                   	push   %ebx
    18d4:	68 43 4c 00 00       	push   $0x4c43
    18d9:	e8 64 20 00 00       	call   3942 <link>
    18de:	83 c4 10             	add    $0x10,%esp
      exit();
    18e1:	e8 fc 1f 00 00       	call   38e2 <exit>
    18e6:	8d 76 00             	lea    0x0(%esi),%esi
    18e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    18f0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    18f3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    18f6:	53                   	push   %ebx
    18f7:	68 43 4c 00 00       	push   $0x4c43
    18fc:	e8 41 20 00 00       	call   3942 <link>
    1901:	83 c4 10             	add    $0x10,%esp
      wait();
    1904:	e8 e1 1f 00 00       	call   38ea <wait>
  for(i = 0; i < 40; i++){
    1909:	83 fe 28             	cmp    $0x28,%esi
    190c:	0f 85 56 ff ff ff    	jne    1868 <concreate+0x78>
  memset(fa, 0, sizeof(fa));
    1912:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1915:	83 ec 04             	sub    $0x4,%esp
    1918:	6a 28                	push   $0x28
    191a:	6a 00                	push   $0x0
    191c:	50                   	push   %eax
    191d:	e8 1e 1e 00 00       	call   3740 <memset>
  fd = open(".", 0);
    1922:	5f                   	pop    %edi
    1923:	58                   	pop    %eax
    1924:	6a 00                	push   $0x0
    1926:	68 50 4e 00 00       	push   $0x4e50
    192b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    192e:	e8 ef 1f 00 00       	call   3922 <open>
  while(read(fd, &de, sizeof(de)) > 0){
    1933:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1936:	89 c6                	mov    %eax,%esi
  n = 0;
    1938:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    193f:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1940:	83 ec 04             	sub    $0x4,%esp
    1943:	6a 10                	push   $0x10
    1945:	57                   	push   %edi
    1946:	56                   	push   %esi
    1947:	e8 ae 1f 00 00       	call   38fa <read>
    194c:	83 c4 10             	add    $0x10,%esp
    194f:	85 c0                	test   %eax,%eax
    1951:	7e 3d                	jle    1990 <concreate+0x1a0>
    if(de.inum == 0)
    1953:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1958:	74 e6                	je     1940 <concreate+0x150>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    195a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    195e:	75 e0                	jne    1940 <concreate+0x150>
    1960:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1964:	75 da                	jne    1940 <concreate+0x150>
      i = de.name[1] - '0';
    1966:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    196a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    196d:	83 f8 27             	cmp    $0x27,%eax
    1970:	0f 87 4e 01 00 00    	ja     1ac4 <concreate+0x2d4>
      if(fa[i]){
    1976:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    197b:	0f 85 2d 01 00 00    	jne    1aae <concreate+0x2be>
      fa[i] = 1;
    1981:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1986:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    198a:	eb b4                	jmp    1940 <concreate+0x150>
    198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1990:	83 ec 0c             	sub    $0xc,%esp
    1993:	56                   	push   %esi
    1994:	e8 71 1f 00 00       	call   390a <close>
  if(n != 40){
    1999:	83 c4 10             	add    $0x10,%esp
    199c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    19a0:	0f 85 f5 00 00 00    	jne    1a9b <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    19a6:	31 f6                	xor    %esi,%esi
    19a8:	eb 48                	jmp    19f2 <concreate+0x202>
    19aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    19b0:	85 ff                	test   %edi,%edi
    19b2:	74 05                	je     19b9 <concreate+0x1c9>
    19b4:	83 fa 01             	cmp    $0x1,%edx
    19b7:	74 64                	je     1a1d <concreate+0x22d>
      unlink(file);
    19b9:	83 ec 0c             	sub    $0xc,%esp
    19bc:	53                   	push   %ebx
    19bd:	e8 70 1f 00 00       	call   3932 <unlink>
      unlink(file);
    19c2:	89 1c 24             	mov    %ebx,(%esp)
    19c5:	e8 68 1f 00 00       	call   3932 <unlink>
      unlink(file);
    19ca:	89 1c 24             	mov    %ebx,(%esp)
    19cd:	e8 60 1f 00 00       	call   3932 <unlink>
      unlink(file);
    19d2:	89 1c 24             	mov    %ebx,(%esp)
    19d5:	e8 58 1f 00 00       	call   3932 <unlink>
    19da:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    19dd:	85 ff                	test   %edi,%edi
    19df:	0f 84 fc fe ff ff    	je     18e1 <concreate+0xf1>
  for(i = 0; i < 40; i++){
    19e5:	83 c6 01             	add    $0x1,%esi
      wait();
    19e8:	e8 fd 1e 00 00       	call   38ea <wait>
  for(i = 0; i < 40; i++){
    19ed:	83 fe 28             	cmp    $0x28,%esi
    19f0:	74 7e                	je     1a70 <concreate+0x280>
    file[1] = '0' + i;
    19f2:	8d 46 30             	lea    0x30(%esi),%eax
    19f5:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19f8:	e8 dd 1e 00 00       	call   38da <fork>
    if(pid < 0){
    19fd:	85 c0                	test   %eax,%eax
    pid = fork();
    19ff:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1a01:	0f 88 80 00 00 00    	js     1a87 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    1a07:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1a0c:	f7 e6                	mul    %esi
    1a0e:	d1 ea                	shr    %edx
    1a10:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1a13:	89 f2                	mov    %esi,%edx
    1a15:	29 c2                	sub    %eax,%edx
    1a17:	89 d0                	mov    %edx,%eax
    1a19:	09 f8                	or     %edi,%eax
    1a1b:	75 93                	jne    19b0 <concreate+0x1c0>
      close(open(file, 0));
    1a1d:	83 ec 08             	sub    $0x8,%esp
    1a20:	6a 00                	push   $0x0
    1a22:	53                   	push   %ebx
    1a23:	e8 fa 1e 00 00       	call   3922 <open>
    1a28:	89 04 24             	mov    %eax,(%esp)
    1a2b:	e8 da 1e 00 00       	call   390a <close>
      close(open(file, 0));
    1a30:	58                   	pop    %eax
    1a31:	5a                   	pop    %edx
    1a32:	6a 00                	push   $0x0
    1a34:	53                   	push   %ebx
    1a35:	e8 e8 1e 00 00       	call   3922 <open>
    1a3a:	89 04 24             	mov    %eax,(%esp)
    1a3d:	e8 c8 1e 00 00       	call   390a <close>
      close(open(file, 0));
    1a42:	59                   	pop    %ecx
    1a43:	58                   	pop    %eax
    1a44:	6a 00                	push   $0x0
    1a46:	53                   	push   %ebx
    1a47:	e8 d6 1e 00 00       	call   3922 <open>
    1a4c:	89 04 24             	mov    %eax,(%esp)
    1a4f:	e8 b6 1e 00 00       	call   390a <close>
      close(open(file, 0));
    1a54:	58                   	pop    %eax
    1a55:	5a                   	pop    %edx
    1a56:	6a 00                	push   $0x0
    1a58:	53                   	push   %ebx
    1a59:	e8 c4 1e 00 00       	call   3922 <open>
    1a5e:	89 04 24             	mov    %eax,(%esp)
    1a61:	e8 a4 1e 00 00       	call   390a <close>
    1a66:	83 c4 10             	add    $0x10,%esp
    1a69:	e9 6f ff ff ff       	jmp    19dd <concreate+0x1ed>
    1a6e:	66 90                	xchg   %ax,%ax
  printf(1, "concreate ok\n");
    1a70:	83 ec 08             	sub    $0x8,%esp
    1a73:	68 98 4c 00 00       	push   $0x4c98
    1a78:	6a 01                	push   $0x1
    1a7a:	e8 b1 1f 00 00       	call   3a30 <printf>
}
    1a7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a82:	5b                   	pop    %ebx
    1a83:	5e                   	pop    %esi
    1a84:	5f                   	pop    %edi
    1a85:	5d                   	pop    %ebp
    1a86:	c3                   	ret    
      printf(1, "fork failed\n");
    1a87:	83 ec 08             	sub    $0x8,%esp
    1a8a:	68 1b 55 00 00       	push   $0x551b
    1a8f:	6a 01                	push   $0x1
    1a91:	e8 9a 1f 00 00       	call   3a30 <printf>
      exit();
    1a96:	e8 47 1e 00 00       	call   38e2 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a9b:	51                   	push   %ecx
    1a9c:	51                   	push   %ecx
    1a9d:	68 50 40 00 00       	push   $0x4050
    1aa2:	6a 01                	push   $0x1
    1aa4:	e8 87 1f 00 00       	call   3a30 <printf>
    exit();
    1aa9:	e8 34 1e 00 00       	call   38e2 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1aae:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1ab1:	53                   	push   %ebx
    1ab2:	50                   	push   %eax
    1ab3:	68 7b 4c 00 00       	push   $0x4c7b
    1ab8:	6a 01                	push   $0x1
    1aba:	e8 71 1f 00 00       	call   3a30 <printf>
        exit();
    1abf:	e8 1e 1e 00 00       	call   38e2 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1ac4:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1ac7:	56                   	push   %esi
    1ac8:	50                   	push   %eax
    1ac9:	68 62 4c 00 00       	push   $0x4c62
    1ace:	6a 01                	push   $0x1
    1ad0:	e8 5b 1f 00 00       	call   3a30 <printf>
        exit();
    1ad5:	e8 08 1e 00 00       	call   38e2 <exit>
      close(fd);
    1ada:	83 ec 0c             	sub    $0xc,%esp
    1add:	50                   	push   %eax
    1ade:	e8 27 1e 00 00       	call   390a <close>
    1ae3:	83 c4 10             	add    $0x10,%esp
    1ae6:	e9 f6 fd ff ff       	jmp    18e1 <concreate+0xf1>
    1aeb:	90                   	nop
    1aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001af0 <linkunlink>:
{
    1af0:	55                   	push   %ebp
    1af1:	89 e5                	mov    %esp,%ebp
    1af3:	57                   	push   %edi
    1af4:	56                   	push   %esi
    1af5:	53                   	push   %ebx
    1af6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1af9:	68 a6 4c 00 00       	push   $0x4ca6
    1afe:	6a 01                	push   $0x1
    1b00:	e8 2b 1f 00 00       	call   3a30 <printf>
  unlink("x");
    1b05:	c7 04 24 33 4f 00 00 	movl   $0x4f33,(%esp)
    1b0c:	e8 21 1e 00 00       	call   3932 <unlink>
  pid = fork();
    1b11:	e8 c4 1d 00 00       	call   38da <fork>
  if(pid < 0){
    1b16:	83 c4 10             	add    $0x10,%esp
    1b19:	85 c0                	test   %eax,%eax
  pid = fork();
    1b1b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1b1e:	0f 88 b6 00 00 00    	js     1bda <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1b24:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b28:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1b2d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b32:	19 ff                	sbb    %edi,%edi
    1b34:	83 e7 60             	and    $0x60,%edi
    1b37:	83 c7 01             	add    $0x1,%edi
    1b3a:	eb 1e                	jmp    1b5a <linkunlink+0x6a>
    1b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1b40:	83 fa 01             	cmp    $0x1,%edx
    1b43:	74 7b                	je     1bc0 <linkunlink+0xd0>
      unlink("x");
    1b45:	83 ec 0c             	sub    $0xc,%esp
    1b48:	68 33 4f 00 00       	push   $0x4f33
    1b4d:	e8 e0 1d 00 00       	call   3932 <unlink>
    1b52:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b55:	83 eb 01             	sub    $0x1,%ebx
    1b58:	74 3d                	je     1b97 <linkunlink+0xa7>
    x = x * 1103515245 + 12345;
    1b5a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b60:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b66:	89 f8                	mov    %edi,%eax
    1b68:	f7 e6                	mul    %esi
    1b6a:	d1 ea                	shr    %edx
    1b6c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b6f:	89 fa                	mov    %edi,%edx
    1b71:	29 c2                	sub    %eax,%edx
    1b73:	75 cb                	jne    1b40 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b75:	83 ec 08             	sub    $0x8,%esp
    1b78:	68 02 02 00 00       	push   $0x202
    1b7d:	68 33 4f 00 00       	push   $0x4f33
    1b82:	e8 9b 1d 00 00       	call   3922 <open>
    1b87:	89 04 24             	mov    %eax,(%esp)
    1b8a:	e8 7b 1d 00 00       	call   390a <close>
    1b8f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b92:	83 eb 01             	sub    $0x1,%ebx
    1b95:	75 c3                	jne    1b5a <linkunlink+0x6a>
  if(pid)
    1b97:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b9a:	85 c0                	test   %eax,%eax
    1b9c:	74 4f                	je     1bed <linkunlink+0xfd>
    wait();
    1b9e:	e8 47 1d 00 00       	call   38ea <wait>
  printf(1, "linkunlink ok\n");
    1ba3:	83 ec 08             	sub    $0x8,%esp
    1ba6:	68 bb 4c 00 00       	push   $0x4cbb
    1bab:	6a 01                	push   $0x1
    1bad:	e8 7e 1e 00 00       	call   3a30 <printf>
}
    1bb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1bb5:	5b                   	pop    %ebx
    1bb6:	5e                   	pop    %esi
    1bb7:	5f                   	pop    %edi
    1bb8:	5d                   	pop    %ebp
    1bb9:	c3                   	ret    
    1bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("cat", "x");
    1bc0:	83 ec 08             	sub    $0x8,%esp
    1bc3:	68 33 4f 00 00       	push   $0x4f33
    1bc8:	68 b7 4c 00 00       	push   $0x4cb7
    1bcd:	e8 70 1d 00 00       	call   3942 <link>
    1bd2:	83 c4 10             	add    $0x10,%esp
    1bd5:	e9 7b ff ff ff       	jmp    1b55 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1bda:	52                   	push   %edx
    1bdb:	52                   	push   %edx
    1bdc:	68 1b 55 00 00       	push   $0x551b
    1be1:	6a 01                	push   $0x1
    1be3:	e8 48 1e 00 00       	call   3a30 <printf>
    exit();
    1be8:	e8 f5 1c 00 00       	call   38e2 <exit>
    exit();
    1bed:	e8 f0 1c 00 00       	call   38e2 <exit>
    1bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001c00 <bigdir>:
{
    1c00:	55                   	push   %ebp
    1c01:	89 e5                	mov    %esp,%ebp
    1c03:	57                   	push   %edi
    1c04:	56                   	push   %esi
    1c05:	53                   	push   %ebx
    1c06:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1c09:	68 ca 4c 00 00       	push   $0x4cca
    1c0e:	6a 01                	push   $0x1
    1c10:	e8 1b 1e 00 00       	call   3a30 <printf>
  unlink("bd");
    1c15:	c7 04 24 d7 4c 00 00 	movl   $0x4cd7,(%esp)
    1c1c:	e8 11 1d 00 00       	call   3932 <unlink>
  fd = open("bd", O_CREATE);
    1c21:	5a                   	pop    %edx
    1c22:	59                   	pop    %ecx
    1c23:	68 00 02 00 00       	push   $0x200
    1c28:	68 d7 4c 00 00       	push   $0x4cd7
    1c2d:	e8 f0 1c 00 00       	call   3922 <open>
  if(fd < 0){
    1c32:	83 c4 10             	add    $0x10,%esp
    1c35:	85 c0                	test   %eax,%eax
    1c37:	0f 88 de 00 00 00    	js     1d1b <bigdir+0x11b>
  close(fd);
    1c3d:	83 ec 0c             	sub    $0xc,%esp
    1c40:	8d 7d de             	lea    -0x22(%ebp),%edi
  for(i = 0; i < 500; i++){
    1c43:	31 f6                	xor    %esi,%esi
  close(fd);
    1c45:	50                   	push   %eax
    1c46:	e8 bf 1c 00 00       	call   390a <close>
    1c4b:	83 c4 10             	add    $0x10,%esp
    1c4e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c50:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c52:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c55:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c59:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c5c:	57                   	push   %edi
    1c5d:	68 d7 4c 00 00       	push   $0x4cd7
    name[1] = '0' + (i / 64);
    1c62:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1c65:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c69:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c6c:	89 f0                	mov    %esi,%eax
    1c6e:	83 e0 3f             	and    $0x3f,%eax
    1c71:	83 c0 30             	add    $0x30,%eax
    1c74:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c77:	e8 c6 1c 00 00       	call   3942 <link>
    1c7c:	83 c4 10             	add    $0x10,%esp
    1c7f:	85 c0                	test   %eax,%eax
    1c81:	89 c3                	mov    %eax,%ebx
    1c83:	75 6e                	jne    1cf3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c85:	83 c6 01             	add    $0x1,%esi
    1c88:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c8e:	75 c0                	jne    1c50 <bigdir+0x50>
  unlink("bd");
    1c90:	83 ec 0c             	sub    $0xc,%esp
    1c93:	68 d7 4c 00 00       	push   $0x4cd7
    1c98:	e8 95 1c 00 00       	call   3932 <unlink>
    1c9d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    1ca0:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1ca2:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1ca5:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1ca9:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1cac:	57                   	push   %edi
    name[3] = '\0';
    1cad:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1cb1:	83 c0 30             	add    $0x30,%eax
    1cb4:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1cb7:	89 d8                	mov    %ebx,%eax
    1cb9:	83 e0 3f             	and    $0x3f,%eax
    1cbc:	83 c0 30             	add    $0x30,%eax
    1cbf:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1cc2:	e8 6b 1c 00 00       	call   3932 <unlink>
    1cc7:	83 c4 10             	add    $0x10,%esp
    1cca:	85 c0                	test   %eax,%eax
    1ccc:	75 39                	jne    1d07 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1cce:	83 c3 01             	add    $0x1,%ebx
    1cd1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cd7:	75 c7                	jne    1ca0 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1cd9:	83 ec 08             	sub    $0x8,%esp
    1cdc:	68 19 4d 00 00       	push   $0x4d19
    1ce1:	6a 01                	push   $0x1
    1ce3:	e8 48 1d 00 00       	call   3a30 <printf>
}
    1ce8:	83 c4 10             	add    $0x10,%esp
    1ceb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cee:	5b                   	pop    %ebx
    1cef:	5e                   	pop    %esi
    1cf0:	5f                   	pop    %edi
    1cf1:	5d                   	pop    %ebp
    1cf2:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1cf3:	83 ec 08             	sub    $0x8,%esp
    1cf6:	68 f0 4c 00 00       	push   $0x4cf0
    1cfb:	6a 01                	push   $0x1
    1cfd:	e8 2e 1d 00 00       	call   3a30 <printf>
      exit();
    1d02:	e8 db 1b 00 00       	call   38e2 <exit>
      printf(1, "bigdir unlink failed");
    1d07:	83 ec 08             	sub    $0x8,%esp
    1d0a:	68 04 4d 00 00       	push   $0x4d04
    1d0f:	6a 01                	push   $0x1
    1d11:	e8 1a 1d 00 00       	call   3a30 <printf>
      exit();
    1d16:	e8 c7 1b 00 00       	call   38e2 <exit>
    printf(1, "bigdir create failed\n");
    1d1b:	50                   	push   %eax
    1d1c:	50                   	push   %eax
    1d1d:	68 da 4c 00 00       	push   $0x4cda
    1d22:	6a 01                	push   $0x1
    1d24:	e8 07 1d 00 00       	call   3a30 <printf>
    exit();
    1d29:	e8 b4 1b 00 00       	call   38e2 <exit>
    1d2e:	66 90                	xchg   %ax,%ax

00001d30 <subdir>:
{
    1d30:	55                   	push   %ebp
    1d31:	89 e5                	mov    %esp,%ebp
    1d33:	53                   	push   %ebx
    1d34:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1d37:	68 24 4d 00 00       	push   $0x4d24
    1d3c:	6a 01                	push   $0x1
    1d3e:	e8 ed 1c 00 00       	call   3a30 <printf>
  unlink("ff");
    1d43:	c7 04 24 ad 4d 00 00 	movl   $0x4dad,(%esp)
    1d4a:	e8 e3 1b 00 00       	call   3932 <unlink>
  if(mkdir("dd") != 0){
    1d4f:	c7 04 24 4a 4e 00 00 	movl   $0x4e4a,(%esp)
    1d56:	e8 ef 1b 00 00       	call   394a <mkdir>
    1d5b:	83 c4 10             	add    $0x10,%esp
    1d5e:	85 c0                	test   %eax,%eax
    1d60:	0f 85 b3 05 00 00    	jne    2319 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d66:	83 ec 08             	sub    $0x8,%esp
    1d69:	68 02 02 00 00       	push   $0x202
    1d6e:	68 83 4d 00 00       	push   $0x4d83
    1d73:	e8 aa 1b 00 00       	call   3922 <open>
  if(fd < 0){
    1d78:	83 c4 10             	add    $0x10,%esp
    1d7b:	85 c0                	test   %eax,%eax
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d7d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d7f:	0f 88 81 05 00 00    	js     2306 <subdir+0x5d6>
  write(fd, "ff", 2);
    1d85:	83 ec 04             	sub    $0x4,%esp
    1d88:	6a 02                	push   $0x2
    1d8a:	68 ad 4d 00 00       	push   $0x4dad
    1d8f:	50                   	push   %eax
    1d90:	e8 6d 1b 00 00       	call   3902 <write>
  close(fd);
    1d95:	89 1c 24             	mov    %ebx,(%esp)
    1d98:	e8 6d 1b 00 00       	call   390a <close>
  if(unlink("dd") >= 0){
    1d9d:	c7 04 24 4a 4e 00 00 	movl   $0x4e4a,(%esp)
    1da4:	e8 89 1b 00 00       	call   3932 <unlink>
    1da9:	83 c4 10             	add    $0x10,%esp
    1dac:	85 c0                	test   %eax,%eax
    1dae:	0f 89 3f 05 00 00    	jns    22f3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1db4:	83 ec 0c             	sub    $0xc,%esp
    1db7:	68 5e 4d 00 00       	push   $0x4d5e
    1dbc:	e8 89 1b 00 00       	call   394a <mkdir>
    1dc1:	83 c4 10             	add    $0x10,%esp
    1dc4:	85 c0                	test   %eax,%eax
    1dc6:	0f 85 14 05 00 00    	jne    22e0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dcc:	83 ec 08             	sub    $0x8,%esp
    1dcf:	68 02 02 00 00       	push   $0x202
    1dd4:	68 80 4d 00 00       	push   $0x4d80
    1dd9:	e8 44 1b 00 00       	call   3922 <open>
  if(fd < 0){
    1dde:	83 c4 10             	add    $0x10,%esp
    1de1:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1de3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1de5:	0f 88 24 04 00 00    	js     220f <subdir+0x4df>
  write(fd, "FF", 2);
    1deb:	83 ec 04             	sub    $0x4,%esp
    1dee:	6a 02                	push   $0x2
    1df0:	68 a1 4d 00 00       	push   $0x4da1
    1df5:	50                   	push   %eax
    1df6:	e8 07 1b 00 00       	call   3902 <write>
  close(fd);
    1dfb:	89 1c 24             	mov    %ebx,(%esp)
    1dfe:	e8 07 1b 00 00       	call   390a <close>
  fd = open("dd/dd/../ff", 0);
    1e03:	58                   	pop    %eax
    1e04:	5a                   	pop    %edx
    1e05:	6a 00                	push   $0x0
    1e07:	68 a4 4d 00 00       	push   $0x4da4
    1e0c:	e8 11 1b 00 00       	call   3922 <open>
  if(fd < 0){
    1e11:	83 c4 10             	add    $0x10,%esp
    1e14:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/../ff", 0);
    1e16:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e18:	0f 88 de 03 00 00    	js     21fc <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    1e1e:	83 ec 04             	sub    $0x4,%esp
    1e21:	68 00 20 00 00       	push   $0x2000
    1e26:	68 00 87 00 00       	push   $0x8700
    1e2b:	50                   	push   %eax
    1e2c:	e8 c9 1a 00 00       	call   38fa <read>
  if(cc != 2 || buf[0] != 'f'){
    1e31:	83 c4 10             	add    $0x10,%esp
    1e34:	83 f8 02             	cmp    $0x2,%eax
    1e37:	0f 85 3a 03 00 00    	jne    2177 <subdir+0x447>
    1e3d:	80 3d 00 87 00 00 66 	cmpb   $0x66,0x8700
    1e44:	0f 85 2d 03 00 00    	jne    2177 <subdir+0x447>
  close(fd);
    1e4a:	83 ec 0c             	sub    $0xc,%esp
    1e4d:	53                   	push   %ebx
    1e4e:	e8 b7 1a 00 00       	call   390a <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e53:	5b                   	pop    %ebx
    1e54:	58                   	pop    %eax
    1e55:	68 e4 4d 00 00       	push   $0x4de4
    1e5a:	68 80 4d 00 00       	push   $0x4d80
    1e5f:	e8 de 1a 00 00       	call   3942 <link>
    1e64:	83 c4 10             	add    $0x10,%esp
    1e67:	85 c0                	test   %eax,%eax
    1e69:	0f 85 c6 03 00 00    	jne    2235 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e6f:	83 ec 0c             	sub    $0xc,%esp
    1e72:	68 80 4d 00 00       	push   $0x4d80
    1e77:	e8 b6 1a 00 00       	call   3932 <unlink>
    1e7c:	83 c4 10             	add    $0x10,%esp
    1e7f:	85 c0                	test   %eax,%eax
    1e81:	0f 85 16 03 00 00    	jne    219d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e87:	83 ec 08             	sub    $0x8,%esp
    1e8a:	6a 00                	push   $0x0
    1e8c:	68 80 4d 00 00       	push   $0x4d80
    1e91:	e8 8c 1a 00 00       	call   3922 <open>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	0f 89 2c 04 00 00    	jns    22cd <subdir+0x59d>
  if(chdir("dd") != 0){
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	68 4a 4e 00 00       	push   $0x4e4a
    1ea9:	e8 a4 1a 00 00       	call   3952 <chdir>
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	0f 85 01 04 00 00    	jne    22ba <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1eb9:	83 ec 0c             	sub    $0xc,%esp
    1ebc:	68 18 4e 00 00       	push   $0x4e18
    1ec1:	e8 8c 1a 00 00       	call   3952 <chdir>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 85 b9 02 00 00    	jne    218a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1ed1:	83 ec 0c             	sub    $0xc,%esp
    1ed4:	68 3e 4e 00 00       	push   $0x4e3e
    1ed9:	e8 74 1a 00 00       	call   3952 <chdir>
    1ede:	83 c4 10             	add    $0x10,%esp
    1ee1:	85 c0                	test   %eax,%eax
    1ee3:	0f 85 a1 02 00 00    	jne    218a <subdir+0x45a>
  if(chdir("./..") != 0){
    1ee9:	83 ec 0c             	sub    $0xc,%esp
    1eec:	68 4d 4e 00 00       	push   $0x4e4d
    1ef1:	e8 5c 1a 00 00       	call   3952 <chdir>
    1ef6:	83 c4 10             	add    $0x10,%esp
    1ef9:	85 c0                	test   %eax,%eax
    1efb:	0f 85 21 03 00 00    	jne    2222 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1f01:	83 ec 08             	sub    $0x8,%esp
    1f04:	6a 00                	push   $0x0
    1f06:	68 e4 4d 00 00       	push   $0x4de4
    1f0b:	e8 12 1a 00 00       	call   3922 <open>
  if(fd < 0){
    1f10:	83 c4 10             	add    $0x10,%esp
    1f13:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ffff", 0);
    1f15:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f17:	0f 88 e0 04 00 00    	js     23fd <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    1f1d:	83 ec 04             	sub    $0x4,%esp
    1f20:	68 00 20 00 00       	push   $0x2000
    1f25:	68 00 87 00 00       	push   $0x8700
    1f2a:	50                   	push   %eax
    1f2b:	e8 ca 19 00 00       	call   38fa <read>
    1f30:	83 c4 10             	add    $0x10,%esp
    1f33:	83 f8 02             	cmp    $0x2,%eax
    1f36:	0f 85 ae 04 00 00    	jne    23ea <subdir+0x6ba>
  close(fd);
    1f3c:	83 ec 0c             	sub    $0xc,%esp
    1f3f:	53                   	push   %ebx
    1f40:	e8 c5 19 00 00       	call   390a <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f45:	59                   	pop    %ecx
    1f46:	5b                   	pop    %ebx
    1f47:	6a 00                	push   $0x0
    1f49:	68 80 4d 00 00       	push   $0x4d80
    1f4e:	e8 cf 19 00 00       	call   3922 <open>
    1f53:	83 c4 10             	add    $0x10,%esp
    1f56:	85 c0                	test   %eax,%eax
    1f58:	0f 89 65 02 00 00    	jns    21c3 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f5e:	83 ec 08             	sub    $0x8,%esp
    1f61:	68 02 02 00 00       	push   $0x202
    1f66:	68 98 4e 00 00       	push   $0x4e98
    1f6b:	e8 b2 19 00 00       	call   3922 <open>
    1f70:	83 c4 10             	add    $0x10,%esp
    1f73:	85 c0                	test   %eax,%eax
    1f75:	0f 89 35 02 00 00    	jns    21b0 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f7b:	83 ec 08             	sub    $0x8,%esp
    1f7e:	68 02 02 00 00       	push   $0x202
    1f83:	68 bd 4e 00 00       	push   $0x4ebd
    1f88:	e8 95 19 00 00       	call   3922 <open>
    1f8d:	83 c4 10             	add    $0x10,%esp
    1f90:	85 c0                	test   %eax,%eax
    1f92:	0f 89 0f 03 00 00    	jns    22a7 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f98:	83 ec 08             	sub    $0x8,%esp
    1f9b:	68 00 02 00 00       	push   $0x200
    1fa0:	68 4a 4e 00 00       	push   $0x4e4a
    1fa5:	e8 78 19 00 00       	call   3922 <open>
    1faa:	83 c4 10             	add    $0x10,%esp
    1fad:	85 c0                	test   %eax,%eax
    1faf:	0f 89 df 02 00 00    	jns    2294 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1fb5:	83 ec 08             	sub    $0x8,%esp
    1fb8:	6a 02                	push   $0x2
    1fba:	68 4a 4e 00 00       	push   $0x4e4a
    1fbf:	e8 5e 19 00 00       	call   3922 <open>
    1fc4:	83 c4 10             	add    $0x10,%esp
    1fc7:	85 c0                	test   %eax,%eax
    1fc9:	0f 89 b2 02 00 00    	jns    2281 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1fcf:	83 ec 08             	sub    $0x8,%esp
    1fd2:	6a 01                	push   $0x1
    1fd4:	68 4a 4e 00 00       	push   $0x4e4a
    1fd9:	e8 44 19 00 00       	call   3922 <open>
    1fde:	83 c4 10             	add    $0x10,%esp
    1fe1:	85 c0                	test   %eax,%eax
    1fe3:	0f 89 85 02 00 00    	jns    226e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fe9:	83 ec 08             	sub    $0x8,%esp
    1fec:	68 2c 4f 00 00       	push   $0x4f2c
    1ff1:	68 98 4e 00 00       	push   $0x4e98
    1ff6:	e8 47 19 00 00       	call   3942 <link>
    1ffb:	83 c4 10             	add    $0x10,%esp
    1ffe:	85 c0                	test   %eax,%eax
    2000:	0f 84 55 02 00 00    	je     225b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2006:	83 ec 08             	sub    $0x8,%esp
    2009:	68 2c 4f 00 00       	push   $0x4f2c
    200e:	68 bd 4e 00 00       	push   $0x4ebd
    2013:	e8 2a 19 00 00       	call   3942 <link>
    2018:	83 c4 10             	add    $0x10,%esp
    201b:	85 c0                	test   %eax,%eax
    201d:	0f 84 25 02 00 00    	je     2248 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2023:	83 ec 08             	sub    $0x8,%esp
    2026:	68 e4 4d 00 00       	push   $0x4de4
    202b:	68 83 4d 00 00       	push   $0x4d83
    2030:	e8 0d 19 00 00       	call   3942 <link>
    2035:	83 c4 10             	add    $0x10,%esp
    2038:	85 c0                	test   %eax,%eax
    203a:	0f 84 a9 01 00 00    	je     21e9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2040:	83 ec 0c             	sub    $0xc,%esp
    2043:	68 98 4e 00 00       	push   $0x4e98
    2048:	e8 fd 18 00 00       	call   394a <mkdir>
    204d:	83 c4 10             	add    $0x10,%esp
    2050:	85 c0                	test   %eax,%eax
    2052:	0f 84 7e 01 00 00    	je     21d6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2058:	83 ec 0c             	sub    $0xc,%esp
    205b:	68 bd 4e 00 00       	push   $0x4ebd
    2060:	e8 e5 18 00 00       	call   394a <mkdir>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 67 03 00 00    	je     23d7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 e4 4d 00 00       	push   $0x4de4
    2078:	e8 cd 18 00 00       	call   394a <mkdir>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 3c 03 00 00    	je     23c4 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 bd 4e 00 00       	push   $0x4ebd
    2090:	e8 9d 18 00 00       	call   3932 <unlink>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 11 03 00 00    	je     23b1 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 98 4e 00 00       	push   $0x4e98
    20a8:	e8 85 18 00 00       	call   3932 <unlink>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 e6 02 00 00    	je     239e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 83 4d 00 00       	push   $0x4d83
    20c0:	e8 8d 18 00 00       	call   3952 <chdir>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 84 bb 02 00 00    	je     238b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 2f 4f 00 00       	push   $0x4f2f
    20d8:	e8 75 18 00 00       	call   3952 <chdir>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 84 90 02 00 00    	je     2378 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 e4 4d 00 00       	push   $0x4de4
    20f0:	e8 3d 18 00 00       	call   3932 <unlink>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 85 9d 00 00 00    	jne    219d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 83 4d 00 00       	push   $0x4d83
    2108:	e8 25 18 00 00       	call   3932 <unlink>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 85 4d 02 00 00    	jne    2365 <subdir+0x635>
  if(unlink("dd") == 0){
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 4a 4e 00 00       	push   $0x4e4a
    2120:	e8 0d 18 00 00       	call   3932 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 84 22 02 00 00    	je     2352 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2130:	83 ec 0c             	sub    $0xc,%esp
    2133:	68 5f 4d 00 00       	push   $0x4d5f
    2138:	e8 f5 17 00 00       	call   3932 <unlink>
    213d:	83 c4 10             	add    $0x10,%esp
    2140:	85 c0                	test   %eax,%eax
    2142:	0f 88 f7 01 00 00    	js     233f <subdir+0x60f>
  if(unlink("dd") < 0){
    2148:	83 ec 0c             	sub    $0xc,%esp
    214b:	68 4a 4e 00 00       	push   $0x4e4a
    2150:	e8 dd 17 00 00       	call   3932 <unlink>
    2155:	83 c4 10             	add    $0x10,%esp
    2158:	85 c0                	test   %eax,%eax
    215a:	0f 88 cc 01 00 00    	js     232c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2160:	83 ec 08             	sub    $0x8,%esp
    2163:	68 2c 50 00 00       	push   $0x502c
    2168:	6a 01                	push   $0x1
    216a:	e8 c1 18 00 00       	call   3a30 <printf>
}
    216f:	83 c4 10             	add    $0x10,%esp
    2172:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2175:	c9                   	leave  
    2176:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2177:	50                   	push   %eax
    2178:	50                   	push   %eax
    2179:	68 c9 4d 00 00       	push   $0x4dc9
    217e:	6a 01                	push   $0x1
    2180:	e8 ab 18 00 00       	call   3a30 <printf>
    exit();
    2185:	e8 58 17 00 00       	call   38e2 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    218a:	50                   	push   %eax
    218b:	50                   	push   %eax
    218c:	68 24 4e 00 00       	push   $0x4e24
    2191:	6a 01                	push   $0x1
    2193:	e8 98 18 00 00       	call   3a30 <printf>
    exit();
    2198:	e8 45 17 00 00       	call   38e2 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    219d:	52                   	push   %edx
    219e:	52                   	push   %edx
    219f:	68 ef 4d 00 00       	push   $0x4def
    21a4:	6a 01                	push   $0x1
    21a6:	e8 85 18 00 00       	call   3a30 <printf>
    exit();
    21ab:	e8 32 17 00 00       	call   38e2 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    21b0:	50                   	push   %eax
    21b1:	50                   	push   %eax
    21b2:	68 a1 4e 00 00       	push   $0x4ea1
    21b7:	6a 01                	push   $0x1
    21b9:	e8 72 18 00 00       	call   3a30 <printf>
    exit();
    21be:	e8 1f 17 00 00       	call   38e2 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    21c3:	52                   	push   %edx
    21c4:	52                   	push   %edx
    21c5:	68 f4 40 00 00       	push   $0x40f4
    21ca:	6a 01                	push   $0x1
    21cc:	e8 5f 18 00 00       	call   3a30 <printf>
    exit();
    21d1:	e8 0c 17 00 00       	call   38e2 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21d6:	52                   	push   %edx
    21d7:	52                   	push   %edx
    21d8:	68 35 4f 00 00       	push   $0x4f35
    21dd:	6a 01                	push   $0x1
    21df:	e8 4c 18 00 00       	call   3a30 <printf>
    exit();
    21e4:	e8 f9 16 00 00       	call   38e2 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21e9:	51                   	push   %ecx
    21ea:	51                   	push   %ecx
    21eb:	68 64 41 00 00       	push   $0x4164
    21f0:	6a 01                	push   $0x1
    21f2:	e8 39 18 00 00       	call   3a30 <printf>
    exit();
    21f7:	e8 e6 16 00 00       	call   38e2 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21fc:	50                   	push   %eax
    21fd:	50                   	push   %eax
    21fe:	68 b0 4d 00 00       	push   $0x4db0
    2203:	6a 01                	push   $0x1
    2205:	e8 26 18 00 00       	call   3a30 <printf>
    exit();
    220a:	e8 d3 16 00 00       	call   38e2 <exit>
    printf(1, "create dd/dd/ff failed\n");
    220f:	51                   	push   %ecx
    2210:	51                   	push   %ecx
    2211:	68 89 4d 00 00       	push   $0x4d89
    2216:	6a 01                	push   $0x1
    2218:	e8 13 18 00 00       	call   3a30 <printf>
    exit();
    221d:	e8 c0 16 00 00       	call   38e2 <exit>
    printf(1, "chdir ./.. failed\n");
    2222:	50                   	push   %eax
    2223:	50                   	push   %eax
    2224:	68 52 4e 00 00       	push   $0x4e52
    2229:	6a 01                	push   $0x1
    222b:	e8 00 18 00 00       	call   3a30 <printf>
    exit();
    2230:	e8 ad 16 00 00       	call   38e2 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2235:	51                   	push   %ecx
    2236:	51                   	push   %ecx
    2237:	68 ac 40 00 00       	push   $0x40ac
    223c:	6a 01                	push   $0x1
    223e:	e8 ed 17 00 00       	call   3a30 <printf>
    exit();
    2243:	e8 9a 16 00 00       	call   38e2 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2248:	53                   	push   %ebx
    2249:	53                   	push   %ebx
    224a:	68 40 41 00 00       	push   $0x4140
    224f:	6a 01                	push   $0x1
    2251:	e8 da 17 00 00       	call   3a30 <printf>
    exit();
    2256:	e8 87 16 00 00       	call   38e2 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    225b:	50                   	push   %eax
    225c:	50                   	push   %eax
    225d:	68 1c 41 00 00       	push   $0x411c
    2262:	6a 01                	push   $0x1
    2264:	e8 c7 17 00 00       	call   3a30 <printf>
    exit();
    2269:	e8 74 16 00 00       	call   38e2 <exit>
    printf(1, "open dd wronly succeeded!\n");
    226e:	50                   	push   %eax
    226f:	50                   	push   %eax
    2270:	68 11 4f 00 00       	push   $0x4f11
    2275:	6a 01                	push   $0x1
    2277:	e8 b4 17 00 00       	call   3a30 <printf>
    exit();
    227c:	e8 61 16 00 00       	call   38e2 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2281:	50                   	push   %eax
    2282:	50                   	push   %eax
    2283:	68 f8 4e 00 00       	push   $0x4ef8
    2288:	6a 01                	push   $0x1
    228a:	e8 a1 17 00 00       	call   3a30 <printf>
    exit();
    228f:	e8 4e 16 00 00       	call   38e2 <exit>
    printf(1, "create dd succeeded!\n");
    2294:	50                   	push   %eax
    2295:	50                   	push   %eax
    2296:	68 e2 4e 00 00       	push   $0x4ee2
    229b:	6a 01                	push   $0x1
    229d:	e8 8e 17 00 00       	call   3a30 <printf>
    exit();
    22a2:	e8 3b 16 00 00       	call   38e2 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    22a7:	50                   	push   %eax
    22a8:	50                   	push   %eax
    22a9:	68 c6 4e 00 00       	push   $0x4ec6
    22ae:	6a 01                	push   $0x1
    22b0:	e8 7b 17 00 00       	call   3a30 <printf>
    exit();
    22b5:	e8 28 16 00 00       	call   38e2 <exit>
    printf(1, "chdir dd failed\n");
    22ba:	50                   	push   %eax
    22bb:	50                   	push   %eax
    22bc:	68 07 4e 00 00       	push   $0x4e07
    22c1:	6a 01                	push   $0x1
    22c3:	e8 68 17 00 00       	call   3a30 <printf>
    exit();
    22c8:	e8 15 16 00 00       	call   38e2 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    22cd:	50                   	push   %eax
    22ce:	50                   	push   %eax
    22cf:	68 d0 40 00 00       	push   $0x40d0
    22d4:	6a 01                	push   $0x1
    22d6:	e8 55 17 00 00       	call   3a30 <printf>
    exit();
    22db:	e8 02 16 00 00       	call   38e2 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    22e0:	53                   	push   %ebx
    22e1:	53                   	push   %ebx
    22e2:	68 65 4d 00 00       	push   $0x4d65
    22e7:	6a 01                	push   $0x1
    22e9:	e8 42 17 00 00       	call   3a30 <printf>
    exit();
    22ee:	e8 ef 15 00 00       	call   38e2 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22f3:	50                   	push   %eax
    22f4:	50                   	push   %eax
    22f5:	68 84 40 00 00       	push   $0x4084
    22fa:	6a 01                	push   $0x1
    22fc:	e8 2f 17 00 00       	call   3a30 <printf>
    exit();
    2301:	e8 dc 15 00 00       	call   38e2 <exit>
    printf(1, "create dd/ff failed\n");
    2306:	50                   	push   %eax
    2307:	50                   	push   %eax
    2308:	68 49 4d 00 00       	push   $0x4d49
    230d:	6a 01                	push   $0x1
    230f:	e8 1c 17 00 00       	call   3a30 <printf>
    exit();
    2314:	e8 c9 15 00 00       	call   38e2 <exit>
    printf(1, "subdir mkdir dd failed\n");
    2319:	50                   	push   %eax
    231a:	50                   	push   %eax
    231b:	68 31 4d 00 00       	push   $0x4d31
    2320:	6a 01                	push   $0x1
    2322:	e8 09 17 00 00       	call   3a30 <printf>
    exit();
    2327:	e8 b6 15 00 00       	call   38e2 <exit>
    printf(1, "unlink dd failed\n");
    232c:	50                   	push   %eax
    232d:	50                   	push   %eax
    232e:	68 1a 50 00 00       	push   $0x501a
    2333:	6a 01                	push   $0x1
    2335:	e8 f6 16 00 00       	call   3a30 <printf>
    exit();
    233a:	e8 a3 15 00 00       	call   38e2 <exit>
    printf(1, "unlink dd/dd failed\n");
    233f:	52                   	push   %edx
    2340:	52                   	push   %edx
    2341:	68 05 50 00 00       	push   $0x5005
    2346:	6a 01                	push   $0x1
    2348:	e8 e3 16 00 00       	call   3a30 <printf>
    exit();
    234d:	e8 90 15 00 00       	call   38e2 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2352:	51                   	push   %ecx
    2353:	51                   	push   %ecx
    2354:	68 88 41 00 00       	push   $0x4188
    2359:	6a 01                	push   $0x1
    235b:	e8 d0 16 00 00       	call   3a30 <printf>
    exit();
    2360:	e8 7d 15 00 00       	call   38e2 <exit>
    printf(1, "unlink dd/ff failed\n");
    2365:	53                   	push   %ebx
    2366:	53                   	push   %ebx
    2367:	68 f0 4f 00 00       	push   $0x4ff0
    236c:	6a 01                	push   $0x1
    236e:	e8 bd 16 00 00       	call   3a30 <printf>
    exit();
    2373:	e8 6a 15 00 00       	call   38e2 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2378:	50                   	push   %eax
    2379:	50                   	push   %eax
    237a:	68 d8 4f 00 00       	push   $0x4fd8
    237f:	6a 01                	push   $0x1
    2381:	e8 aa 16 00 00       	call   3a30 <printf>
    exit();
    2386:	e8 57 15 00 00       	call   38e2 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    238b:	50                   	push   %eax
    238c:	50                   	push   %eax
    238d:	68 c0 4f 00 00       	push   $0x4fc0
    2392:	6a 01                	push   $0x1
    2394:	e8 97 16 00 00       	call   3a30 <printf>
    exit();
    2399:	e8 44 15 00 00       	call   38e2 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    239e:	50                   	push   %eax
    239f:	50                   	push   %eax
    23a0:	68 a4 4f 00 00       	push   $0x4fa4
    23a5:	6a 01                	push   $0x1
    23a7:	e8 84 16 00 00       	call   3a30 <printf>
    exit();
    23ac:	e8 31 15 00 00       	call   38e2 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    23b1:	50                   	push   %eax
    23b2:	50                   	push   %eax
    23b3:	68 88 4f 00 00       	push   $0x4f88
    23b8:	6a 01                	push   $0x1
    23ba:	e8 71 16 00 00       	call   3a30 <printf>
    exit();
    23bf:	e8 1e 15 00 00       	call   38e2 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    23c4:	50                   	push   %eax
    23c5:	50                   	push   %eax
    23c6:	68 6b 4f 00 00       	push   $0x4f6b
    23cb:	6a 01                	push   $0x1
    23cd:	e8 5e 16 00 00       	call   3a30 <printf>
    exit();
    23d2:	e8 0b 15 00 00       	call   38e2 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    23d7:	50                   	push   %eax
    23d8:	50                   	push   %eax
    23d9:	68 50 4f 00 00       	push   $0x4f50
    23de:	6a 01                	push   $0x1
    23e0:	e8 4b 16 00 00       	call   3a30 <printf>
    exit();
    23e5:	e8 f8 14 00 00       	call   38e2 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    23ea:	50                   	push   %eax
    23eb:	50                   	push   %eax
    23ec:	68 7d 4e 00 00       	push   $0x4e7d
    23f1:	6a 01                	push   $0x1
    23f3:	e8 38 16 00 00       	call   3a30 <printf>
    exit();
    23f8:	e8 e5 14 00 00       	call   38e2 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    23fd:	50                   	push   %eax
    23fe:	50                   	push   %eax
    23ff:	68 65 4e 00 00       	push   $0x4e65
    2404:	6a 01                	push   $0x1
    2406:	e8 25 16 00 00       	call   3a30 <printf>
    exit();
    240b:	e8 d2 14 00 00       	call   38e2 <exit>

00002410 <bigwrite>:
{
    2410:	55                   	push   %ebp
    2411:	89 e5                	mov    %esp,%ebp
    2413:	56                   	push   %esi
    2414:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    2415:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    241a:	83 ec 08             	sub    $0x8,%esp
    241d:	68 37 50 00 00       	push   $0x5037
    2422:	6a 01                	push   $0x1
    2424:	e8 07 16 00 00       	call   3a30 <printf>
  unlink("bigwrite");
    2429:	c7 04 24 46 50 00 00 	movl   $0x5046,(%esp)
    2430:	e8 fd 14 00 00       	call   3932 <unlink>
    2435:	83 c4 10             	add    $0x10,%esp
    2438:	90                   	nop
    2439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2440:	83 ec 08             	sub    $0x8,%esp
    2443:	68 02 02 00 00       	push   $0x202
    2448:	68 46 50 00 00       	push   $0x5046
    244d:	e8 d0 14 00 00       	call   3922 <open>
    if(fd < 0){
    2452:	83 c4 10             	add    $0x10,%esp
    2455:	85 c0                	test   %eax,%eax
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2457:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2459:	78 7e                	js     24d9 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    245b:	83 ec 04             	sub    $0x4,%esp
    245e:	53                   	push   %ebx
    245f:	68 00 87 00 00       	push   $0x8700
    2464:	50                   	push   %eax
    2465:	e8 98 14 00 00       	call   3902 <write>
      if(cc != sz){
    246a:	83 c4 10             	add    $0x10,%esp
    246d:	39 d8                	cmp    %ebx,%eax
    246f:	75 55                	jne    24c6 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2471:	83 ec 04             	sub    $0x4,%esp
    2474:	53                   	push   %ebx
    2475:	68 00 87 00 00       	push   $0x8700
    247a:	56                   	push   %esi
    247b:	e8 82 14 00 00       	call   3902 <write>
      if(cc != sz){
    2480:	83 c4 10             	add    $0x10,%esp
    2483:	39 d8                	cmp    %ebx,%eax
    2485:	75 3f                	jne    24c6 <bigwrite+0xb6>
    close(fd);
    2487:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    248a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2490:	56                   	push   %esi
    2491:	e8 74 14 00 00       	call   390a <close>
    unlink("bigwrite");
    2496:	c7 04 24 46 50 00 00 	movl   $0x5046,(%esp)
    249d:	e8 90 14 00 00       	call   3932 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    24a2:	83 c4 10             	add    $0x10,%esp
    24a5:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    24ab:	75 93                	jne    2440 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    24ad:	83 ec 08             	sub    $0x8,%esp
    24b0:	68 79 50 00 00       	push   $0x5079
    24b5:	6a 01                	push   $0x1
    24b7:	e8 74 15 00 00       	call   3a30 <printf>
}
    24bc:	83 c4 10             	add    $0x10,%esp
    24bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24c2:	5b                   	pop    %ebx
    24c3:	5e                   	pop    %esi
    24c4:	5d                   	pop    %ebp
    24c5:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    24c6:	50                   	push   %eax
    24c7:	53                   	push   %ebx
    24c8:	68 67 50 00 00       	push   $0x5067
    24cd:	6a 01                	push   $0x1
    24cf:	e8 5c 15 00 00       	call   3a30 <printf>
        exit();
    24d4:	e8 09 14 00 00       	call   38e2 <exit>
      printf(1, "cannot create bigwrite\n");
    24d9:	83 ec 08             	sub    $0x8,%esp
    24dc:	68 4f 50 00 00       	push   $0x504f
    24e1:	6a 01                	push   $0x1
    24e3:	e8 48 15 00 00       	call   3a30 <printf>
      exit();
    24e8:	e8 f5 13 00 00       	call   38e2 <exit>
    24ed:	8d 76 00             	lea    0x0(%esi),%esi

000024f0 <bigfile>:
{
    24f0:	55                   	push   %ebp
    24f1:	89 e5                	mov    %esp,%ebp
    24f3:	57                   	push   %edi
    24f4:	56                   	push   %esi
    24f5:	53                   	push   %ebx
    24f6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    24f9:	68 86 50 00 00       	push   $0x5086
    24fe:	6a 01                	push   $0x1
    2500:	e8 2b 15 00 00       	call   3a30 <printf>
  unlink("bigfile");
    2505:	c7 04 24 a2 50 00 00 	movl   $0x50a2,(%esp)
    250c:	e8 21 14 00 00       	call   3932 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2511:	58                   	pop    %eax
    2512:	5a                   	pop    %edx
    2513:	68 02 02 00 00       	push   $0x202
    2518:	68 a2 50 00 00       	push   $0x50a2
    251d:	e8 00 14 00 00       	call   3922 <open>
  if(fd < 0){
    2522:	83 c4 10             	add    $0x10,%esp
    2525:	85 c0                	test   %eax,%eax
    2527:	0f 88 5e 01 00 00    	js     268b <bigfile+0x19b>
    252d:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    252f:	31 db                	xor    %ebx,%ebx
    2531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2538:	83 ec 04             	sub    $0x4,%esp
    253b:	68 58 02 00 00       	push   $0x258
    2540:	53                   	push   %ebx
    2541:	68 00 87 00 00       	push   $0x8700
    2546:	e8 f5 11 00 00       	call   3740 <memset>
    if(write(fd, buf, 600) != 600){
    254b:	83 c4 0c             	add    $0xc,%esp
    254e:	68 58 02 00 00       	push   $0x258
    2553:	68 00 87 00 00       	push   $0x8700
    2558:	56                   	push   %esi
    2559:	e8 a4 13 00 00       	call   3902 <write>
    255e:	83 c4 10             	add    $0x10,%esp
    2561:	3d 58 02 00 00       	cmp    $0x258,%eax
    2566:	0f 85 f8 00 00 00    	jne    2664 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    256c:	83 c3 01             	add    $0x1,%ebx
    256f:	83 fb 14             	cmp    $0x14,%ebx
    2572:	75 c4                	jne    2538 <bigfile+0x48>
  close(fd);
    2574:	83 ec 0c             	sub    $0xc,%esp
    2577:	56                   	push   %esi
    2578:	e8 8d 13 00 00       	call   390a <close>
  fd = open("bigfile", 0);
    257d:	5e                   	pop    %esi
    257e:	5f                   	pop    %edi
    257f:	6a 00                	push   $0x0
    2581:	68 a2 50 00 00       	push   $0x50a2
    2586:	e8 97 13 00 00       	call   3922 <open>
  if(fd < 0){
    258b:	83 c4 10             	add    $0x10,%esp
    258e:	85 c0                	test   %eax,%eax
  fd = open("bigfile", 0);
    2590:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2592:	0f 88 e0 00 00 00    	js     2678 <bigfile+0x188>
  total = 0;
    2598:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    259a:	31 ff                	xor    %edi,%edi
    259c:	eb 30                	jmp    25ce <bigfile+0xde>
    259e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    25a0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    25a5:	0f 85 91 00 00 00    	jne    263c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    25ab:	0f be 05 00 87 00 00 	movsbl 0x8700,%eax
    25b2:	89 fa                	mov    %edi,%edx
    25b4:	d1 fa                	sar    %edx
    25b6:	39 d0                	cmp    %edx,%eax
    25b8:	75 6e                	jne    2628 <bigfile+0x138>
    25ba:	0f be 15 2b 88 00 00 	movsbl 0x882b,%edx
    25c1:	39 d0                	cmp    %edx,%eax
    25c3:	75 63                	jne    2628 <bigfile+0x138>
    total += cc;
    25c5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    25cb:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    25ce:	83 ec 04             	sub    $0x4,%esp
    25d1:	68 2c 01 00 00       	push   $0x12c
    25d6:	68 00 87 00 00       	push   $0x8700
    25db:	56                   	push   %esi
    25dc:	e8 19 13 00 00       	call   38fa <read>
    if(cc < 0){
    25e1:	83 c4 10             	add    $0x10,%esp
    25e4:	85 c0                	test   %eax,%eax
    25e6:	78 68                	js     2650 <bigfile+0x160>
    if(cc == 0)
    25e8:	75 b6                	jne    25a0 <bigfile+0xb0>
  close(fd);
    25ea:	83 ec 0c             	sub    $0xc,%esp
    25ed:	56                   	push   %esi
    25ee:	e8 17 13 00 00       	call   390a <close>
  if(total != 20*600){
    25f3:	83 c4 10             	add    $0x10,%esp
    25f6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25fc:	0f 85 9c 00 00 00    	jne    269e <bigfile+0x1ae>
  unlink("bigfile");
    2602:	83 ec 0c             	sub    $0xc,%esp
    2605:	68 a2 50 00 00       	push   $0x50a2
    260a:	e8 23 13 00 00       	call   3932 <unlink>
  printf(1, "bigfile test ok\n");
    260f:	58                   	pop    %eax
    2610:	5a                   	pop    %edx
    2611:	68 31 51 00 00       	push   $0x5131
    2616:	6a 01                	push   $0x1
    2618:	e8 13 14 00 00       	call   3a30 <printf>
}
    261d:	83 c4 10             	add    $0x10,%esp
    2620:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2623:	5b                   	pop    %ebx
    2624:	5e                   	pop    %esi
    2625:	5f                   	pop    %edi
    2626:	5d                   	pop    %ebp
    2627:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2628:	83 ec 08             	sub    $0x8,%esp
    262b:	68 fe 50 00 00       	push   $0x50fe
    2630:	6a 01                	push   $0x1
    2632:	e8 f9 13 00 00       	call   3a30 <printf>
      exit();
    2637:	e8 a6 12 00 00       	call   38e2 <exit>
      printf(1, "short read bigfile\n");
    263c:	83 ec 08             	sub    $0x8,%esp
    263f:	68 ea 50 00 00       	push   $0x50ea
    2644:	6a 01                	push   $0x1
    2646:	e8 e5 13 00 00       	call   3a30 <printf>
      exit();
    264b:	e8 92 12 00 00       	call   38e2 <exit>
      printf(1, "read bigfile failed\n");
    2650:	83 ec 08             	sub    $0x8,%esp
    2653:	68 d5 50 00 00       	push   $0x50d5
    2658:	6a 01                	push   $0x1
    265a:	e8 d1 13 00 00       	call   3a30 <printf>
      exit();
    265f:	e8 7e 12 00 00       	call   38e2 <exit>
      printf(1, "write bigfile failed\n");
    2664:	83 ec 08             	sub    $0x8,%esp
    2667:	68 aa 50 00 00       	push   $0x50aa
    266c:	6a 01                	push   $0x1
    266e:	e8 bd 13 00 00       	call   3a30 <printf>
      exit();
    2673:	e8 6a 12 00 00       	call   38e2 <exit>
    printf(1, "cannot open bigfile\n");
    2678:	53                   	push   %ebx
    2679:	53                   	push   %ebx
    267a:	68 c0 50 00 00       	push   $0x50c0
    267f:	6a 01                	push   $0x1
    2681:	e8 aa 13 00 00       	call   3a30 <printf>
    exit();
    2686:	e8 57 12 00 00       	call   38e2 <exit>
    printf(1, "cannot create bigfile");
    268b:	50                   	push   %eax
    268c:	50                   	push   %eax
    268d:	68 94 50 00 00       	push   $0x5094
    2692:	6a 01                	push   $0x1
    2694:	e8 97 13 00 00       	call   3a30 <printf>
    exit();
    2699:	e8 44 12 00 00       	call   38e2 <exit>
    printf(1, "read bigfile wrong total\n");
    269e:	51                   	push   %ecx
    269f:	51                   	push   %ecx
    26a0:	68 17 51 00 00       	push   $0x5117
    26a5:	6a 01                	push   $0x1
    26a7:	e8 84 13 00 00       	call   3a30 <printf>
    exit();
    26ac:	e8 31 12 00 00       	call   38e2 <exit>
    26b1:	eb 0d                	jmp    26c0 <fourteen>
    26b3:	90                   	nop
    26b4:	90                   	nop
    26b5:	90                   	nop
    26b6:	90                   	nop
    26b7:	90                   	nop
    26b8:	90                   	nop
    26b9:	90                   	nop
    26ba:	90                   	nop
    26bb:	90                   	nop
    26bc:	90                   	nop
    26bd:	90                   	nop
    26be:	90                   	nop
    26bf:	90                   	nop

000026c0 <fourteen>:
{
    26c0:	55                   	push   %ebp
    26c1:	89 e5                	mov    %esp,%ebp
    26c3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    26c6:	68 42 51 00 00       	push   $0x5142
    26cb:	6a 01                	push   $0x1
    26cd:	e8 5e 13 00 00       	call   3a30 <printf>
  if(mkdir("12345678901234") != 0){
    26d2:	c7 04 24 7d 51 00 00 	movl   $0x517d,(%esp)
    26d9:	e8 6c 12 00 00       	call   394a <mkdir>
    26de:	83 c4 10             	add    $0x10,%esp
    26e1:	85 c0                	test   %eax,%eax
    26e3:	0f 85 97 00 00 00    	jne    2780 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26e9:	83 ec 0c             	sub    $0xc,%esp
    26ec:	68 a8 41 00 00       	push   $0x41a8
    26f1:	e8 54 12 00 00       	call   394a <mkdir>
    26f6:	83 c4 10             	add    $0x10,%esp
    26f9:	85 c0                	test   %eax,%eax
    26fb:	0f 85 de 00 00 00    	jne    27df <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2701:	83 ec 08             	sub    $0x8,%esp
    2704:	68 00 02 00 00       	push   $0x200
    2709:	68 f8 41 00 00       	push   $0x41f8
    270e:	e8 0f 12 00 00       	call   3922 <open>
  if(fd < 0){
    2713:	83 c4 10             	add    $0x10,%esp
    2716:	85 c0                	test   %eax,%eax
    2718:	0f 88 ae 00 00 00    	js     27cc <fourteen+0x10c>
  close(fd);
    271e:	83 ec 0c             	sub    $0xc,%esp
    2721:	50                   	push   %eax
    2722:	e8 e3 11 00 00       	call   390a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2727:	58                   	pop    %eax
    2728:	5a                   	pop    %edx
    2729:	6a 00                	push   $0x0
    272b:	68 68 42 00 00       	push   $0x4268
    2730:	e8 ed 11 00 00       	call   3922 <open>
  if(fd < 0){
    2735:	83 c4 10             	add    $0x10,%esp
    2738:	85 c0                	test   %eax,%eax
    273a:	78 7d                	js     27b9 <fourteen+0xf9>
  close(fd);
    273c:	83 ec 0c             	sub    $0xc,%esp
    273f:	50                   	push   %eax
    2740:	e8 c5 11 00 00       	call   390a <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2745:	c7 04 24 6e 51 00 00 	movl   $0x516e,(%esp)
    274c:	e8 f9 11 00 00       	call   394a <mkdir>
    2751:	83 c4 10             	add    $0x10,%esp
    2754:	85 c0                	test   %eax,%eax
    2756:	74 4e                	je     27a6 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2758:	83 ec 0c             	sub    $0xc,%esp
    275b:	68 04 43 00 00       	push   $0x4304
    2760:	e8 e5 11 00 00       	call   394a <mkdir>
    2765:	83 c4 10             	add    $0x10,%esp
    2768:	85 c0                	test   %eax,%eax
    276a:	74 27                	je     2793 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    276c:	83 ec 08             	sub    $0x8,%esp
    276f:	68 8c 51 00 00       	push   $0x518c
    2774:	6a 01                	push   $0x1
    2776:	e8 b5 12 00 00       	call   3a30 <printf>
}
    277b:	83 c4 10             	add    $0x10,%esp
    277e:	c9                   	leave  
    277f:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2780:	50                   	push   %eax
    2781:	50                   	push   %eax
    2782:	68 51 51 00 00       	push   $0x5151
    2787:	6a 01                	push   $0x1
    2789:	e8 a2 12 00 00       	call   3a30 <printf>
    exit();
    278e:	e8 4f 11 00 00       	call   38e2 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2793:	50                   	push   %eax
    2794:	50                   	push   %eax
    2795:	68 24 43 00 00       	push   $0x4324
    279a:	6a 01                	push   $0x1
    279c:	e8 8f 12 00 00       	call   3a30 <printf>
    exit();
    27a1:	e8 3c 11 00 00       	call   38e2 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    27a6:	52                   	push   %edx
    27a7:	52                   	push   %edx
    27a8:	68 d4 42 00 00       	push   $0x42d4
    27ad:	6a 01                	push   $0x1
    27af:	e8 7c 12 00 00       	call   3a30 <printf>
    exit();
    27b4:	e8 29 11 00 00       	call   38e2 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27b9:	51                   	push   %ecx
    27ba:	51                   	push   %ecx
    27bb:	68 98 42 00 00       	push   $0x4298
    27c0:	6a 01                	push   $0x1
    27c2:	e8 69 12 00 00       	call   3a30 <printf>
    exit();
    27c7:	e8 16 11 00 00       	call   38e2 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27cc:	51                   	push   %ecx
    27cd:	51                   	push   %ecx
    27ce:	68 28 42 00 00       	push   $0x4228
    27d3:	6a 01                	push   $0x1
    27d5:	e8 56 12 00 00       	call   3a30 <printf>
    exit();
    27da:	e8 03 11 00 00       	call   38e2 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27df:	50                   	push   %eax
    27e0:	50                   	push   %eax
    27e1:	68 c8 41 00 00       	push   $0x41c8
    27e6:	6a 01                	push   $0x1
    27e8:	e8 43 12 00 00       	call   3a30 <printf>
    exit();
    27ed:	e8 f0 10 00 00       	call   38e2 <exit>
    27f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002800 <rmdot>:
{
    2800:	55                   	push   %ebp
    2801:	89 e5                	mov    %esp,%ebp
    2803:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    2806:	68 99 51 00 00       	push   $0x5199
    280b:	6a 01                	push   $0x1
    280d:	e8 1e 12 00 00       	call   3a30 <printf>
  if(mkdir("dots") != 0){
    2812:	c7 04 24 a5 51 00 00 	movl   $0x51a5,(%esp)
    2819:	e8 2c 11 00 00       	call   394a <mkdir>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 85 b0 00 00 00    	jne    28d9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2829:	83 ec 0c             	sub    $0xc,%esp
    282c:	68 a5 51 00 00       	push   $0x51a5
    2831:	e8 1c 11 00 00       	call   3952 <chdir>
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 85 1d 01 00 00    	jne    295e <rmdot+0x15e>
  if(unlink(".") == 0){
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	68 50 4e 00 00       	push   $0x4e50
    2849:	e8 e4 10 00 00       	call   3932 <unlink>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 84 f2 00 00 00    	je     294b <rmdot+0x14b>
  if(unlink("..") == 0){
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 4f 4e 00 00       	push   $0x4e4f
    2861:	e8 cc 10 00 00       	call   3932 <unlink>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	0f 84 c7 00 00 00    	je     2938 <rmdot+0x138>
  if(chdir("/") != 0){
    2871:	83 ec 0c             	sub    $0xc,%esp
    2874:	68 23 46 00 00       	push   $0x4623
    2879:	e8 d4 10 00 00       	call   3952 <chdir>
    287e:	83 c4 10             	add    $0x10,%esp
    2881:	85 c0                	test   %eax,%eax
    2883:	0f 85 9c 00 00 00    	jne    2925 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2889:	83 ec 0c             	sub    $0xc,%esp
    288c:	68 ed 51 00 00       	push   $0x51ed
    2891:	e8 9c 10 00 00       	call   3932 <unlink>
    2896:	83 c4 10             	add    $0x10,%esp
    2899:	85 c0                	test   %eax,%eax
    289b:	74 75                	je     2912 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    289d:	83 ec 0c             	sub    $0xc,%esp
    28a0:	68 0b 52 00 00       	push   $0x520b
    28a5:	e8 88 10 00 00       	call   3932 <unlink>
    28aa:	83 c4 10             	add    $0x10,%esp
    28ad:	85 c0                	test   %eax,%eax
    28af:	74 4e                	je     28ff <rmdot+0xff>
  if(unlink("dots") != 0){
    28b1:	83 ec 0c             	sub    $0xc,%esp
    28b4:	68 a5 51 00 00       	push   $0x51a5
    28b9:	e8 74 10 00 00       	call   3932 <unlink>
    28be:	83 c4 10             	add    $0x10,%esp
    28c1:	85 c0                	test   %eax,%eax
    28c3:	75 27                	jne    28ec <rmdot+0xec>
  printf(1, "rmdot ok\n");
    28c5:	83 ec 08             	sub    $0x8,%esp
    28c8:	68 40 52 00 00       	push   $0x5240
    28cd:	6a 01                	push   $0x1
    28cf:	e8 5c 11 00 00       	call   3a30 <printf>
}
    28d4:	83 c4 10             	add    $0x10,%esp
    28d7:	c9                   	leave  
    28d8:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    28d9:	50                   	push   %eax
    28da:	50                   	push   %eax
    28db:	68 aa 51 00 00       	push   $0x51aa
    28e0:	6a 01                	push   $0x1
    28e2:	e8 49 11 00 00       	call   3a30 <printf>
    exit();
    28e7:	e8 f6 0f 00 00       	call   38e2 <exit>
    printf(1, "unlink dots failed!\n");
    28ec:	50                   	push   %eax
    28ed:	50                   	push   %eax
    28ee:	68 2b 52 00 00       	push   $0x522b
    28f3:	6a 01                	push   $0x1
    28f5:	e8 36 11 00 00       	call   3a30 <printf>
    exit();
    28fa:	e8 e3 0f 00 00       	call   38e2 <exit>
    printf(1, "unlink dots/.. worked!\n");
    28ff:	52                   	push   %edx
    2900:	52                   	push   %edx
    2901:	68 13 52 00 00       	push   $0x5213
    2906:	6a 01                	push   $0x1
    2908:	e8 23 11 00 00       	call   3a30 <printf>
    exit();
    290d:	e8 d0 0f 00 00       	call   38e2 <exit>
    printf(1, "unlink dots/. worked!\n");
    2912:	51                   	push   %ecx
    2913:	51                   	push   %ecx
    2914:	68 f4 51 00 00       	push   $0x51f4
    2919:	6a 01                	push   $0x1
    291b:	e8 10 11 00 00       	call   3a30 <printf>
    exit();
    2920:	e8 bd 0f 00 00       	call   38e2 <exit>
    printf(1, "chdir / failed\n");
    2925:	50                   	push   %eax
    2926:	50                   	push   %eax
    2927:	68 25 46 00 00       	push   $0x4625
    292c:	6a 01                	push   $0x1
    292e:	e8 fd 10 00 00       	call   3a30 <printf>
    exit();
    2933:	e8 aa 0f 00 00       	call   38e2 <exit>
    printf(1, "rm .. worked!\n");
    2938:	50                   	push   %eax
    2939:	50                   	push   %eax
    293a:	68 de 51 00 00       	push   $0x51de
    293f:	6a 01                	push   $0x1
    2941:	e8 ea 10 00 00       	call   3a30 <printf>
    exit();
    2946:	e8 97 0f 00 00       	call   38e2 <exit>
    printf(1, "rm . worked!\n");
    294b:	50                   	push   %eax
    294c:	50                   	push   %eax
    294d:	68 d0 51 00 00       	push   $0x51d0
    2952:	6a 01                	push   $0x1
    2954:	e8 d7 10 00 00       	call   3a30 <printf>
    exit();
    2959:	e8 84 0f 00 00       	call   38e2 <exit>
    printf(1, "chdir dots failed\n");
    295e:	50                   	push   %eax
    295f:	50                   	push   %eax
    2960:	68 bd 51 00 00       	push   $0x51bd
    2965:	6a 01                	push   $0x1
    2967:	e8 c4 10 00 00       	call   3a30 <printf>
    exit();
    296c:	e8 71 0f 00 00       	call   38e2 <exit>
    2971:	eb 0d                	jmp    2980 <dirfile>
    2973:	90                   	nop
    2974:	90                   	nop
    2975:	90                   	nop
    2976:	90                   	nop
    2977:	90                   	nop
    2978:	90                   	nop
    2979:	90                   	nop
    297a:	90                   	nop
    297b:	90                   	nop
    297c:	90                   	nop
    297d:	90                   	nop
    297e:	90                   	nop
    297f:	90                   	nop

00002980 <dirfile>:
{
    2980:	55                   	push   %ebp
    2981:	89 e5                	mov    %esp,%ebp
    2983:	53                   	push   %ebx
    2984:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2987:	68 4a 52 00 00       	push   $0x524a
    298c:	6a 01                	push   $0x1
    298e:	e8 9d 10 00 00       	call   3a30 <printf>
  fd = open("dirfile", O_CREATE);
    2993:	59                   	pop    %ecx
    2994:	5b                   	pop    %ebx
    2995:	68 00 02 00 00       	push   $0x200
    299a:	68 57 52 00 00       	push   $0x5257
    299f:	e8 7e 0f 00 00       	call   3922 <open>
  if(fd < 0){
    29a4:	83 c4 10             	add    $0x10,%esp
    29a7:	85 c0                	test   %eax,%eax
    29a9:	0f 88 43 01 00 00    	js     2af2 <dirfile+0x172>
  close(fd);
    29af:	83 ec 0c             	sub    $0xc,%esp
    29b2:	50                   	push   %eax
    29b3:	e8 52 0f 00 00       	call   390a <close>
  if(chdir("dirfile") == 0){
    29b8:	c7 04 24 57 52 00 00 	movl   $0x5257,(%esp)
    29bf:	e8 8e 0f 00 00       	call   3952 <chdir>
    29c4:	83 c4 10             	add    $0x10,%esp
    29c7:	85 c0                	test   %eax,%eax
    29c9:	0f 84 10 01 00 00    	je     2adf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    29cf:	83 ec 08             	sub    $0x8,%esp
    29d2:	6a 00                	push   $0x0
    29d4:	68 90 52 00 00       	push   $0x5290
    29d9:	e8 44 0f 00 00       	call   3922 <open>
  if(fd >= 0){
    29de:	83 c4 10             	add    $0x10,%esp
    29e1:	85 c0                	test   %eax,%eax
    29e3:	0f 89 e3 00 00 00    	jns    2acc <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    29e9:	83 ec 08             	sub    $0x8,%esp
    29ec:	68 00 02 00 00       	push   $0x200
    29f1:	68 90 52 00 00       	push   $0x5290
    29f6:	e8 27 0f 00 00       	call   3922 <open>
  if(fd >= 0){
    29fb:	83 c4 10             	add    $0x10,%esp
    29fe:	85 c0                	test   %eax,%eax
    2a00:	0f 89 c6 00 00 00    	jns    2acc <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    2a06:	83 ec 0c             	sub    $0xc,%esp
    2a09:	68 90 52 00 00       	push   $0x5290
    2a0e:	e8 37 0f 00 00       	call   394a <mkdir>
    2a13:	83 c4 10             	add    $0x10,%esp
    2a16:	85 c0                	test   %eax,%eax
    2a18:	0f 84 46 01 00 00    	je     2b64 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    2a1e:	83 ec 0c             	sub    $0xc,%esp
    2a21:	68 90 52 00 00       	push   $0x5290
    2a26:	e8 07 0f 00 00       	call   3932 <unlink>
    2a2b:	83 c4 10             	add    $0x10,%esp
    2a2e:	85 c0                	test   %eax,%eax
    2a30:	0f 84 1b 01 00 00    	je     2b51 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a36:	83 ec 08             	sub    $0x8,%esp
    2a39:	68 90 52 00 00       	push   $0x5290
    2a3e:	68 f4 52 00 00       	push   $0x52f4
    2a43:	e8 fa 0e 00 00       	call   3942 <link>
    2a48:	83 c4 10             	add    $0x10,%esp
    2a4b:	85 c0                	test   %eax,%eax
    2a4d:	0f 84 eb 00 00 00    	je     2b3e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a53:	83 ec 0c             	sub    $0xc,%esp
    2a56:	68 57 52 00 00       	push   $0x5257
    2a5b:	e8 d2 0e 00 00       	call   3932 <unlink>
    2a60:	83 c4 10             	add    $0x10,%esp
    2a63:	85 c0                	test   %eax,%eax
    2a65:	0f 85 c0 00 00 00    	jne    2b2b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a6b:	83 ec 08             	sub    $0x8,%esp
    2a6e:	6a 02                	push   $0x2
    2a70:	68 50 4e 00 00       	push   $0x4e50
    2a75:	e8 a8 0e 00 00       	call   3922 <open>
  if(fd >= 0){
    2a7a:	83 c4 10             	add    $0x10,%esp
    2a7d:	85 c0                	test   %eax,%eax
    2a7f:	0f 89 93 00 00 00    	jns    2b18 <dirfile+0x198>
  fd = open(".", 0);
    2a85:	83 ec 08             	sub    $0x8,%esp
    2a88:	6a 00                	push   $0x0
    2a8a:	68 50 4e 00 00       	push   $0x4e50
    2a8f:	e8 8e 0e 00 00       	call   3922 <open>
  if(write(fd, "x", 1) > 0){
    2a94:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", 0);
    2a97:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a99:	6a 01                	push   $0x1
    2a9b:	68 33 4f 00 00       	push   $0x4f33
    2aa0:	50                   	push   %eax
    2aa1:	e8 5c 0e 00 00       	call   3902 <write>
    2aa6:	83 c4 10             	add    $0x10,%esp
    2aa9:	85 c0                	test   %eax,%eax
    2aab:	7f 58                	jg     2b05 <dirfile+0x185>
  close(fd);
    2aad:	83 ec 0c             	sub    $0xc,%esp
    2ab0:	53                   	push   %ebx
    2ab1:	e8 54 0e 00 00       	call   390a <close>
  printf(1, "dir vs file OK\n");
    2ab6:	58                   	pop    %eax
    2ab7:	5a                   	pop    %edx
    2ab8:	68 27 53 00 00       	push   $0x5327
    2abd:	6a 01                	push   $0x1
    2abf:	e8 6c 0f 00 00       	call   3a30 <printf>
}
    2ac4:	83 c4 10             	add    $0x10,%esp
    2ac7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2aca:	c9                   	leave  
    2acb:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2acc:	50                   	push   %eax
    2acd:	50                   	push   %eax
    2ace:	68 9b 52 00 00       	push   $0x529b
    2ad3:	6a 01                	push   $0x1
    2ad5:	e8 56 0f 00 00       	call   3a30 <printf>
    exit();
    2ada:	e8 03 0e 00 00       	call   38e2 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2adf:	50                   	push   %eax
    2ae0:	50                   	push   %eax
    2ae1:	68 76 52 00 00       	push   $0x5276
    2ae6:	6a 01                	push   $0x1
    2ae8:	e8 43 0f 00 00       	call   3a30 <printf>
    exit();
    2aed:	e8 f0 0d 00 00       	call   38e2 <exit>
    printf(1, "create dirfile failed\n");
    2af2:	52                   	push   %edx
    2af3:	52                   	push   %edx
    2af4:	68 5f 52 00 00       	push   $0x525f
    2af9:	6a 01                	push   $0x1
    2afb:	e8 30 0f 00 00       	call   3a30 <printf>
    exit();
    2b00:	e8 dd 0d 00 00       	call   38e2 <exit>
    printf(1, "write . succeeded!\n");
    2b05:	51                   	push   %ecx
    2b06:	51                   	push   %ecx
    2b07:	68 13 53 00 00       	push   $0x5313
    2b0c:	6a 01                	push   $0x1
    2b0e:	e8 1d 0f 00 00       	call   3a30 <printf>
    exit();
    2b13:	e8 ca 0d 00 00       	call   38e2 <exit>
    printf(1, "open . for writing succeeded!\n");
    2b18:	53                   	push   %ebx
    2b19:	53                   	push   %ebx
    2b1a:	68 78 43 00 00       	push   $0x4378
    2b1f:	6a 01                	push   $0x1
    2b21:	e8 0a 0f 00 00       	call   3a30 <printf>
    exit();
    2b26:	e8 b7 0d 00 00       	call   38e2 <exit>
    printf(1, "unlink dirfile failed!\n");
    2b2b:	50                   	push   %eax
    2b2c:	50                   	push   %eax
    2b2d:	68 fb 52 00 00       	push   $0x52fb
    2b32:	6a 01                	push   $0x1
    2b34:	e8 f7 0e 00 00       	call   3a30 <printf>
    exit();
    2b39:	e8 a4 0d 00 00       	call   38e2 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b3e:	50                   	push   %eax
    2b3f:	50                   	push   %eax
    2b40:	68 58 43 00 00       	push   $0x4358
    2b45:	6a 01                	push   $0x1
    2b47:	e8 e4 0e 00 00       	call   3a30 <printf>
    exit();
    2b4c:	e8 91 0d 00 00       	call   38e2 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b51:	50                   	push   %eax
    2b52:	50                   	push   %eax
    2b53:	68 d6 52 00 00       	push   $0x52d6
    2b58:	6a 01                	push   $0x1
    2b5a:	e8 d1 0e 00 00       	call   3a30 <printf>
    exit();
    2b5f:	e8 7e 0d 00 00       	call   38e2 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b64:	50                   	push   %eax
    2b65:	50                   	push   %eax
    2b66:	68 b9 52 00 00       	push   $0x52b9
    2b6b:	6a 01                	push   $0x1
    2b6d:	e8 be 0e 00 00       	call   3a30 <printf>
    exit();
    2b72:	e8 6b 0d 00 00       	call   38e2 <exit>
    2b77:	89 f6                	mov    %esi,%esi
    2b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b80 <iref>:
{
    2b80:	55                   	push   %ebp
    2b81:	89 e5                	mov    %esp,%ebp
    2b83:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b84:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b89:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2b8c:	68 37 53 00 00       	push   $0x5337
    2b91:	6a 01                	push   $0x1
    2b93:	e8 98 0e 00 00       	call   3a30 <printf>
    2b98:	83 c4 10             	add    $0x10,%esp
    2b9b:	90                   	nop
    2b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(mkdir("irefd") != 0){
    2ba0:	83 ec 0c             	sub    $0xc,%esp
    2ba3:	68 48 53 00 00       	push   $0x5348
    2ba8:	e8 9d 0d 00 00       	call   394a <mkdir>
    2bad:	83 c4 10             	add    $0x10,%esp
    2bb0:	85 c0                	test   %eax,%eax
    2bb2:	0f 85 bb 00 00 00    	jne    2c73 <iref+0xf3>
    if(chdir("irefd") != 0){
    2bb8:	83 ec 0c             	sub    $0xc,%esp
    2bbb:	68 48 53 00 00       	push   $0x5348
    2bc0:	e8 8d 0d 00 00       	call   3952 <chdir>
    2bc5:	83 c4 10             	add    $0x10,%esp
    2bc8:	85 c0                	test   %eax,%eax
    2bca:	0f 85 b7 00 00 00    	jne    2c87 <iref+0x107>
    mkdir("");
    2bd0:	83 ec 0c             	sub    $0xc,%esp
    2bd3:	68 fd 49 00 00       	push   $0x49fd
    2bd8:	e8 6d 0d 00 00       	call   394a <mkdir>
    link("README", "");
    2bdd:	59                   	pop    %ecx
    2bde:	58                   	pop    %eax
    2bdf:	68 fd 49 00 00       	push   $0x49fd
    2be4:	68 f4 52 00 00       	push   $0x52f4
    2be9:	e8 54 0d 00 00       	call   3942 <link>
    fd = open("", O_CREATE);
    2bee:	58                   	pop    %eax
    2bef:	5a                   	pop    %edx
    2bf0:	68 00 02 00 00       	push   $0x200
    2bf5:	68 fd 49 00 00       	push   $0x49fd
    2bfa:	e8 23 0d 00 00       	call   3922 <open>
    if(fd >= 0)
    2bff:	83 c4 10             	add    $0x10,%esp
    2c02:	85 c0                	test   %eax,%eax
    2c04:	78 0c                	js     2c12 <iref+0x92>
      close(fd);
    2c06:	83 ec 0c             	sub    $0xc,%esp
    2c09:	50                   	push   %eax
    2c0a:	e8 fb 0c 00 00       	call   390a <close>
    2c0f:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2c12:	83 ec 08             	sub    $0x8,%esp
    2c15:	68 00 02 00 00       	push   $0x200
    2c1a:	68 32 4f 00 00       	push   $0x4f32
    2c1f:	e8 fe 0c 00 00       	call   3922 <open>
    if(fd >= 0)
    2c24:	83 c4 10             	add    $0x10,%esp
    2c27:	85 c0                	test   %eax,%eax
    2c29:	78 0c                	js     2c37 <iref+0xb7>
      close(fd);
    2c2b:	83 ec 0c             	sub    $0xc,%esp
    2c2e:	50                   	push   %eax
    2c2f:	e8 d6 0c 00 00       	call   390a <close>
    2c34:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c37:	83 ec 0c             	sub    $0xc,%esp
    2c3a:	68 32 4f 00 00       	push   $0x4f32
    2c3f:	e8 ee 0c 00 00       	call   3932 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2c44:	83 c4 10             	add    $0x10,%esp
    2c47:	83 eb 01             	sub    $0x1,%ebx
    2c4a:	0f 85 50 ff ff ff    	jne    2ba0 <iref+0x20>
  chdir("/");
    2c50:	83 ec 0c             	sub    $0xc,%esp
    2c53:	68 23 46 00 00       	push   $0x4623
    2c58:	e8 f5 0c 00 00       	call   3952 <chdir>
  printf(1, "empty file name OK\n");
    2c5d:	58                   	pop    %eax
    2c5e:	5a                   	pop    %edx
    2c5f:	68 76 53 00 00       	push   $0x5376
    2c64:	6a 01                	push   $0x1
    2c66:	e8 c5 0d 00 00       	call   3a30 <printf>
}
    2c6b:	83 c4 10             	add    $0x10,%esp
    2c6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c71:	c9                   	leave  
    2c72:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2c73:	83 ec 08             	sub    $0x8,%esp
    2c76:	68 4e 53 00 00       	push   $0x534e
    2c7b:	6a 01                	push   $0x1
    2c7d:	e8 ae 0d 00 00       	call   3a30 <printf>
      exit();
    2c82:	e8 5b 0c 00 00       	call   38e2 <exit>
      printf(1, "chdir irefd failed\n");
    2c87:	83 ec 08             	sub    $0x8,%esp
    2c8a:	68 62 53 00 00       	push   $0x5362
    2c8f:	6a 01                	push   $0x1
    2c91:	e8 9a 0d 00 00       	call   3a30 <printf>
      exit();
    2c96:	e8 47 0c 00 00       	call   38e2 <exit>
    2c9b:	90                   	nop
    2c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002ca0 <forktest>:
{
    2ca0:	55                   	push   %ebp
    2ca1:	89 e5                	mov    %esp,%ebp
    2ca3:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2ca4:	31 db                	xor    %ebx,%ebx
{
    2ca6:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2ca9:	68 8a 53 00 00       	push   $0x538a
    2cae:	6a 01                	push   $0x1
    2cb0:	e8 7b 0d 00 00       	call   3a30 <printf>
    2cb5:	83 c4 10             	add    $0x10,%esp
    2cb8:	eb 13                	jmp    2ccd <forktest+0x2d>
    2cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    2cc0:	74 62                	je     2d24 <forktest+0x84>
  for(n=0; n<1000; n++){
    2cc2:	83 c3 01             	add    $0x1,%ebx
    2cc5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2ccb:	74 43                	je     2d10 <forktest+0x70>
    pid = fork();
    2ccd:	e8 08 0c 00 00       	call   38da <fork>
    if(pid < 0)
    2cd2:	85 c0                	test   %eax,%eax
    2cd4:	79 ea                	jns    2cc0 <forktest+0x20>
  for(; n > 0; n--){
    2cd6:	85 db                	test   %ebx,%ebx
    2cd8:	74 14                	je     2cee <forktest+0x4e>
    2cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2ce0:	e8 05 0c 00 00       	call   38ea <wait>
    2ce5:	85 c0                	test   %eax,%eax
    2ce7:	78 40                	js     2d29 <forktest+0x89>
  for(; n > 0; n--){
    2ce9:	83 eb 01             	sub    $0x1,%ebx
    2cec:	75 f2                	jne    2ce0 <forktest+0x40>
  if(wait() != -1){
    2cee:	e8 f7 0b 00 00       	call   38ea <wait>
    2cf3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cf6:	75 45                	jne    2d3d <forktest+0x9d>
  printf(1, "fork test OK\n");
    2cf8:	83 ec 08             	sub    $0x8,%esp
    2cfb:	68 bc 53 00 00       	push   $0x53bc
    2d00:	6a 01                	push   $0x1
    2d02:	e8 29 0d 00 00       	call   3a30 <printf>
}
    2d07:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2d0a:	c9                   	leave  
    2d0b:	c3                   	ret    
    2d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "fork claimed to work 1000 times!\n");
    2d10:	83 ec 08             	sub    $0x8,%esp
    2d13:	68 98 43 00 00       	push   $0x4398
    2d18:	6a 01                	push   $0x1
    2d1a:	e8 11 0d 00 00       	call   3a30 <printf>
    exit();
    2d1f:	e8 be 0b 00 00       	call   38e2 <exit>
      exit();
    2d24:	e8 b9 0b 00 00       	call   38e2 <exit>
      printf(1, "wait stopped early\n");
    2d29:	83 ec 08             	sub    $0x8,%esp
    2d2c:	68 95 53 00 00       	push   $0x5395
    2d31:	6a 01                	push   $0x1
    2d33:	e8 f8 0c 00 00       	call   3a30 <printf>
      exit();
    2d38:	e8 a5 0b 00 00       	call   38e2 <exit>
    printf(1, "wait got too many\n");
    2d3d:	50                   	push   %eax
    2d3e:	50                   	push   %eax
    2d3f:	68 a9 53 00 00       	push   $0x53a9
    2d44:	6a 01                	push   $0x1
    2d46:	e8 e5 0c 00 00       	call   3a30 <printf>
    exit();
    2d4b:	e8 92 0b 00 00       	call   38e2 <exit>

00002d50 <sbrktest>:
{
    2d50:	55                   	push   %ebp
    2d51:	89 e5                	mov    %esp,%ebp
    2d53:	57                   	push   %edi
    2d54:	56                   	push   %esi
    2d55:	53                   	push   %ebx
  for(i = 0; i < 5000; i++){
    2d56:	31 ff                	xor    %edi,%edi
{
    2d58:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2d5b:	68 ca 53 00 00       	push   $0x53ca
    2d60:	ff 35 10 5f 00 00    	pushl  0x5f10
    2d66:	e8 c5 0c 00 00       	call   3a30 <printf>
  oldbrk = sbrk(0);
    2d6b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d72:	e8 f3 0b 00 00       	call   396a <sbrk>
  a = sbrk(0);
    2d77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    2d7e:	89 c3                	mov    %eax,%ebx
  a = sbrk(0);
    2d80:	e8 e5 0b 00 00       	call   396a <sbrk>
    2d85:	83 c4 10             	add    $0x10,%esp
    2d88:	89 c6                	mov    %eax,%esi
    2d8a:	eb 06                	jmp    2d92 <sbrktest+0x42>
    2d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    a = b + 1;
    2d90:	89 c6                	mov    %eax,%esi
    b = sbrk(1);
    2d92:	83 ec 0c             	sub    $0xc,%esp
    2d95:	6a 01                	push   $0x1
    2d97:	e8 ce 0b 00 00       	call   396a <sbrk>
    if(b != a){
    2d9c:	83 c4 10             	add    $0x10,%esp
    2d9f:	39 f0                	cmp    %esi,%eax
    2da1:	0f 85 62 02 00 00    	jne    3009 <sbrktest+0x2b9>
  for(i = 0; i < 5000; i++){
    2da7:	83 c7 01             	add    $0x1,%edi
    *b = 1;
    2daa:	c6 06 01             	movb   $0x1,(%esi)
    a = b + 1;
    2dad:	8d 46 01             	lea    0x1(%esi),%eax
  for(i = 0; i < 5000; i++){
    2db0:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2db6:	75 d8                	jne    2d90 <sbrktest+0x40>
  pid = fork();
    2db8:	e8 1d 0b 00 00       	call   38da <fork>
  if(pid < 0){
    2dbd:	85 c0                	test   %eax,%eax
  pid = fork();
    2dbf:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2dc1:	0f 88 82 03 00 00    	js     3149 <sbrktest+0x3f9>
  c = sbrk(1);
    2dc7:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2dca:	83 c6 02             	add    $0x2,%esi
  c = sbrk(1);
    2dcd:	6a 01                	push   $0x1
    2dcf:	e8 96 0b 00 00       	call   396a <sbrk>
  c = sbrk(1);
    2dd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ddb:	e8 8a 0b 00 00       	call   396a <sbrk>
  if(c != a + 1){
    2de0:	83 c4 10             	add    $0x10,%esp
    2de3:	39 f0                	cmp    %esi,%eax
    2de5:	0f 85 47 03 00 00    	jne    3132 <sbrktest+0x3e2>
  if(pid == 0)
    2deb:	85 ff                	test   %edi,%edi
    2ded:	0f 84 3a 03 00 00    	je     312d <sbrktest+0x3dd>
  wait();
    2df3:	e8 f2 0a 00 00       	call   38ea <wait>
  a = sbrk(0);
    2df8:	83 ec 0c             	sub    $0xc,%esp
    2dfb:	6a 00                	push   $0x0
    2dfd:	e8 68 0b 00 00       	call   396a <sbrk>
    2e02:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
    2e04:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2e09:	29 f0                	sub    %esi,%eax
  p = sbrk(amt);
    2e0b:	89 04 24             	mov    %eax,(%esp)
    2e0e:	e8 57 0b 00 00       	call   396a <sbrk>
  if (p != a) {
    2e13:	83 c4 10             	add    $0x10,%esp
    2e16:	39 c6                	cmp    %eax,%esi
    2e18:	0f 85 f8 02 00 00    	jne    3116 <sbrktest+0x3c6>
  a = sbrk(0);
    2e1e:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    2e21:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2e28:	6a 00                	push   $0x0
    2e2a:	e8 3b 0b 00 00       	call   396a <sbrk>
  c = sbrk(-4096);
    2e2f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2e36:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    2e38:	e8 2d 0b 00 00       	call   396a <sbrk>
  if(c == (char*)0xffffffff){
    2e3d:	83 c4 10             	add    $0x10,%esp
    2e40:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e43:	0f 84 b6 02 00 00    	je     30ff <sbrktest+0x3af>
  c = sbrk(0);
    2e49:	83 ec 0c             	sub    $0xc,%esp
    2e4c:	6a 00                	push   $0x0
    2e4e:	e8 17 0b 00 00       	call   396a <sbrk>
  if(c != a - 4096){
    2e53:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2e59:	83 c4 10             	add    $0x10,%esp
    2e5c:	39 d0                	cmp    %edx,%eax
    2e5e:	0f 85 84 02 00 00    	jne    30e8 <sbrktest+0x398>
  a = sbrk(0);
    2e64:	83 ec 0c             	sub    $0xc,%esp
    2e67:	6a 00                	push   $0x0
    2e69:	e8 fc 0a 00 00       	call   396a <sbrk>
    2e6e:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    2e70:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e77:	e8 ee 0a 00 00       	call   396a <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e7c:	83 c4 10             	add    $0x10,%esp
    2e7f:	39 c6                	cmp    %eax,%esi
  c = sbrk(4096);
    2e81:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    2e83:	0f 85 48 02 00 00    	jne    30d1 <sbrktest+0x381>
    2e89:	83 ec 0c             	sub    $0xc,%esp
    2e8c:	6a 00                	push   $0x0
    2e8e:	e8 d7 0a 00 00       	call   396a <sbrk>
    2e93:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2e99:	83 c4 10             	add    $0x10,%esp
    2e9c:	39 d0                	cmp    %edx,%eax
    2e9e:	0f 85 2d 02 00 00    	jne    30d1 <sbrktest+0x381>
  if(*lastaddr == 99){
    2ea4:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2eab:	0f 84 09 02 00 00    	je     30ba <sbrktest+0x36a>
  a = sbrk(0);
    2eb1:	83 ec 0c             	sub    $0xc,%esp
    2eb4:	6a 00                	push   $0x0
    2eb6:	e8 af 0a 00 00       	call   396a <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2ebb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2ec2:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    2ec4:	e8 a1 0a 00 00       	call   396a <sbrk>
    2ec9:	89 d9                	mov    %ebx,%ecx
    2ecb:	29 c1                	sub    %eax,%ecx
    2ecd:	89 0c 24             	mov    %ecx,(%esp)
    2ed0:	e8 95 0a 00 00       	call   396a <sbrk>
  if(c != a){
    2ed5:	83 c4 10             	add    $0x10,%esp
    2ed8:	39 c6                	cmp    %eax,%esi
    2eda:	0f 85 c3 01 00 00    	jne    30a3 <sbrktest+0x353>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ee0:	be 00 00 00 80       	mov    $0x80000000,%esi
    ppid = getpid();
    2ee5:	e8 78 0a 00 00       	call   3962 <getpid>
    2eea:	89 c7                	mov    %eax,%edi
    pid = fork();
    2eec:	e8 e9 09 00 00       	call   38da <fork>
    if(pid < 0){
    2ef1:	85 c0                	test   %eax,%eax
    2ef3:	0f 88 93 01 00 00    	js     308c <sbrktest+0x33c>
    if(pid == 0){
    2ef9:	0f 84 6b 01 00 00    	je     306a <sbrktest+0x31a>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eff:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    wait();
    2f05:	e8 e0 09 00 00       	call   38ea <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2f0a:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2f10:	75 d3                	jne    2ee5 <sbrktest+0x195>
  if(pipe(fds) != 0){
    2f12:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f15:	83 ec 0c             	sub    $0xc,%esp
    2f18:	50                   	push   %eax
    2f19:	e8 d4 09 00 00       	call   38f2 <pipe>
    2f1e:	83 c4 10             	add    $0x10,%esp
    2f21:	85 c0                	test   %eax,%eax
    2f23:	0f 85 2e 01 00 00    	jne    3057 <sbrktest+0x307>
    2f29:	8d 7d c0             	lea    -0x40(%ebp),%edi
    2f2c:	89 fe                	mov    %edi,%esi
    2f2e:	eb 23                	jmp    2f53 <sbrktest+0x203>
    if(pids[i] != -1)
    2f30:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f33:	74 14                	je     2f49 <sbrktest+0x1f9>
      read(fds[0], &scratch, 1);
    2f35:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f38:	83 ec 04             	sub    $0x4,%esp
    2f3b:	6a 01                	push   $0x1
    2f3d:	50                   	push   %eax
    2f3e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f41:	e8 b4 09 00 00       	call   38fa <read>
    2f46:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f49:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f4c:	83 c6 04             	add    $0x4,%esi
    2f4f:	39 c6                	cmp    %eax,%esi
    2f51:	74 4f                	je     2fa2 <sbrktest+0x252>
    if((pids[i] = fork()) == 0){
    2f53:	e8 82 09 00 00       	call   38da <fork>
    2f58:	85 c0                	test   %eax,%eax
    2f5a:	89 06                	mov    %eax,(%esi)
    2f5c:	75 d2                	jne    2f30 <sbrktest+0x1e0>
      sbrk(BIG - (uint)sbrk(0));
    2f5e:	83 ec 0c             	sub    $0xc,%esp
    2f61:	6a 00                	push   $0x0
    2f63:	e8 02 0a 00 00       	call   396a <sbrk>
    2f68:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f6d:	29 c2                	sub    %eax,%edx
    2f6f:	89 14 24             	mov    %edx,(%esp)
    2f72:	e8 f3 09 00 00       	call   396a <sbrk>
      write(fds[1], "x", 1);
    2f77:	83 c4 0c             	add    $0xc,%esp
    2f7a:	6a 01                	push   $0x1
    2f7c:	68 33 4f 00 00       	push   $0x4f33
    2f81:	ff 75 bc             	pushl  -0x44(%ebp)
    2f84:	e8 79 09 00 00       	call   3902 <write>
    2f89:	83 c4 10             	add    $0x10,%esp
    2f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(;;) sleep(1000);
    2f90:	83 ec 0c             	sub    $0xc,%esp
    2f93:	68 e8 03 00 00       	push   $0x3e8
    2f98:	e8 d5 09 00 00       	call   3972 <sleep>
    2f9d:	83 c4 10             	add    $0x10,%esp
    2fa0:	eb ee                	jmp    2f90 <sbrktest+0x240>
  c = sbrk(4096);
    2fa2:	83 ec 0c             	sub    $0xc,%esp
    2fa5:	68 00 10 00 00       	push   $0x1000
    2faa:	e8 bb 09 00 00       	call   396a <sbrk>
    2faf:	83 c4 10             	add    $0x10,%esp
    2fb2:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    if(pids[i] == -1)
    2fb5:	8b 07                	mov    (%edi),%eax
    2fb7:	83 f8 ff             	cmp    $0xffffffff,%eax
    2fba:	74 11                	je     2fcd <sbrktest+0x27d>
    kill(pids[i]);
    2fbc:	83 ec 0c             	sub    $0xc,%esp
    2fbf:	50                   	push   %eax
    2fc0:	e8 4d 09 00 00       	call   3912 <kill>
    wait();
    2fc5:	e8 20 09 00 00       	call   38ea <wait>
    2fca:	83 c4 10             	add    $0x10,%esp
    2fcd:	83 c7 04             	add    $0x4,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2fd0:	39 fe                	cmp    %edi,%esi
    2fd2:	75 e1                	jne    2fb5 <sbrktest+0x265>
  if(c == (char*)0xffffffff){
    2fd4:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2fd8:	74 66                	je     3040 <sbrktest+0x2f0>
  if(sbrk(0) > oldbrk)
    2fda:	83 ec 0c             	sub    $0xc,%esp
    2fdd:	6a 00                	push   $0x0
    2fdf:	e8 86 09 00 00       	call   396a <sbrk>
    2fe4:	83 c4 10             	add    $0x10,%esp
    2fe7:	39 d8                	cmp    %ebx,%eax
    2fe9:	77 3c                	ja     3027 <sbrktest+0x2d7>
  printf(stdout, "sbrk test OK\n");
    2feb:	83 ec 08             	sub    $0x8,%esp
    2fee:	68 72 54 00 00       	push   $0x5472
    2ff3:	ff 35 10 5f 00 00    	pushl  0x5f10
    2ff9:	e8 32 0a 00 00       	call   3a30 <printf>
}
    2ffe:	83 c4 10             	add    $0x10,%esp
    3001:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3004:	5b                   	pop    %ebx
    3005:	5e                   	pop    %esi
    3006:	5f                   	pop    %edi
    3007:	5d                   	pop    %ebp
    3008:	c3                   	ret    
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3009:	83 ec 0c             	sub    $0xc,%esp
    300c:	50                   	push   %eax
    300d:	56                   	push   %esi
    300e:	57                   	push   %edi
    300f:	68 d5 53 00 00       	push   $0x53d5
    3014:	ff 35 10 5f 00 00    	pushl  0x5f10
    301a:	e8 11 0a 00 00       	call   3a30 <printf>
      exit();
    301f:	83 c4 20             	add    $0x20,%esp
    3022:	e8 bb 08 00 00       	call   38e2 <exit>
    sbrk(-(sbrk(0) - oldbrk));
    3027:	83 ec 0c             	sub    $0xc,%esp
    302a:	6a 00                	push   $0x0
    302c:	e8 39 09 00 00       	call   396a <sbrk>
    3031:	29 c3                	sub    %eax,%ebx
    3033:	89 1c 24             	mov    %ebx,(%esp)
    3036:	e8 2f 09 00 00       	call   396a <sbrk>
    303b:	83 c4 10             	add    $0x10,%esp
    303e:	eb ab                	jmp    2feb <sbrktest+0x29b>
    printf(stdout, "failed sbrk leaked memory\n");
    3040:	50                   	push   %eax
    3041:	50                   	push   %eax
    3042:	68 57 54 00 00       	push   $0x5457
    3047:	ff 35 10 5f 00 00    	pushl  0x5f10
    304d:	e8 de 09 00 00       	call   3a30 <printf>
    exit();
    3052:	e8 8b 08 00 00       	call   38e2 <exit>
    printf(1, "pipe() failed\n");
    3057:	52                   	push   %edx
    3058:	52                   	push   %edx
    3059:	68 13 49 00 00       	push   $0x4913
    305e:	6a 01                	push   $0x1
    3060:	e8 cb 09 00 00       	call   3a30 <printf>
    exit();
    3065:	e8 78 08 00 00       	call   38e2 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    306a:	0f be 06             	movsbl (%esi),%eax
    306d:	50                   	push   %eax
    306e:	56                   	push   %esi
    306f:	68 3e 54 00 00       	push   $0x543e
    3074:	ff 35 10 5f 00 00    	pushl  0x5f10
    307a:	e8 b1 09 00 00       	call   3a30 <printf>
      kill(ppid);
    307f:	89 3c 24             	mov    %edi,(%esp)
    3082:	e8 8b 08 00 00       	call   3912 <kill>
      exit();
    3087:	e8 56 08 00 00       	call   38e2 <exit>
      printf(stdout, "fork failed\n");
    308c:	51                   	push   %ecx
    308d:	51                   	push   %ecx
    308e:	68 1b 55 00 00       	push   $0x551b
    3093:	ff 35 10 5f 00 00    	pushl  0x5f10
    3099:	e8 92 09 00 00       	call   3a30 <printf>
      exit();
    309e:	e8 3f 08 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    30a3:	50                   	push   %eax
    30a4:	56                   	push   %esi
    30a5:	68 8c 44 00 00       	push   $0x448c
    30aa:	ff 35 10 5f 00 00    	pushl  0x5f10
    30b0:	e8 7b 09 00 00       	call   3a30 <printf>
    exit();
    30b5:	e8 28 08 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    30ba:	53                   	push   %ebx
    30bb:	53                   	push   %ebx
    30bc:	68 5c 44 00 00       	push   $0x445c
    30c1:	ff 35 10 5f 00 00    	pushl  0x5f10
    30c7:	e8 64 09 00 00       	call   3a30 <printf>
    exit();
    30cc:	e8 11 08 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    30d1:	57                   	push   %edi
    30d2:	56                   	push   %esi
    30d3:	68 34 44 00 00       	push   $0x4434
    30d8:	ff 35 10 5f 00 00    	pushl  0x5f10
    30de:	e8 4d 09 00 00       	call   3a30 <printf>
    exit();
    30e3:	e8 fa 07 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    30e8:	50                   	push   %eax
    30e9:	56                   	push   %esi
    30ea:	68 fc 43 00 00       	push   $0x43fc
    30ef:	ff 35 10 5f 00 00    	pushl  0x5f10
    30f5:	e8 36 09 00 00       	call   3a30 <printf>
    exit();
    30fa:	e8 e3 07 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    30ff:	56                   	push   %esi
    3100:	56                   	push   %esi
    3101:	68 23 54 00 00       	push   $0x5423
    3106:	ff 35 10 5f 00 00    	pushl  0x5f10
    310c:	e8 1f 09 00 00       	call   3a30 <printf>
    exit();
    3111:	e8 cc 07 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3116:	57                   	push   %edi
    3117:	57                   	push   %edi
    3118:	68 bc 43 00 00       	push   $0x43bc
    311d:	ff 35 10 5f 00 00    	pushl  0x5f10
    3123:	e8 08 09 00 00       	call   3a30 <printf>
    exit();
    3128:	e8 b5 07 00 00       	call   38e2 <exit>
    exit();
    312d:	e8 b0 07 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3132:	50                   	push   %eax
    3133:	50                   	push   %eax
    3134:	68 07 54 00 00       	push   $0x5407
    3139:	ff 35 10 5f 00 00    	pushl  0x5f10
    313f:	e8 ec 08 00 00       	call   3a30 <printf>
    exit();
    3144:	e8 99 07 00 00       	call   38e2 <exit>
    printf(stdout, "sbrk test fork failed\n");
    3149:	50                   	push   %eax
    314a:	50                   	push   %eax
    314b:	68 f0 53 00 00       	push   $0x53f0
    3150:	ff 35 10 5f 00 00    	pushl  0x5f10
    3156:	e8 d5 08 00 00       	call   3a30 <printf>
    exit();
    315b:	e8 82 07 00 00       	call   38e2 <exit>

00003160 <validateint>:
{
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
}
    3163:	5d                   	pop    %ebp
    3164:	c3                   	ret    
    3165:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003170 <validatetest>:
{
    3170:	55                   	push   %ebp
    3171:	89 e5                	mov    %esp,%ebp
    3173:	56                   	push   %esi
    3174:	53                   	push   %ebx
  for(p = 0; p <= (uint)hi; p += 4096){
    3175:	31 db                	xor    %ebx,%ebx
  printf(stdout, "validate test\n");
    3177:	83 ec 08             	sub    $0x8,%esp
    317a:	68 80 54 00 00       	push   $0x5480
    317f:	ff 35 10 5f 00 00    	pushl  0x5f10
    3185:	e8 a6 08 00 00       	call   3a30 <printf>
    318a:	83 c4 10             	add    $0x10,%esp
    318d:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    3190:	e8 45 07 00 00       	call   38da <fork>
    3195:	85 c0                	test   %eax,%eax
    3197:	89 c6                	mov    %eax,%esi
    3199:	74 63                	je     31fe <validatetest+0x8e>
    sleep(0);
    319b:	83 ec 0c             	sub    $0xc,%esp
    319e:	6a 00                	push   $0x0
    31a0:	e8 cd 07 00 00       	call   3972 <sleep>
    sleep(0);
    31a5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31ac:	e8 c1 07 00 00       	call   3972 <sleep>
    kill(pid);
    31b1:	89 34 24             	mov    %esi,(%esp)
    31b4:	e8 59 07 00 00       	call   3912 <kill>
    wait();
    31b9:	e8 2c 07 00 00       	call   38ea <wait>
    if(link("nosuchfile", (char*)p) != -1){
    31be:	58                   	pop    %eax
    31bf:	5a                   	pop    %edx
    31c0:	53                   	push   %ebx
    31c1:	68 8f 54 00 00       	push   $0x548f
    31c6:	e8 77 07 00 00       	call   3942 <link>
    31cb:	83 c4 10             	add    $0x10,%esp
    31ce:	83 f8 ff             	cmp    $0xffffffff,%eax
    31d1:	75 30                	jne    3203 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    31d3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    31d9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    31df:	75 af                	jne    3190 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    31e1:	83 ec 08             	sub    $0x8,%esp
    31e4:	68 b3 54 00 00       	push   $0x54b3
    31e9:	ff 35 10 5f 00 00    	pushl  0x5f10
    31ef:	e8 3c 08 00 00       	call   3a30 <printf>
}
    31f4:	83 c4 10             	add    $0x10,%esp
    31f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31fa:	5b                   	pop    %ebx
    31fb:	5e                   	pop    %esi
    31fc:	5d                   	pop    %ebp
    31fd:	c3                   	ret    
      exit();
    31fe:	e8 df 06 00 00       	call   38e2 <exit>
      printf(stdout, "link should not succeed\n");
    3203:	83 ec 08             	sub    $0x8,%esp
    3206:	68 9a 54 00 00       	push   $0x549a
    320b:	ff 35 10 5f 00 00    	pushl  0x5f10
    3211:	e8 1a 08 00 00       	call   3a30 <printf>
      exit();
    3216:	e8 c7 06 00 00       	call   38e2 <exit>
    321b:	90                   	nop
    321c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003220 <bsstest>:
{
    3220:	55                   	push   %ebp
    3221:	89 e5                	mov    %esp,%ebp
    3223:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    3226:	68 c0 54 00 00       	push   $0x54c0
    322b:	ff 35 10 5f 00 00    	pushl  0x5f10
    3231:	e8 fa 07 00 00       	call   3a30 <printf>
    if(uninit[i] != '\0'){
    3236:	83 c4 10             	add    $0x10,%esp
    3239:	80 3d e0 5f 00 00 00 	cmpb   $0x0,0x5fe0
    3240:	75 39                	jne    327b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    3242:	b8 01 00 00 00       	mov    $0x1,%eax
    3247:	89 f6                	mov    %esi,%esi
    3249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(uninit[i] != '\0'){
    3250:	80 b8 e0 5f 00 00 00 	cmpb   $0x0,0x5fe0(%eax)
    3257:	75 22                	jne    327b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    3259:	83 c0 01             	add    $0x1,%eax
    325c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3261:	75 ed                	jne    3250 <bsstest+0x30>
  printf(stdout, "bss test ok\n");
    3263:	83 ec 08             	sub    $0x8,%esp
    3266:	68 db 54 00 00       	push   $0x54db
    326b:	ff 35 10 5f 00 00    	pushl  0x5f10
    3271:	e8 ba 07 00 00       	call   3a30 <printf>
}
    3276:	83 c4 10             	add    $0x10,%esp
    3279:	c9                   	leave  
    327a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    327b:	83 ec 08             	sub    $0x8,%esp
    327e:	68 ca 54 00 00       	push   $0x54ca
    3283:	ff 35 10 5f 00 00    	pushl  0x5f10
    3289:	e8 a2 07 00 00       	call   3a30 <printf>
      exit();
    328e:	e8 4f 06 00 00       	call   38e2 <exit>
    3293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000032a0 <bigargtest>:
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    32a6:	68 e8 54 00 00       	push   $0x54e8
    32ab:	e8 82 06 00 00       	call   3932 <unlink>
  pid = fork();
    32b0:	e8 25 06 00 00       	call   38da <fork>
  if(pid == 0){
    32b5:	83 c4 10             	add    $0x10,%esp
    32b8:	85 c0                	test   %eax,%eax
    32ba:	74 3f                	je     32fb <bigargtest+0x5b>
  } else if(pid < 0){
    32bc:	0f 88 c2 00 00 00    	js     3384 <bigargtest+0xe4>
  wait();
    32c2:	e8 23 06 00 00       	call   38ea <wait>
  fd = open("bigarg-ok", 0);
    32c7:	83 ec 08             	sub    $0x8,%esp
    32ca:	6a 00                	push   $0x0
    32cc:	68 e8 54 00 00       	push   $0x54e8
    32d1:	e8 4c 06 00 00       	call   3922 <open>
  if(fd < 0){
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	85 c0                	test   %eax,%eax
    32db:	0f 88 8c 00 00 00    	js     336d <bigargtest+0xcd>
  close(fd);
    32e1:	83 ec 0c             	sub    $0xc,%esp
    32e4:	50                   	push   %eax
    32e5:	e8 20 06 00 00       	call   390a <close>
  unlink("bigarg-ok");
    32ea:	c7 04 24 e8 54 00 00 	movl   $0x54e8,(%esp)
    32f1:	e8 3c 06 00 00       	call   3932 <unlink>
}
    32f6:	83 c4 10             	add    $0x10,%esp
    32f9:	c9                   	leave  
    32fa:	c3                   	ret    
    32fb:	b8 40 5f 00 00       	mov    $0x5f40,%eax
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3300:	c7 00 b0 44 00 00    	movl   $0x44b0,(%eax)
    3306:	83 c0 04             	add    $0x4,%eax
    for(i = 0; i < MAXARG-1; i++)
    3309:	3d bc 5f 00 00       	cmp    $0x5fbc,%eax
    330e:	75 f0                	jne    3300 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    3310:	51                   	push   %ecx
    3311:	51                   	push   %ecx
    3312:	68 f2 54 00 00       	push   $0x54f2
    3317:	ff 35 10 5f 00 00    	pushl  0x5f10
    args[MAXARG-1] = 0;
    331d:	c7 05 bc 5f 00 00 00 	movl   $0x0,0x5fbc
    3324:	00 00 00 
    printf(stdout, "bigarg test\n");
    3327:	e8 04 07 00 00       	call   3a30 <printf>
    exec("echo", args);
    332c:	58                   	pop    %eax
    332d:	5a                   	pop    %edx
    332e:	68 40 5f 00 00       	push   $0x5f40
    3333:	68 bf 46 00 00       	push   $0x46bf
    3338:	e8 dd 05 00 00       	call   391a <exec>
    printf(stdout, "bigarg test ok\n");
    333d:	59                   	pop    %ecx
    333e:	58                   	pop    %eax
    333f:	68 ff 54 00 00       	push   $0x54ff
    3344:	ff 35 10 5f 00 00    	pushl  0x5f10
    334a:	e8 e1 06 00 00       	call   3a30 <printf>
    fd = open("bigarg-ok", O_CREATE);
    334f:	58                   	pop    %eax
    3350:	5a                   	pop    %edx
    3351:	68 00 02 00 00       	push   $0x200
    3356:	68 e8 54 00 00       	push   $0x54e8
    335b:	e8 c2 05 00 00       	call   3922 <open>
    close(fd);
    3360:	89 04 24             	mov    %eax,(%esp)
    3363:	e8 a2 05 00 00       	call   390a <close>
    exit();
    3368:	e8 75 05 00 00       	call   38e2 <exit>
    printf(stdout, "bigarg test failed!\n");
    336d:	50                   	push   %eax
    336e:	50                   	push   %eax
    336f:	68 28 55 00 00       	push   $0x5528
    3374:	ff 35 10 5f 00 00    	pushl  0x5f10
    337a:	e8 b1 06 00 00       	call   3a30 <printf>
    exit();
    337f:	e8 5e 05 00 00       	call   38e2 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3384:	52                   	push   %edx
    3385:	52                   	push   %edx
    3386:	68 0f 55 00 00       	push   $0x550f
    338b:	ff 35 10 5f 00 00    	pushl  0x5f10
    3391:	e8 9a 06 00 00       	call   3a30 <printf>
    exit();
    3396:	e8 47 05 00 00       	call   38e2 <exit>
    339b:	90                   	nop
    339c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000033a0 <fsfull>:
{
    33a0:	55                   	push   %ebp
    33a1:	89 e5                	mov    %esp,%ebp
    33a3:	57                   	push   %edi
    33a4:	56                   	push   %esi
    33a5:	53                   	push   %ebx
  for(nfiles = 0; ; nfiles++){
    33a6:	31 db                	xor    %ebx,%ebx
{
    33a8:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    33ab:	68 3d 55 00 00       	push   $0x553d
    33b0:	6a 01                	push   $0x1
    33b2:	e8 79 06 00 00       	call   3a30 <printf>
    33b7:	83 c4 10             	add    $0x10,%esp
    33ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    33c0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33c5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    33ca:	83 ec 04             	sub    $0x4,%esp
    name[1] = '0' + nfiles / 1000;
    33cd:	f7 e3                	mul    %ebx
    name[0] = 'f';
    33cf:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    33d3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    33d7:	c1 ea 06             	shr    $0x6,%edx
    33da:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33dd:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    33e3:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    33e6:	89 d8                	mov    %ebx,%eax
    33e8:	29 d0                	sub    %edx,%eax
    33ea:	89 c2                	mov    %eax,%edx
    33ec:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33f1:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    33f3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33f8:	c1 ea 05             	shr    $0x5,%edx
    33fb:	83 c2 30             	add    $0x30,%edx
    33fe:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3401:	f7 e3                	mul    %ebx
    3403:	89 d8                	mov    %ebx,%eax
    3405:	c1 ea 05             	shr    $0x5,%edx
    3408:	6b d2 64             	imul   $0x64,%edx,%edx
    340b:	29 d0                	sub    %edx,%eax
    340d:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    340f:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3411:	c1 ea 03             	shr    $0x3,%edx
    3414:	83 c2 30             	add    $0x30,%edx
    3417:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    341a:	f7 e1                	mul    %ecx
    341c:	89 d9                	mov    %ebx,%ecx
    341e:	c1 ea 03             	shr    $0x3,%edx
    3421:	8d 04 92             	lea    (%edx,%edx,4),%eax
    3424:	01 c0                	add    %eax,%eax
    3426:	29 c1                	sub    %eax,%ecx
    3428:	89 c8                	mov    %ecx,%eax
    342a:	83 c0 30             	add    $0x30,%eax
    342d:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    3430:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3433:	50                   	push   %eax
    3434:	68 4a 55 00 00       	push   $0x554a
    3439:	6a 01                	push   $0x1
    343b:	e8 f0 05 00 00       	call   3a30 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3440:	58                   	pop    %eax
    3441:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3444:	5a                   	pop    %edx
    3445:	68 02 02 00 00       	push   $0x202
    344a:	50                   	push   %eax
    344b:	e8 d2 04 00 00       	call   3922 <open>
    if(fd < 0){
    3450:	83 c4 10             	add    $0x10,%esp
    3453:	85 c0                	test   %eax,%eax
    int fd = open(name, O_CREATE|O_RDWR);
    3455:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3457:	78 57                	js     34b0 <fsfull+0x110>
    int total = 0;
    3459:	31 f6                	xor    %esi,%esi
    345b:	eb 05                	jmp    3462 <fsfull+0xc2>
    345d:	8d 76 00             	lea    0x0(%esi),%esi
      total += cc;
    3460:	01 c6                	add    %eax,%esi
      int cc = write(fd, buf, 512);
    3462:	83 ec 04             	sub    $0x4,%esp
    3465:	68 00 02 00 00       	push   $0x200
    346a:	68 00 87 00 00       	push   $0x8700
    346f:	57                   	push   %edi
    3470:	e8 8d 04 00 00       	call   3902 <write>
      if(cc < 512)
    3475:	83 c4 10             	add    $0x10,%esp
    3478:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    347d:	7f e1                	jg     3460 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    347f:	83 ec 04             	sub    $0x4,%esp
    3482:	56                   	push   %esi
    3483:	68 66 55 00 00       	push   $0x5566
    3488:	6a 01                	push   $0x1
    348a:	e8 a1 05 00 00       	call   3a30 <printf>
    close(fd);
    348f:	89 3c 24             	mov    %edi,(%esp)
    3492:	e8 73 04 00 00       	call   390a <close>
    if(total == 0)
    3497:	83 c4 10             	add    $0x10,%esp
    349a:	85 f6                	test   %esi,%esi
    349c:	74 28                	je     34c6 <fsfull+0x126>
  for(nfiles = 0; ; nfiles++){
    349e:	83 c3 01             	add    $0x1,%ebx
    34a1:	e9 1a ff ff ff       	jmp    33c0 <fsfull+0x20>
    34a6:	8d 76 00             	lea    0x0(%esi),%esi
    34a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "open %s failed\n", name);
    34b0:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34b3:	83 ec 04             	sub    $0x4,%esp
    34b6:	50                   	push   %eax
    34b7:	68 56 55 00 00       	push   $0x5556
    34bc:	6a 01                	push   $0x1
    34be:	e8 6d 05 00 00       	call   3a30 <printf>
      break;
    34c3:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    34c6:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    34cb:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    name[1] = '0' + nfiles / 1000;
    34d0:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    34d2:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    unlink(name);
    34d7:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + nfiles / 1000;
    34da:	f7 e7                	mul    %edi
    name[0] = 'f';
    34dc:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    34e0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    34e4:	c1 ea 06             	shr    $0x6,%edx
    34e7:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34ea:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    34f0:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    34f3:	89 d8                	mov    %ebx,%eax
    34f5:	29 d0                	sub    %edx,%eax
    34f7:	f7 e6                	mul    %esi
    name[3] = '0' + (nfiles % 100) / 10;
    34f9:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34fb:	c1 ea 05             	shr    $0x5,%edx
    34fe:	83 c2 30             	add    $0x30,%edx
    3501:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3504:	f7 e6                	mul    %esi
    3506:	89 d8                	mov    %ebx,%eax
    3508:	c1 ea 05             	shr    $0x5,%edx
    350b:	6b d2 64             	imul   $0x64,%edx,%edx
    350e:	29 d0                	sub    %edx,%eax
    3510:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3512:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3514:	c1 ea 03             	shr    $0x3,%edx
    3517:	83 c2 30             	add    $0x30,%edx
    351a:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    351d:	f7 e1                	mul    %ecx
    351f:	89 d9                	mov    %ebx,%ecx
    nfiles--;
    3521:	83 eb 01             	sub    $0x1,%ebx
    name[4] = '0' + (nfiles % 10);
    3524:	c1 ea 03             	shr    $0x3,%edx
    3527:	8d 04 92             	lea    (%edx,%edx,4),%eax
    352a:	01 c0                	add    %eax,%eax
    352c:	29 c1                	sub    %eax,%ecx
    352e:	89 c8                	mov    %ecx,%eax
    3530:	83 c0 30             	add    $0x30,%eax
    3533:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3536:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3539:	50                   	push   %eax
    353a:	e8 f3 03 00 00       	call   3932 <unlink>
  while(nfiles >= 0){
    353f:	83 c4 10             	add    $0x10,%esp
    3542:	83 fb ff             	cmp    $0xffffffff,%ebx
    3545:	75 89                	jne    34d0 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    3547:	83 ec 08             	sub    $0x8,%esp
    354a:	68 76 55 00 00       	push   $0x5576
    354f:	6a 01                	push   $0x1
    3551:	e8 da 04 00 00       	call   3a30 <printf>
}
    3556:	83 c4 10             	add    $0x10,%esp
    3559:	8d 65 f4             	lea    -0xc(%ebp),%esp
    355c:	5b                   	pop    %ebx
    355d:	5e                   	pop    %esi
    355e:	5f                   	pop    %edi
    355f:	5d                   	pop    %ebp
    3560:	c3                   	ret    
    3561:	eb 0d                	jmp    3570 <uio>
    3563:	90                   	nop
    3564:	90                   	nop
    3565:	90                   	nop
    3566:	90                   	nop
    3567:	90                   	nop
    3568:	90                   	nop
    3569:	90                   	nop
    356a:	90                   	nop
    356b:	90                   	nop
    356c:	90                   	nop
    356d:	90                   	nop
    356e:	90                   	nop
    356f:	90                   	nop

00003570 <uio>:
{
    3570:	55                   	push   %ebp
    3571:	89 e5                	mov    %esp,%ebp
    3573:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3576:	68 8c 55 00 00       	push   $0x558c
    357b:	6a 01                	push   $0x1
    357d:	e8 ae 04 00 00       	call   3a30 <printf>
  pid = fork();
    3582:	e8 53 03 00 00       	call   38da <fork>
  if(pid == 0){
    3587:	83 c4 10             	add    $0x10,%esp
    358a:	85 c0                	test   %eax,%eax
    358c:	74 1b                	je     35a9 <uio+0x39>
  } else if(pid < 0){
    358e:	78 3d                	js     35cd <uio+0x5d>
  wait();
    3590:	e8 55 03 00 00       	call   38ea <wait>
  printf(1, "uio test done\n");
    3595:	83 ec 08             	sub    $0x8,%esp
    3598:	68 96 55 00 00       	push   $0x5596
    359d:	6a 01                	push   $0x1
    359f:	e8 8c 04 00 00       	call   3a30 <printf>
}
    35a4:	83 c4 10             	add    $0x10,%esp
    35a7:	c9                   	leave  
    35a8:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    35a9:	b8 09 00 00 00       	mov    $0x9,%eax
    35ae:	ba 70 00 00 00       	mov    $0x70,%edx
    35b3:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    35b4:	ba 71 00 00 00       	mov    $0x71,%edx
    35b9:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    35ba:	52                   	push   %edx
    35bb:	52                   	push   %edx
    35bc:	68 90 45 00 00       	push   $0x4590
    35c1:	6a 01                	push   $0x1
    35c3:	e8 68 04 00 00       	call   3a30 <printf>
    exit();
    35c8:	e8 15 03 00 00       	call   38e2 <exit>
    printf (1, "fork failed\n");
    35cd:	50                   	push   %eax
    35ce:	50                   	push   %eax
    35cf:	68 1b 55 00 00       	push   $0x551b
    35d4:	6a 01                	push   $0x1
    35d6:	e8 55 04 00 00       	call   3a30 <printf>
    exit();
    35db:	e8 02 03 00 00       	call   38e2 <exit>

000035e0 <argptest>:
{
    35e0:	55                   	push   %ebp
    35e1:	89 e5                	mov    %esp,%ebp
    35e3:	53                   	push   %ebx
    35e4:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    35e7:	6a 00                	push   $0x0
    35e9:	68 a5 55 00 00       	push   $0x55a5
    35ee:	e8 2f 03 00 00       	call   3922 <open>
  if (fd < 0) {
    35f3:	83 c4 10             	add    $0x10,%esp
    35f6:	85 c0                	test   %eax,%eax
    35f8:	78 39                	js     3633 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    35fa:	83 ec 0c             	sub    $0xc,%esp
    35fd:	89 c3                	mov    %eax,%ebx
    35ff:	6a 00                	push   $0x0
    3601:	e8 64 03 00 00       	call   396a <sbrk>
    3606:	83 c4 0c             	add    $0xc,%esp
    3609:	83 e8 01             	sub    $0x1,%eax
    360c:	6a ff                	push   $0xffffffff
    360e:	50                   	push   %eax
    360f:	53                   	push   %ebx
    3610:	e8 e5 02 00 00       	call   38fa <read>
  close(fd);
    3615:	89 1c 24             	mov    %ebx,(%esp)
    3618:	e8 ed 02 00 00       	call   390a <close>
  printf(1, "arg test passed\n");
    361d:	58                   	pop    %eax
    361e:	5a                   	pop    %edx
    361f:	68 b7 55 00 00       	push   $0x55b7
    3624:	6a 01                	push   $0x1
    3626:	e8 05 04 00 00       	call   3a30 <printf>
}
    362b:	83 c4 10             	add    $0x10,%esp
    362e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3631:	c9                   	leave  
    3632:	c3                   	ret    
    printf(2, "open failed\n");
    3633:	51                   	push   %ecx
    3634:	51                   	push   %ecx
    3635:	68 aa 55 00 00       	push   $0x55aa
    363a:	6a 02                	push   $0x2
    363c:	e8 ef 03 00 00       	call   3a30 <printf>
    exit();
    3641:	e8 9c 02 00 00       	call   38e2 <exit>
    3646:	8d 76 00             	lea    0x0(%esi),%esi
    3649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003650 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3650:	69 05 0c 5f 00 00 0d 	imul   $0x19660d,0x5f0c,%eax
    3657:	66 19 00 
{
    365a:	55                   	push   %ebp
    365b:	89 e5                	mov    %esp,%ebp
}
    365d:	5d                   	pop    %ebp
  randstate = randstate * 1664525 + 1013904223;
    365e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3663:	a3 0c 5f 00 00       	mov    %eax,0x5f0c
}
    3668:	c3                   	ret    
    3669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003670 <func>:
volatile int func(volatile int *tmp){
    3670:	55                   	push   %ebp
    3671:	89 e5                	mov    %esp,%ebp
    3673:	8b 55 08             	mov    0x8(%ebp),%edx
  *tmp = *tmp + 1;
    3676:	8b 02                	mov    (%edx),%eax
    3678:	83 c0 01             	add    $0x1,%eax
    367b:	89 02                	mov    %eax,(%edx)
}
    367d:	b8 03 00 00 00       	mov    $0x3,%eax
    3682:	5d                   	pop    %ebp
    3683:	c3                   	ret    
    3684:	66 90                	xchg   %ax,%ax
    3686:	66 90                	xchg   %ax,%ax
    3688:	66 90                	xchg   %ax,%ax
    368a:	66 90                	xchg   %ax,%ax
    368c:	66 90                	xchg   %ax,%ax
    368e:	66 90                	xchg   %ax,%ax

00003690 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3690:	55                   	push   %ebp
    3691:	89 e5                	mov    %esp,%ebp
    3693:	53                   	push   %ebx
    3694:	8b 45 08             	mov    0x8(%ebp),%eax
    3697:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    369a:	89 c2                	mov    %eax,%edx
    369c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    36a0:	83 c1 01             	add    $0x1,%ecx
    36a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    36a7:	83 c2 01             	add    $0x1,%edx
    36aa:	84 db                	test   %bl,%bl
    36ac:	88 5a ff             	mov    %bl,-0x1(%edx)
    36af:	75 ef                	jne    36a0 <strcpy+0x10>
    ;
  return os;
}
    36b1:	5b                   	pop    %ebx
    36b2:	5d                   	pop    %ebp
    36b3:	c3                   	ret    
    36b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000036c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    36c0:	55                   	push   %ebp
    36c1:	89 e5                	mov    %esp,%ebp
    36c3:	53                   	push   %ebx
    36c4:	8b 55 08             	mov    0x8(%ebp),%edx
    36c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    36ca:	0f b6 02             	movzbl (%edx),%eax
    36cd:	0f b6 19             	movzbl (%ecx),%ebx
    36d0:	84 c0                	test   %al,%al
    36d2:	75 1c                	jne    36f0 <strcmp+0x30>
    36d4:	eb 2a                	jmp    3700 <strcmp+0x40>
    36d6:	8d 76 00             	lea    0x0(%esi),%esi
    36d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    36e0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    36e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    36e6:	83 c1 01             	add    $0x1,%ecx
    36e9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    36ec:	84 c0                	test   %al,%al
    36ee:	74 10                	je     3700 <strcmp+0x40>
    36f0:	38 d8                	cmp    %bl,%al
    36f2:	74 ec                	je     36e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    36f4:	29 d8                	sub    %ebx,%eax
}
    36f6:	5b                   	pop    %ebx
    36f7:	5d                   	pop    %ebp
    36f8:	c3                   	ret    
    36f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3700:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    3702:	29 d8                	sub    %ebx,%eax
}
    3704:	5b                   	pop    %ebx
    3705:	5d                   	pop    %ebp
    3706:	c3                   	ret    
    3707:	89 f6                	mov    %esi,%esi
    3709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003710 <strlen>:

uint
strlen(const char *s)
{
    3710:	55                   	push   %ebp
    3711:	89 e5                	mov    %esp,%ebp
    3713:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3716:	80 39 00             	cmpb   $0x0,(%ecx)
    3719:	74 15                	je     3730 <strlen+0x20>
    371b:	31 d2                	xor    %edx,%edx
    371d:	8d 76 00             	lea    0x0(%esi),%esi
    3720:	83 c2 01             	add    $0x1,%edx
    3723:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3727:	89 d0                	mov    %edx,%eax
    3729:	75 f5                	jne    3720 <strlen+0x10>
    ;
  return n;
}
    372b:	5d                   	pop    %ebp
    372c:	c3                   	ret    
    372d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    3730:	31 c0                	xor    %eax,%eax
}
    3732:	5d                   	pop    %ebp
    3733:	c3                   	ret    
    3734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    373a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003740 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3740:	55                   	push   %ebp
    3741:	89 e5                	mov    %esp,%ebp
    3743:	57                   	push   %edi
    3744:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3747:	8b 4d 10             	mov    0x10(%ebp),%ecx
    374a:	8b 45 0c             	mov    0xc(%ebp),%eax
    374d:	89 d7                	mov    %edx,%edi
    374f:	fc                   	cld    
    3750:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3752:	89 d0                	mov    %edx,%eax
    3754:	5f                   	pop    %edi
    3755:	5d                   	pop    %ebp
    3756:	c3                   	ret    
    3757:	89 f6                	mov    %esi,%esi
    3759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003760 <strchr>:

char*
strchr(const char *s, char c)
{
    3760:	55                   	push   %ebp
    3761:	89 e5                	mov    %esp,%ebp
    3763:	53                   	push   %ebx
    3764:	8b 45 08             	mov    0x8(%ebp),%eax
    3767:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    376a:	0f b6 10             	movzbl (%eax),%edx
    376d:	84 d2                	test   %dl,%dl
    376f:	74 1d                	je     378e <strchr+0x2e>
    if(*s == c)
    3771:	38 d3                	cmp    %dl,%bl
    3773:	89 d9                	mov    %ebx,%ecx
    3775:	75 0d                	jne    3784 <strchr+0x24>
    3777:	eb 17                	jmp    3790 <strchr+0x30>
    3779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3780:	38 ca                	cmp    %cl,%dl
    3782:	74 0c                	je     3790 <strchr+0x30>
  for(; *s; s++)
    3784:	83 c0 01             	add    $0x1,%eax
    3787:	0f b6 10             	movzbl (%eax),%edx
    378a:	84 d2                	test   %dl,%dl
    378c:	75 f2                	jne    3780 <strchr+0x20>
      return (char*)s;
  return 0;
    378e:	31 c0                	xor    %eax,%eax
}
    3790:	5b                   	pop    %ebx
    3791:	5d                   	pop    %ebp
    3792:	c3                   	ret    
    3793:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000037a0 <gets>:

char*
gets(char *buf, int max)
{
    37a0:	55                   	push   %ebp
    37a1:	89 e5                	mov    %esp,%ebp
    37a3:	57                   	push   %edi
    37a4:	56                   	push   %esi
    37a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    37a6:	31 f6                	xor    %esi,%esi
    37a8:	89 f3                	mov    %esi,%ebx
{
    37aa:	83 ec 1c             	sub    $0x1c,%esp
    37ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    37b0:	eb 2f                	jmp    37e1 <gets+0x41>
    37b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    37b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    37bb:	83 ec 04             	sub    $0x4,%esp
    37be:	6a 01                	push   $0x1
    37c0:	50                   	push   %eax
    37c1:	6a 00                	push   $0x0
    37c3:	e8 32 01 00 00       	call   38fa <read>
    if(cc < 1)
    37c8:	83 c4 10             	add    $0x10,%esp
    37cb:	85 c0                	test   %eax,%eax
    37cd:	7e 1c                	jle    37eb <gets+0x4b>
      break;
    buf[i++] = c;
    37cf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    37d3:	83 c7 01             	add    $0x1,%edi
    37d6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    37d9:	3c 0a                	cmp    $0xa,%al
    37db:	74 23                	je     3800 <gets+0x60>
    37dd:	3c 0d                	cmp    $0xd,%al
    37df:	74 1f                	je     3800 <gets+0x60>
  for(i=0; i+1 < max; ){
    37e1:	83 c3 01             	add    $0x1,%ebx
    37e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37e7:	89 fe                	mov    %edi,%esi
    37e9:	7c cd                	jl     37b8 <gets+0x18>
    37eb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    37ed:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    37f0:	c6 03 00             	movb   $0x0,(%ebx)
}
    37f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37f6:	5b                   	pop    %ebx
    37f7:	5e                   	pop    %esi
    37f8:	5f                   	pop    %edi
    37f9:	5d                   	pop    %ebp
    37fa:	c3                   	ret    
    37fb:	90                   	nop
    37fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3800:	8b 75 08             	mov    0x8(%ebp),%esi
    3803:	8b 45 08             	mov    0x8(%ebp),%eax
    3806:	01 de                	add    %ebx,%esi
    3808:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    380a:	c6 03 00             	movb   $0x0,(%ebx)
}
    380d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3810:	5b                   	pop    %ebx
    3811:	5e                   	pop    %esi
    3812:	5f                   	pop    %edi
    3813:	5d                   	pop    %ebp
    3814:	c3                   	ret    
    3815:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003820 <stat>:

int
stat(const char *n, struct stat *st)
{
    3820:	55                   	push   %ebp
    3821:	89 e5                	mov    %esp,%ebp
    3823:	56                   	push   %esi
    3824:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3825:	83 ec 08             	sub    $0x8,%esp
    3828:	6a 00                	push   $0x0
    382a:	ff 75 08             	pushl  0x8(%ebp)
    382d:	e8 f0 00 00 00       	call   3922 <open>
  if(fd < 0)
    3832:	83 c4 10             	add    $0x10,%esp
    3835:	85 c0                	test   %eax,%eax
    3837:	78 27                	js     3860 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    3839:	83 ec 08             	sub    $0x8,%esp
    383c:	ff 75 0c             	pushl  0xc(%ebp)
    383f:	89 c3                	mov    %eax,%ebx
    3841:	50                   	push   %eax
    3842:	e8 f3 00 00 00       	call   393a <fstat>
  close(fd);
    3847:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    384a:	89 c6                	mov    %eax,%esi
  close(fd);
    384c:	e8 b9 00 00 00       	call   390a <close>
  return r;
    3851:	83 c4 10             	add    $0x10,%esp
}
    3854:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3857:	89 f0                	mov    %esi,%eax
    3859:	5b                   	pop    %ebx
    385a:	5e                   	pop    %esi
    385b:	5d                   	pop    %ebp
    385c:	c3                   	ret    
    385d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3860:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3865:	eb ed                	jmp    3854 <stat+0x34>
    3867:	89 f6                	mov    %esi,%esi
    3869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003870 <atoi>:

int
atoi(const char *s)
{
    3870:	55                   	push   %ebp
    3871:	89 e5                	mov    %esp,%ebp
    3873:	53                   	push   %ebx
    3874:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3877:	0f be 11             	movsbl (%ecx),%edx
    387a:	8d 42 d0             	lea    -0x30(%edx),%eax
    387d:	3c 09                	cmp    $0x9,%al
  n = 0;
    387f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    3884:	77 1f                	ja     38a5 <atoi+0x35>
    3886:	8d 76 00             	lea    0x0(%esi),%esi
    3889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    3890:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3893:	83 c1 01             	add    $0x1,%ecx
    3896:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    389a:	0f be 11             	movsbl (%ecx),%edx
    389d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    38a0:	80 fb 09             	cmp    $0x9,%bl
    38a3:	76 eb                	jbe    3890 <atoi+0x20>
  return n;
}
    38a5:	5b                   	pop    %ebx
    38a6:	5d                   	pop    %ebp
    38a7:	c3                   	ret    
    38a8:	90                   	nop
    38a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000038b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    38b0:	55                   	push   %ebp
    38b1:	89 e5                	mov    %esp,%ebp
    38b3:	56                   	push   %esi
    38b4:	53                   	push   %ebx
    38b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    38b8:	8b 45 08             	mov    0x8(%ebp),%eax
    38bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    38be:	85 db                	test   %ebx,%ebx
    38c0:	7e 14                	jle    38d6 <memmove+0x26>
    38c2:	31 d2                	xor    %edx,%edx
    38c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    38c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    38cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    38cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    38d2:	39 d3                	cmp    %edx,%ebx
    38d4:	75 f2                	jne    38c8 <memmove+0x18>
  return vdst;
}
    38d6:	5b                   	pop    %ebx
    38d7:	5e                   	pop    %esi
    38d8:	5d                   	pop    %ebp
    38d9:	c3                   	ret    

000038da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    38da:	b8 01 00 00 00       	mov    $0x1,%eax
    38df:	cd 40                	int    $0x40
    38e1:	c3                   	ret    

000038e2 <exit>:
SYSCALL(exit)
    38e2:	b8 02 00 00 00       	mov    $0x2,%eax
    38e7:	cd 40                	int    $0x40
    38e9:	c3                   	ret    

000038ea <wait>:
SYSCALL(wait)
    38ea:	b8 03 00 00 00       	mov    $0x3,%eax
    38ef:	cd 40                	int    $0x40
    38f1:	c3                   	ret    

000038f2 <pipe>:
SYSCALL(pipe)
    38f2:	b8 04 00 00 00       	mov    $0x4,%eax
    38f7:	cd 40                	int    $0x40
    38f9:	c3                   	ret    

000038fa <read>:
SYSCALL(read)
    38fa:	b8 05 00 00 00       	mov    $0x5,%eax
    38ff:	cd 40                	int    $0x40
    3901:	c3                   	ret    

00003902 <write>:
SYSCALL(write)
    3902:	b8 10 00 00 00       	mov    $0x10,%eax
    3907:	cd 40                	int    $0x40
    3909:	c3                   	ret    

0000390a <close>:
SYSCALL(close)
    390a:	b8 15 00 00 00       	mov    $0x15,%eax
    390f:	cd 40                	int    $0x40
    3911:	c3                   	ret    

00003912 <kill>:
SYSCALL(kill)
    3912:	b8 06 00 00 00       	mov    $0x6,%eax
    3917:	cd 40                	int    $0x40
    3919:	c3                   	ret    

0000391a <exec>:
SYSCALL(exec)
    391a:	b8 07 00 00 00       	mov    $0x7,%eax
    391f:	cd 40                	int    $0x40
    3921:	c3                   	ret    

00003922 <open>:
SYSCALL(open)
    3922:	b8 0f 00 00 00       	mov    $0xf,%eax
    3927:	cd 40                	int    $0x40
    3929:	c3                   	ret    

0000392a <mknod>:
SYSCALL(mknod)
    392a:	b8 11 00 00 00       	mov    $0x11,%eax
    392f:	cd 40                	int    $0x40
    3931:	c3                   	ret    

00003932 <unlink>:
SYSCALL(unlink)
    3932:	b8 12 00 00 00       	mov    $0x12,%eax
    3937:	cd 40                	int    $0x40
    3939:	c3                   	ret    

0000393a <fstat>:
SYSCALL(fstat)
    393a:	b8 08 00 00 00       	mov    $0x8,%eax
    393f:	cd 40                	int    $0x40
    3941:	c3                   	ret    

00003942 <link>:
SYSCALL(link)
    3942:	b8 13 00 00 00       	mov    $0x13,%eax
    3947:	cd 40                	int    $0x40
    3949:	c3                   	ret    

0000394a <mkdir>:
SYSCALL(mkdir)
    394a:	b8 14 00 00 00       	mov    $0x14,%eax
    394f:	cd 40                	int    $0x40
    3951:	c3                   	ret    

00003952 <chdir>:
SYSCALL(chdir)
    3952:	b8 09 00 00 00       	mov    $0x9,%eax
    3957:	cd 40                	int    $0x40
    3959:	c3                   	ret    

0000395a <dup>:
SYSCALL(dup)
    395a:	b8 0a 00 00 00       	mov    $0xa,%eax
    395f:	cd 40                	int    $0x40
    3961:	c3                   	ret    

00003962 <getpid>:
SYSCALL(getpid)
    3962:	b8 0b 00 00 00       	mov    $0xb,%eax
    3967:	cd 40                	int    $0x40
    3969:	c3                   	ret    

0000396a <sbrk>:
SYSCALL(sbrk)
    396a:	b8 0c 00 00 00       	mov    $0xc,%eax
    396f:	cd 40                	int    $0x40
    3971:	c3                   	ret    

00003972 <sleep>:
SYSCALL(sleep)
    3972:	b8 0d 00 00 00       	mov    $0xd,%eax
    3977:	cd 40                	int    $0x40
    3979:	c3                   	ret    

0000397a <uptime>:
SYSCALL(uptime)
    397a:	b8 0e 00 00 00       	mov    $0xe,%eax
    397f:	cd 40                	int    $0x40
    3981:	c3                   	ret    
    3982:	66 90                	xchg   %ax,%ax
    3984:	66 90                	xchg   %ax,%ax
    3986:	66 90                	xchg   %ax,%ax
    3988:	66 90                	xchg   %ax,%ax
    398a:	66 90                	xchg   %ax,%ax
    398c:	66 90                	xchg   %ax,%ax
    398e:	66 90                	xchg   %ax,%ax

00003990 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3990:	55                   	push   %ebp
    3991:	89 e5                	mov    %esp,%ebp
    3993:	57                   	push   %edi
    3994:	56                   	push   %esi
    3995:	53                   	push   %ebx
    3996:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3999:	85 d2                	test   %edx,%edx
{
    399b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    399e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    39a0:	79 76                	jns    3a18 <printint+0x88>
    39a2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    39a6:	74 70                	je     3a18 <printint+0x88>
    x = -xx;
    39a8:	f7 d8                	neg    %eax
    neg = 1;
    39aa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    39b1:	31 f6                	xor    %esi,%esi
    39b3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    39b6:	eb 0a                	jmp    39c2 <printint+0x32>
    39b8:	90                   	nop
    39b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    39c0:	89 fe                	mov    %edi,%esi
    39c2:	31 d2                	xor    %edx,%edx
    39c4:	8d 7e 01             	lea    0x1(%esi),%edi
    39c7:	f7 f1                	div    %ecx
    39c9:	0f b6 92 e0 55 00 00 	movzbl 0x55e0(%edx),%edx
  }while((x /= base) != 0);
    39d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    39d2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    39d5:	75 e9                	jne    39c0 <printint+0x30>
  if(neg)
    39d7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    39da:	85 c0                	test   %eax,%eax
    39dc:	74 08                	je     39e6 <printint+0x56>
    buf[i++] = '-';
    39de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    39e3:	8d 7e 02             	lea    0x2(%esi),%edi
    39e6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    39ea:	8b 7d c0             	mov    -0x40(%ebp),%edi
    39ed:	8d 76 00             	lea    0x0(%esi),%esi
    39f0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    39f3:	83 ec 04             	sub    $0x4,%esp
    39f6:	83 ee 01             	sub    $0x1,%esi
    39f9:	6a 01                	push   $0x1
    39fb:	53                   	push   %ebx
    39fc:	57                   	push   %edi
    39fd:	88 45 d7             	mov    %al,-0x29(%ebp)
    3a00:	e8 fd fe ff ff       	call   3902 <write>

  while(--i >= 0)
    3a05:	83 c4 10             	add    $0x10,%esp
    3a08:	39 de                	cmp    %ebx,%esi
    3a0a:	75 e4                	jne    39f0 <printint+0x60>
    putc(fd, buf[i]);
}
    3a0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a0f:	5b                   	pop    %ebx
    3a10:	5e                   	pop    %esi
    3a11:	5f                   	pop    %edi
    3a12:	5d                   	pop    %ebp
    3a13:	c3                   	ret    
    3a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3a18:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    3a1f:	eb 90                	jmp    39b1 <printint+0x21>
    3a21:	eb 0d                	jmp    3a30 <printf>
    3a23:	90                   	nop
    3a24:	90                   	nop
    3a25:	90                   	nop
    3a26:	90                   	nop
    3a27:	90                   	nop
    3a28:	90                   	nop
    3a29:	90                   	nop
    3a2a:	90                   	nop
    3a2b:	90                   	nop
    3a2c:	90                   	nop
    3a2d:	90                   	nop
    3a2e:	90                   	nop
    3a2f:	90                   	nop

00003a30 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3a30:	55                   	push   %ebp
    3a31:	89 e5                	mov    %esp,%ebp
    3a33:	57                   	push   %edi
    3a34:	56                   	push   %esi
    3a35:	53                   	push   %ebx
    3a36:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a39:	8b 75 0c             	mov    0xc(%ebp),%esi
    3a3c:	0f b6 1e             	movzbl (%esi),%ebx
    3a3f:	84 db                	test   %bl,%bl
    3a41:	0f 84 b3 00 00 00    	je     3afa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    3a47:	8d 45 10             	lea    0x10(%ebp),%eax
    3a4a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    3a4d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    3a4f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3a52:	eb 2f                	jmp    3a83 <printf+0x53>
    3a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3a58:	83 f8 25             	cmp    $0x25,%eax
    3a5b:	0f 84 a7 00 00 00    	je     3b08 <printf+0xd8>
  write(fd, &c, 1);
    3a61:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3a64:	83 ec 04             	sub    $0x4,%esp
    3a67:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    3a6a:	6a 01                	push   $0x1
    3a6c:	50                   	push   %eax
    3a6d:	ff 75 08             	pushl  0x8(%ebp)
    3a70:	e8 8d fe ff ff       	call   3902 <write>
    3a75:	83 c4 10             	add    $0x10,%esp
    3a78:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    3a7b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    3a7f:	84 db                	test   %bl,%bl
    3a81:	74 77                	je     3afa <printf+0xca>
    if(state == 0){
    3a83:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    3a85:	0f be cb             	movsbl %bl,%ecx
    3a88:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3a8b:	74 cb                	je     3a58 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3a8d:	83 ff 25             	cmp    $0x25,%edi
    3a90:	75 e6                	jne    3a78 <printf+0x48>
      if(c == 'd'){
    3a92:	83 f8 64             	cmp    $0x64,%eax
    3a95:	0f 84 05 01 00 00    	je     3ba0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3a9b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3aa1:	83 f9 70             	cmp    $0x70,%ecx
    3aa4:	74 72                	je     3b18 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3aa6:	83 f8 73             	cmp    $0x73,%eax
    3aa9:	0f 84 99 00 00 00    	je     3b48 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3aaf:	83 f8 63             	cmp    $0x63,%eax
    3ab2:	0f 84 08 01 00 00    	je     3bc0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3ab8:	83 f8 25             	cmp    $0x25,%eax
    3abb:	0f 84 ef 00 00 00    	je     3bb0 <printf+0x180>
  write(fd, &c, 1);
    3ac1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3ac4:	83 ec 04             	sub    $0x4,%esp
    3ac7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3acb:	6a 01                	push   $0x1
    3acd:	50                   	push   %eax
    3ace:	ff 75 08             	pushl  0x8(%ebp)
    3ad1:	e8 2c fe ff ff       	call   3902 <write>
    3ad6:	83 c4 0c             	add    $0xc,%esp
    3ad9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3adc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    3adf:	6a 01                	push   $0x1
    3ae1:	50                   	push   %eax
    3ae2:	ff 75 08             	pushl  0x8(%ebp)
    3ae5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3ae8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    3aea:	e8 13 fe ff ff       	call   3902 <write>
  for(i = 0; fmt[i]; i++){
    3aef:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    3af3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3af6:	84 db                	test   %bl,%bl
    3af8:	75 89                	jne    3a83 <printf+0x53>
    }
  }
}
    3afa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3afd:	5b                   	pop    %ebx
    3afe:	5e                   	pop    %esi
    3aff:	5f                   	pop    %edi
    3b00:	5d                   	pop    %ebp
    3b01:	c3                   	ret    
    3b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    3b08:	bf 25 00 00 00       	mov    $0x25,%edi
    3b0d:	e9 66 ff ff ff       	jmp    3a78 <printf+0x48>
    3b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3b18:	83 ec 0c             	sub    $0xc,%esp
    3b1b:	b9 10 00 00 00       	mov    $0x10,%ecx
    3b20:	6a 00                	push   $0x0
    3b22:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    3b25:	8b 45 08             	mov    0x8(%ebp),%eax
    3b28:	8b 17                	mov    (%edi),%edx
    3b2a:	e8 61 fe ff ff       	call   3990 <printint>
        ap++;
    3b2f:	89 f8                	mov    %edi,%eax
    3b31:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b34:	31 ff                	xor    %edi,%edi
        ap++;
    3b36:	83 c0 04             	add    $0x4,%eax
    3b39:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3b3c:	e9 37 ff ff ff       	jmp    3a78 <printf+0x48>
    3b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3b48:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3b4b:	8b 08                	mov    (%eax),%ecx
        ap++;
    3b4d:	83 c0 04             	add    $0x4,%eax
    3b50:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    3b53:	85 c9                	test   %ecx,%ecx
    3b55:	0f 84 8e 00 00 00    	je     3be9 <printf+0x1b9>
        while(*s != 0){
    3b5b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    3b5e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    3b60:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    3b62:	84 c0                	test   %al,%al
    3b64:	0f 84 0e ff ff ff    	je     3a78 <printf+0x48>
    3b6a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    3b6d:	89 de                	mov    %ebx,%esi
    3b6f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3b72:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    3b75:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3b78:	83 ec 04             	sub    $0x4,%esp
          s++;
    3b7b:	83 c6 01             	add    $0x1,%esi
    3b7e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    3b81:	6a 01                	push   $0x1
    3b83:	57                   	push   %edi
    3b84:	53                   	push   %ebx
    3b85:	e8 78 fd ff ff       	call   3902 <write>
        while(*s != 0){
    3b8a:	0f b6 06             	movzbl (%esi),%eax
    3b8d:	83 c4 10             	add    $0x10,%esp
    3b90:	84 c0                	test   %al,%al
    3b92:	75 e4                	jne    3b78 <printf+0x148>
    3b94:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    3b97:	31 ff                	xor    %edi,%edi
    3b99:	e9 da fe ff ff       	jmp    3a78 <printf+0x48>
    3b9e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    3ba0:	83 ec 0c             	sub    $0xc,%esp
    3ba3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3ba8:	6a 01                	push   $0x1
    3baa:	e9 73 ff ff ff       	jmp    3b22 <printf+0xf2>
    3baf:	90                   	nop
  write(fd, &c, 1);
    3bb0:	83 ec 04             	sub    $0x4,%esp
    3bb3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    3bb6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3bb9:	6a 01                	push   $0x1
    3bbb:	e9 21 ff ff ff       	jmp    3ae1 <printf+0xb1>
        putc(fd, *ap);
    3bc0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    3bc3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3bc6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    3bc8:	6a 01                	push   $0x1
        ap++;
    3bca:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    3bcd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    3bd0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3bd3:	50                   	push   %eax
    3bd4:	ff 75 08             	pushl  0x8(%ebp)
    3bd7:	e8 26 fd ff ff       	call   3902 <write>
        ap++;
    3bdc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    3bdf:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3be2:	31 ff                	xor    %edi,%edi
    3be4:	e9 8f fe ff ff       	jmp    3a78 <printf+0x48>
          s = "(null)";
    3be9:	bb d9 55 00 00       	mov    $0x55d9,%ebx
        while(*s != 0){
    3bee:	b8 28 00 00 00       	mov    $0x28,%eax
    3bf3:	e9 72 ff ff ff       	jmp    3b6a <printf+0x13a>
    3bf8:	66 90                	xchg   %ax,%ax
    3bfa:	66 90                	xchg   %ax,%ax
    3bfc:	66 90                	xchg   %ax,%ax
    3bfe:	66 90                	xchg   %ax,%ax

00003c00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3c00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c01:	a1 c0 5f 00 00       	mov    0x5fc0,%eax
{
    3c06:	89 e5                	mov    %esp,%ebp
    3c08:	57                   	push   %edi
    3c09:	56                   	push   %esi
    3c0a:	53                   	push   %ebx
    3c0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3c0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    3c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3c18:	39 c8                	cmp    %ecx,%eax
    3c1a:	8b 10                	mov    (%eax),%edx
    3c1c:	73 32                	jae    3c50 <free+0x50>
    3c1e:	39 d1                	cmp    %edx,%ecx
    3c20:	72 04                	jb     3c26 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c22:	39 d0                	cmp    %edx,%eax
    3c24:	72 32                	jb     3c58 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3c26:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c29:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c2c:	39 fa                	cmp    %edi,%edx
    3c2e:	74 30                	je     3c60 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3c30:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c33:	8b 50 04             	mov    0x4(%eax),%edx
    3c36:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c39:	39 f1                	cmp    %esi,%ecx
    3c3b:	74 3a                	je     3c77 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3c3d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3c3f:	a3 c0 5f 00 00       	mov    %eax,0x5fc0
}
    3c44:	5b                   	pop    %ebx
    3c45:	5e                   	pop    %esi
    3c46:	5f                   	pop    %edi
    3c47:	5d                   	pop    %ebp
    3c48:	c3                   	ret    
    3c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c50:	39 d0                	cmp    %edx,%eax
    3c52:	72 04                	jb     3c58 <free+0x58>
    3c54:	39 d1                	cmp    %edx,%ecx
    3c56:	72 ce                	jb     3c26 <free+0x26>
{
    3c58:	89 d0                	mov    %edx,%eax
    3c5a:	eb bc                	jmp    3c18 <free+0x18>
    3c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    3c60:	03 72 04             	add    0x4(%edx),%esi
    3c63:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c66:	8b 10                	mov    (%eax),%edx
    3c68:	8b 12                	mov    (%edx),%edx
    3c6a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c6d:	8b 50 04             	mov    0x4(%eax),%edx
    3c70:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c73:	39 f1                	cmp    %esi,%ecx
    3c75:	75 c6                	jne    3c3d <free+0x3d>
    p->s.size += bp->s.size;
    3c77:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    3c7a:	a3 c0 5f 00 00       	mov    %eax,0x5fc0
    p->s.size += bp->s.size;
    3c7f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3c82:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3c85:	89 10                	mov    %edx,(%eax)
}
    3c87:	5b                   	pop    %ebx
    3c88:	5e                   	pop    %esi
    3c89:	5f                   	pop    %edi
    3c8a:	5d                   	pop    %ebp
    3c8b:	c3                   	ret    
    3c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003c90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3c90:	55                   	push   %ebp
    3c91:	89 e5                	mov    %esp,%ebp
    3c93:	57                   	push   %edi
    3c94:	56                   	push   %esi
    3c95:	53                   	push   %ebx
    3c96:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c9c:	8b 15 c0 5f 00 00    	mov    0x5fc0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3ca2:	8d 78 07             	lea    0x7(%eax),%edi
    3ca5:	c1 ef 03             	shr    $0x3,%edi
    3ca8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    3cab:	85 d2                	test   %edx,%edx
    3cad:	0f 84 9d 00 00 00    	je     3d50 <malloc+0xc0>
    3cb3:	8b 02                	mov    (%edx),%eax
    3cb5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3cb8:	39 cf                	cmp    %ecx,%edi
    3cba:	76 6c                	jbe    3d28 <malloc+0x98>
    3cbc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3cc2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3cc7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    3cca:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3cd1:	eb 0e                	jmp    3ce1 <malloc+0x51>
    3cd3:	90                   	nop
    3cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3cd8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3cda:	8b 48 04             	mov    0x4(%eax),%ecx
    3cdd:	39 f9                	cmp    %edi,%ecx
    3cdf:	73 47                	jae    3d28 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3ce1:	39 05 c0 5f 00 00    	cmp    %eax,0x5fc0
    3ce7:	89 c2                	mov    %eax,%edx
    3ce9:	75 ed                	jne    3cd8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3ceb:	83 ec 0c             	sub    $0xc,%esp
    3cee:	56                   	push   %esi
    3cef:	e8 76 fc ff ff       	call   396a <sbrk>
  if(p == (char*)-1)
    3cf4:	83 c4 10             	add    $0x10,%esp
    3cf7:	83 f8 ff             	cmp    $0xffffffff,%eax
    3cfa:	74 1c                	je     3d18 <malloc+0x88>
  hp->s.size = nu;
    3cfc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3cff:	83 ec 0c             	sub    $0xc,%esp
    3d02:	83 c0 08             	add    $0x8,%eax
    3d05:	50                   	push   %eax
    3d06:	e8 f5 fe ff ff       	call   3c00 <free>
  return freep;
    3d0b:	8b 15 c0 5f 00 00    	mov    0x5fc0,%edx
      if((p = morecore(nunits)) == 0)
    3d11:	83 c4 10             	add    $0x10,%esp
    3d14:	85 d2                	test   %edx,%edx
    3d16:	75 c0                	jne    3cd8 <malloc+0x48>
        return 0;
  }
}
    3d18:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3d1b:	31 c0                	xor    %eax,%eax
}
    3d1d:	5b                   	pop    %ebx
    3d1e:	5e                   	pop    %esi
    3d1f:	5f                   	pop    %edi
    3d20:	5d                   	pop    %ebp
    3d21:	c3                   	ret    
    3d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3d28:	39 cf                	cmp    %ecx,%edi
    3d2a:	74 54                	je     3d80 <malloc+0xf0>
        p->s.size -= nunits;
    3d2c:	29 f9                	sub    %edi,%ecx
    3d2e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3d31:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3d34:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    3d37:	89 15 c0 5f 00 00    	mov    %edx,0x5fc0
}
    3d3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3d40:	83 c0 08             	add    $0x8,%eax
}
    3d43:	5b                   	pop    %ebx
    3d44:	5e                   	pop    %esi
    3d45:	5f                   	pop    %edi
    3d46:	5d                   	pop    %ebp
    3d47:	c3                   	ret    
    3d48:	90                   	nop
    3d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    3d50:	c7 05 c0 5f 00 00 c4 	movl   $0x5fc4,0x5fc0
    3d57:	5f 00 00 
    3d5a:	c7 05 c4 5f 00 00 c4 	movl   $0x5fc4,0x5fc4
    3d61:	5f 00 00 
    base.s.size = 0;
    3d64:	b8 c4 5f 00 00       	mov    $0x5fc4,%eax
    3d69:	c7 05 c8 5f 00 00 00 	movl   $0x0,0x5fc8
    3d70:	00 00 00 
    3d73:	e9 44 ff ff ff       	jmp    3cbc <malloc+0x2c>
    3d78:	90                   	nop
    3d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    3d80:	8b 08                	mov    (%eax),%ecx
    3d82:	89 0a                	mov    %ecx,(%edx)
    3d84:	eb b1                	jmp    3d37 <malloc+0xa7>
