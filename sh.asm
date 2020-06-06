
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  static char buf[100];
  int fd;
  printf(1, "sh starts.\n");
      11:	68 69 12 00 00       	push   $0x1269
      16:	6a 01                	push   $0x1
      18:	e8 53 0e 00 00       	call   e70 <printf>
  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      1d:	83 c4 10             	add    $0x10,%esp
      20:	eb 0b                	jmp    2d <main+0x2d>
      22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(fd >= 3){
      28:	83 f8 02             	cmp    $0x2,%eax
      2b:	7f 76                	jg     a3 <main+0xa3>
  while((fd = open("console", O_RDWR)) >= 0){
      2d:	83 ec 08             	sub    $0x8,%esp
      30:	6a 02                	push   $0x2
      32:	68 75 12 00 00       	push   $0x1275
      37:	e8 26 0d 00 00       	call   d62 <open>
      3c:	83 c4 10             	add    $0x10,%esp
      3f:	85 c0                	test   %eax,%eax
      41:	79 e5                	jns    28 <main+0x28>
      43:	eb 1f                	jmp    64 <main+0x64>
      45:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      48:	80 3d a2 18 00 00 20 	cmpb   $0x20,0x18a2
      4f:	74 7a                	je     cb <main+0xcb>
int
fork1(void)
{
  int pid;

  pid = fork();
      51:	e8 c4 0c 00 00       	call   d1a <fork>
  if(pid == -1)
      56:	83 f8 ff             	cmp    $0xffffffff,%eax
      59:	74 3b                	je     96 <main+0x96>
    if(fork1() == 0)
      5b:	85 c0                	test   %eax,%eax
      5d:	74 57                	je     b6 <main+0xb6>
    wait();
      5f:	e8 c6 0c 00 00       	call   d2a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      64:	83 ec 08             	sub    $0x8,%esp
      67:	6a 64                	push   $0x64
      69:	68 a0 18 00 00       	push   $0x18a0
      6e:	e8 9d 00 00 00       	call   110 <getcmd>
      73:	83 c4 10             	add    $0x10,%esp
      76:	85 c0                	test   %eax,%eax
      78:	78 37                	js     b1 <main+0xb1>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      7a:	80 3d a0 18 00 00 63 	cmpb   $0x63,0x18a0
      81:	75 ce                	jne    51 <main+0x51>
      83:	80 3d a1 18 00 00 64 	cmpb   $0x64,0x18a1
      8a:	74 bc                	je     48 <main+0x48>
  pid = fork();
      8c:	e8 89 0c 00 00       	call   d1a <fork>
  if(pid == -1)
      91:	83 f8 ff             	cmp    $0xffffffff,%eax
      94:	75 c5                	jne    5b <main+0x5b>
    panic("fork");
      96:	83 ec 0c             	sub    $0xc,%esp
      99:	68 f2 11 00 00       	push   $0x11f2
      9e:	e8 bd 00 00 00       	call   160 <panic>
      close(fd);
      a3:	83 ec 0c             	sub    $0xc,%esp
      a6:	50                   	push   %eax
      a7:	e8 9e 0c 00 00       	call   d4a <close>
      break;
      ac:	83 c4 10             	add    $0x10,%esp
      af:	eb b3                	jmp    64 <main+0x64>
  exit();
      b1:	e8 6c 0c 00 00       	call   d22 <exit>
      runcmd(parsecmd(buf));
      b6:	83 ec 0c             	sub    $0xc,%esp
      b9:	68 a0 18 00 00       	push   $0x18a0
      be:	e8 9d 09 00 00       	call   a60 <parsecmd>
      c3:	89 04 24             	mov    %eax,(%esp)
      c6:	e8 b5 00 00 00       	call   180 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      cb:	83 ec 0c             	sub    $0xc,%esp
      ce:	68 a0 18 00 00       	push   $0x18a0
      d3:	e8 78 0a 00 00       	call   b50 <strlen>
      if(chdir(buf+3) < 0)
      d8:	c7 04 24 a3 18 00 00 	movl   $0x18a3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      df:	c6 80 9f 18 00 00 00 	movb   $0x0,0x189f(%eax)
      if(chdir(buf+3) < 0)
      e6:	e8 a7 0c 00 00       	call   d92 <chdir>
      eb:	83 c4 10             	add    $0x10,%esp
      ee:	85 c0                	test   %eax,%eax
      f0:	0f 89 6e ff ff ff    	jns    64 <main+0x64>
        printf(2, "cannot cd %s\n", buf+3);
      f6:	50                   	push   %eax
      f7:	68 a3 18 00 00       	push   $0x18a3
      fc:	68 7d 12 00 00       	push   $0x127d
     101:	6a 02                	push   $0x2
     103:	e8 68 0d 00 00       	call   e70 <printf>
     108:	83 c4 10             	add    $0x10,%esp
     10b:	e9 54 ff ff ff       	jmp    64 <main+0x64>

00000110 <getcmd>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	56                   	push   %esi
     114:	53                   	push   %ebx
     115:	8b 75 0c             	mov    0xc(%ebp),%esi
     118:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     11b:	83 ec 08             	sub    $0x8,%esp
     11e:	68 c8 11 00 00       	push   $0x11c8
     123:	6a 02                	push   $0x2
     125:	e8 46 0d 00 00       	call   e70 <printf>
  memset(buf, 0, nbuf);
     12a:	83 c4 0c             	add    $0xc,%esp
     12d:	56                   	push   %esi
     12e:	6a 00                	push   $0x0
     130:	53                   	push   %ebx
     131:	e8 4a 0a 00 00       	call   b80 <memset>
  gets(buf, nbuf);
     136:	58                   	pop    %eax
     137:	5a                   	pop    %edx
     138:	56                   	push   %esi
     139:	53                   	push   %ebx
     13a:	e8 a1 0a 00 00       	call   be0 <gets>
  if(buf[0] == 0) // EOF
     13f:	83 c4 10             	add    $0x10,%esp
     142:	31 c0                	xor    %eax,%eax
     144:	80 3b 00             	cmpb   $0x0,(%ebx)
     147:	0f 94 c0             	sete   %al
}
     14a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(buf[0] == 0) // EOF
     14d:	f7 d8                	neg    %eax
}
     14f:	5b                   	pop    %ebx
     150:	5e                   	pop    %esi
     151:	5d                   	pop    %ebp
     152:	c3                   	ret    
     153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <panic>:
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     166:	ff 75 08             	pushl  0x8(%ebp)
     169:	68 65 12 00 00       	push   $0x1265
     16e:	6a 02                	push   $0x2
     170:	e8 fb 0c 00 00       	call   e70 <printf>
  exit();
     175:	e8 a8 0b 00 00       	call   d22 <exit>
     17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <runcmd>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	53                   	push   %ebx
     184:	83 ec 14             	sub    $0x14,%esp
     187:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     18a:	85 db                	test   %ebx,%ebx
     18c:	74 3a                	je     1c8 <runcmd+0x48>
  switch(cmd->type){
     18e:	83 3b 05             	cmpl   $0x5,(%ebx)
     191:	0f 87 06 01 00 00    	ja     29d <runcmd+0x11d>
     197:	8b 03                	mov    (%ebx),%eax
     199:	ff 24 85 8c 12 00 00 	jmp    *0x128c(,%eax,4)
    if(ecmd->argv[0] == 0)
     1a0:	8b 43 04             	mov    0x4(%ebx),%eax
     1a3:	85 c0                	test   %eax,%eax
     1a5:	74 21                	je     1c8 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     1a7:	52                   	push   %edx
     1a8:	52                   	push   %edx
     1a9:	8d 53 04             	lea    0x4(%ebx),%edx
     1ac:	52                   	push   %edx
     1ad:	50                   	push   %eax
     1ae:	e8 a7 0b 00 00       	call   d5a <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     1b3:	83 c4 0c             	add    $0xc,%esp
     1b6:	ff 73 04             	pushl  0x4(%ebx)
     1b9:	68 d2 11 00 00       	push   $0x11d2
     1be:	6a 02                	push   $0x2
     1c0:	e8 ab 0c 00 00       	call   e70 <printf>
    break;
     1c5:	83 c4 10             	add    $0x10,%esp
    exit();
     1c8:	e8 55 0b 00 00       	call   d22 <exit>
  pid = fork();
     1cd:	e8 48 0b 00 00       	call   d1a <fork>
  if(pid == -1)
     1d2:	83 f8 ff             	cmp    $0xffffffff,%eax
     1d5:	0f 84 cf 00 00 00    	je     2aa <runcmd+0x12a>
    if(fork1() == 0)
     1db:	85 c0                	test   %eax,%eax
     1dd:	75 e9                	jne    1c8 <runcmd+0x48>
      runcmd(bcmd->cmd);
     1df:	83 ec 0c             	sub    $0xc,%esp
     1e2:	ff 73 04             	pushl  0x4(%ebx)
     1e5:	e8 96 ff ff ff       	call   180 <runcmd>
    close(rcmd->fd);
     1ea:	83 ec 0c             	sub    $0xc,%esp
     1ed:	ff 73 14             	pushl  0x14(%ebx)
     1f0:	e8 55 0b 00 00       	call   d4a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1f5:	59                   	pop    %ecx
     1f6:	58                   	pop    %eax
     1f7:	ff 73 10             	pushl  0x10(%ebx)
     1fa:	ff 73 08             	pushl  0x8(%ebx)
     1fd:	e8 60 0b 00 00       	call   d62 <open>
     202:	83 c4 10             	add    $0x10,%esp
     205:	85 c0                	test   %eax,%eax
     207:	79 d6                	jns    1df <runcmd+0x5f>
      printf(2, "open %s failed\n", rcmd->file);
     209:	52                   	push   %edx
     20a:	ff 73 08             	pushl  0x8(%ebx)
     20d:	68 e2 11 00 00       	push   $0x11e2
     212:	6a 02                	push   $0x2
     214:	e8 57 0c 00 00       	call   e70 <printf>
      exit();
     219:	e8 04 0b 00 00       	call   d22 <exit>
    if(pipe(p) < 0)
     21e:	8d 45 f0             	lea    -0x10(%ebp),%eax
     221:	83 ec 0c             	sub    $0xc,%esp
     224:	50                   	push   %eax
     225:	e8 08 0b 00 00       	call   d32 <pipe>
     22a:	83 c4 10             	add    $0x10,%esp
     22d:	85 c0                	test   %eax,%eax
     22f:	0f 88 b0 00 00 00    	js     2e5 <runcmd+0x165>
  pid = fork();
     235:	e8 e0 0a 00 00       	call   d1a <fork>
  if(pid == -1)
     23a:	83 f8 ff             	cmp    $0xffffffff,%eax
     23d:	74 6b                	je     2aa <runcmd+0x12a>
    if(fork1() == 0){
     23f:	85 c0                	test   %eax,%eax
     241:	0f 84 ab 00 00 00    	je     2f2 <runcmd+0x172>
  pid = fork();
     247:	e8 ce 0a 00 00       	call   d1a <fork>
  if(pid == -1)
     24c:	83 f8 ff             	cmp    $0xffffffff,%eax
     24f:	74 59                	je     2aa <runcmd+0x12a>
    if(fork1() == 0){
     251:	85 c0                	test   %eax,%eax
     253:	74 62                	je     2b7 <runcmd+0x137>
    close(p[0]);
     255:	83 ec 0c             	sub    $0xc,%esp
     258:	ff 75 f0             	pushl  -0x10(%ebp)
     25b:	e8 ea 0a 00 00       	call   d4a <close>
    close(p[1]);
     260:	58                   	pop    %eax
     261:	ff 75 f4             	pushl  -0xc(%ebp)
     264:	e8 e1 0a 00 00       	call   d4a <close>
    wait();
     269:	e8 bc 0a 00 00       	call   d2a <wait>
    wait();
     26e:	e8 b7 0a 00 00       	call   d2a <wait>
    break;
     273:	83 c4 10             	add    $0x10,%esp
     276:	e9 4d ff ff ff       	jmp    1c8 <runcmd+0x48>
  pid = fork();
     27b:	e8 9a 0a 00 00       	call   d1a <fork>
  if(pid == -1)
     280:	83 f8 ff             	cmp    $0xffffffff,%eax
     283:	74 25                	je     2aa <runcmd+0x12a>
    if(fork1() == 0)
     285:	85 c0                	test   %eax,%eax
     287:	0f 84 52 ff ff ff    	je     1df <runcmd+0x5f>
    wait();
     28d:	e8 98 0a 00 00       	call   d2a <wait>
    runcmd(lcmd->right);
     292:	83 ec 0c             	sub    $0xc,%esp
     295:	ff 73 08             	pushl  0x8(%ebx)
     298:	e8 e3 fe ff ff       	call   180 <runcmd>
    panic("runcmd");
     29d:	83 ec 0c             	sub    $0xc,%esp
     2a0:	68 cb 11 00 00       	push   $0x11cb
     2a5:	e8 b6 fe ff ff       	call   160 <panic>
    panic("fork");
     2aa:	83 ec 0c             	sub    $0xc,%esp
     2ad:	68 f2 11 00 00       	push   $0x11f2
     2b2:	e8 a9 fe ff ff       	call   160 <panic>
      close(0);
     2b7:	83 ec 0c             	sub    $0xc,%esp
     2ba:	6a 00                	push   $0x0
     2bc:	e8 89 0a 00 00       	call   d4a <close>
      dup(p[0]);
     2c1:	5a                   	pop    %edx
     2c2:	ff 75 f0             	pushl  -0x10(%ebp)
     2c5:	e8 d0 0a 00 00       	call   d9a <dup>
      close(p[0]);
     2ca:	59                   	pop    %ecx
     2cb:	ff 75 f0             	pushl  -0x10(%ebp)
     2ce:	e8 77 0a 00 00       	call   d4a <close>
      close(p[1]);
     2d3:	58                   	pop    %eax
     2d4:	ff 75 f4             	pushl  -0xc(%ebp)
     2d7:	e8 6e 0a 00 00       	call   d4a <close>
      runcmd(pcmd->right);
     2dc:	58                   	pop    %eax
     2dd:	ff 73 08             	pushl  0x8(%ebx)
     2e0:	e8 9b fe ff ff       	call   180 <runcmd>
      panic("pipe");
     2e5:	83 ec 0c             	sub    $0xc,%esp
     2e8:	68 f7 11 00 00       	push   $0x11f7
     2ed:	e8 6e fe ff ff       	call   160 <panic>
      close(1);
     2f2:	83 ec 0c             	sub    $0xc,%esp
     2f5:	6a 01                	push   $0x1
     2f7:	e8 4e 0a 00 00       	call   d4a <close>
      dup(p[1]);
     2fc:	58                   	pop    %eax
     2fd:	ff 75 f4             	pushl  -0xc(%ebp)
     300:	e8 95 0a 00 00       	call   d9a <dup>
      close(p[0]);
     305:	58                   	pop    %eax
     306:	ff 75 f0             	pushl  -0x10(%ebp)
     309:	e8 3c 0a 00 00       	call   d4a <close>
      close(p[1]);
     30e:	58                   	pop    %eax
     30f:	ff 75 f4             	pushl  -0xc(%ebp)
     312:	e8 33 0a 00 00       	call   d4a <close>
      runcmd(pcmd->left);
     317:	58                   	pop    %eax
     318:	ff 73 04             	pushl  0x4(%ebx)
     31b:	e8 60 fe ff ff       	call   180 <runcmd>

00000320 <fork1>:
{
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     326:	e8 ef 09 00 00       	call   d1a <fork>
  if(pid == -1)
     32b:	83 f8 ff             	cmp    $0xffffffff,%eax
     32e:	74 02                	je     332 <fork1+0x12>
  return pid;
}
     330:	c9                   	leave  
     331:	c3                   	ret    
    panic("fork");
     332:	83 ec 0c             	sub    $0xc,%esp
     335:	68 f2 11 00 00       	push   $0x11f2
     33a:	e8 21 fe ff ff       	call   160 <panic>
     33f:	90                   	nop

00000340 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	53                   	push   %ebx
     344:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     347:	6a 54                	push   $0x54
     349:	e8 82 0d 00 00       	call   10d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     34e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     351:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     353:	6a 54                	push   $0x54
     355:	6a 00                	push   $0x0
     357:	50                   	push   %eax
     358:	e8 23 08 00 00       	call   b80 <memset>
  cmd->type = EXEC;
     35d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     363:	89 d8                	mov    %ebx,%eax
     365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     368:	c9                   	leave  
     369:	c3                   	ret    
     36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000370 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	53                   	push   %ebx
     374:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     377:	6a 18                	push   $0x18
     379:	e8 52 0d 00 00       	call   10d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     37e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     381:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     383:	6a 18                	push   $0x18
     385:	6a 00                	push   $0x0
     387:	50                   	push   %eax
     388:	e8 f3 07 00 00       	call   b80 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     38d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     390:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     396:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     39f:	8b 45 10             	mov    0x10(%ebp),%eax
     3a2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3a5:	8b 45 14             	mov    0x14(%ebp),%eax
     3a8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3ab:	8b 45 18             	mov    0x18(%ebp),%eax
     3ae:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3b1:	89 d8                	mov    %ebx,%eax
     3b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3b6:	c9                   	leave  
     3b7:	c3                   	ret    
     3b8:	90                   	nop
     3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003c0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	53                   	push   %ebx
     3c4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c7:	6a 0c                	push   $0xc
     3c9:	e8 02 0d 00 00       	call   10d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ce:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3d1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d3:	6a 0c                	push   $0xc
     3d5:	6a 00                	push   $0x0
     3d7:	50                   	push   %eax
     3d8:	e8 a3 07 00 00       	call   b80 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     3e0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3e6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ec:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ef:	89 d8                	mov    %ebx,%eax
     3f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3f4:	c9                   	leave  
     3f5:	c3                   	ret    
     3f6:	8d 76 00             	lea    0x0(%esi),%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     407:	6a 0c                	push   $0xc
     409:	e8 c2 0c 00 00       	call   10d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     40e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     411:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     413:	6a 0c                	push   $0xc
     415:	6a 00                	push   $0x0
     417:	50                   	push   %eax
     418:	e8 63 07 00 00       	call   b80 <memset>
  cmd->type = LIST;
  cmd->left = left;
     41d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     420:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     426:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     429:	8b 45 0c             	mov    0xc(%ebp),%eax
     42c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     42f:	89 d8                	mov    %ebx,%eax
     431:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     434:	c9                   	leave  
     435:	c3                   	ret    
     436:	8d 76 00             	lea    0x0(%esi),%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     447:	6a 08                	push   $0x8
     449:	e8 82 0c 00 00       	call   10d0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     44e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     451:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     453:	6a 08                	push   $0x8
     455:	6a 00                	push   $0x0
     457:	50                   	push   %eax
     458:	e8 23 07 00 00       	call   b80 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     45d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     460:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     466:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     469:	89 d8                	mov    %ebx,%eax
     46b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     46e:	c9                   	leave  
     46f:	c3                   	ret    

00000470 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	57                   	push   %edi
     474:	56                   	push   %esi
     475:	53                   	push   %ebx
     476:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     479:	8b 45 08             	mov    0x8(%ebp),%eax
{
     47c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     47f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     482:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     484:	39 de                	cmp    %ebx,%esi
     486:	72 0f                	jb     497 <gettoken+0x27>
     488:	eb 25                	jmp    4af <gettoken+0x3f>
     48a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     490:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     493:	39 f3                	cmp    %esi,%ebx
     495:	74 18                	je     4af <gettoken+0x3f>
     497:	0f be 06             	movsbl (%esi),%eax
     49a:	83 ec 08             	sub    $0x8,%esp
     49d:	50                   	push   %eax
     49e:	68 88 18 00 00       	push   $0x1888
     4a3:	e8 f8 06 00 00       	call   ba0 <strchr>
     4a8:	83 c4 10             	add    $0x10,%esp
     4ab:	85 c0                	test   %eax,%eax
     4ad:	75 e1                	jne    490 <gettoken+0x20>
  if(q)
     4af:	85 ff                	test   %edi,%edi
     4b1:	74 02                	je     4b5 <gettoken+0x45>
    *q = s;
     4b3:	89 37                	mov    %esi,(%edi)
  ret = *s;
     4b5:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     4b8:	3c 29                	cmp    $0x29,%al
     4ba:	7f 54                	jg     510 <gettoken+0xa0>
     4bc:	3c 28                	cmp    $0x28,%al
     4be:	0f 8d c8 00 00 00    	jge    58c <gettoken+0x11c>
     4c4:	31 ff                	xor    %edi,%edi
     4c6:	84 c0                	test   %al,%al
     4c8:	0f 85 d2 00 00 00    	jne    5a0 <gettoken+0x130>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4ce:	8b 55 14             	mov    0x14(%ebp),%edx
     4d1:	85 d2                	test   %edx,%edx
     4d3:	74 05                	je     4da <gettoken+0x6a>
    *eq = s;
     4d5:	8b 45 14             	mov    0x14(%ebp),%eax
     4d8:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4da:	39 de                	cmp    %ebx,%esi
     4dc:	72 09                	jb     4e7 <gettoken+0x77>
     4de:	eb 1f                	jmp    4ff <gettoken+0x8f>
    s++;
     4e0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4e3:	39 f3                	cmp    %esi,%ebx
     4e5:	74 18                	je     4ff <gettoken+0x8f>
     4e7:	0f be 06             	movsbl (%esi),%eax
     4ea:	83 ec 08             	sub    $0x8,%esp
     4ed:	50                   	push   %eax
     4ee:	68 88 18 00 00       	push   $0x1888
     4f3:	e8 a8 06 00 00       	call   ba0 <strchr>
     4f8:	83 c4 10             	add    $0x10,%esp
     4fb:	85 c0                	test   %eax,%eax
     4fd:	75 e1                	jne    4e0 <gettoken+0x70>
  *ps = s;
     4ff:	8b 45 08             	mov    0x8(%ebp),%eax
     502:	89 30                	mov    %esi,(%eax)
  return ret;
}
     504:	8d 65 f4             	lea    -0xc(%ebp),%esp
     507:	89 f8                	mov    %edi,%eax
     509:	5b                   	pop    %ebx
     50a:	5e                   	pop    %esi
     50b:	5f                   	pop    %edi
     50c:	5d                   	pop    %ebp
     50d:	c3                   	ret    
     50e:	66 90                	xchg   %ax,%ax
  switch(*s){
     510:	3c 3e                	cmp    $0x3e,%al
     512:	75 1c                	jne    530 <gettoken+0xc0>
    if(*s == '>'){
     514:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     518:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     51b:	0f 84 a4 00 00 00    	je     5c5 <gettoken+0x155>
    s++;
     521:	89 c6                	mov    %eax,%esi
     523:	bf 3e 00 00 00       	mov    $0x3e,%edi
     528:	eb a4                	jmp    4ce <gettoken+0x5e>
     52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     530:	7f 56                	jg     588 <gettoken+0x118>
     532:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     535:	80 f9 01             	cmp    $0x1,%cl
     538:	76 52                	jbe    58c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     53a:	39 f3                	cmp    %esi,%ebx
     53c:	77 24                	ja     562 <gettoken+0xf2>
     53e:	eb 70                	jmp    5b0 <gettoken+0x140>
     540:	0f be 06             	movsbl (%esi),%eax
     543:	83 ec 08             	sub    $0x8,%esp
     546:	50                   	push   %eax
     547:	68 80 18 00 00       	push   $0x1880
     54c:	e8 4f 06 00 00       	call   ba0 <strchr>
     551:	83 c4 10             	add    $0x10,%esp
     554:	85 c0                	test   %eax,%eax
     556:	75 1f                	jne    577 <gettoken+0x107>
      s++;
     558:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     55b:	39 f3                	cmp    %esi,%ebx
     55d:	74 51                	je     5b0 <gettoken+0x140>
     55f:	0f be 06             	movsbl (%esi),%eax
     562:	83 ec 08             	sub    $0x8,%esp
     565:	50                   	push   %eax
     566:	68 88 18 00 00       	push   $0x1888
     56b:	e8 30 06 00 00       	call   ba0 <strchr>
     570:	83 c4 10             	add    $0x10,%esp
     573:	85 c0                	test   %eax,%eax
     575:	74 c9                	je     540 <gettoken+0xd0>
    ret = 'a';
     577:	bf 61 00 00 00       	mov    $0x61,%edi
     57c:	e9 4d ff ff ff       	jmp    4ce <gettoken+0x5e>
     581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     588:	3c 7c                	cmp    $0x7c,%al
     58a:	75 ae                	jne    53a <gettoken+0xca>
  ret = *s;
     58c:	0f be f8             	movsbl %al,%edi
    s++;
     58f:	83 c6 01             	add    $0x1,%esi
    break;
     592:	e9 37 ff ff ff       	jmp    4ce <gettoken+0x5e>
     597:	89 f6                	mov    %esi,%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  switch(*s){
     5a0:	3c 26                	cmp    $0x26,%al
     5a2:	75 96                	jne    53a <gettoken+0xca>
     5a4:	eb e6                	jmp    58c <gettoken+0x11c>
     5a6:	8d 76 00             	lea    0x0(%esi),%esi
     5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(eq)
     5b0:	8b 45 14             	mov    0x14(%ebp),%eax
     5b3:	bf 61 00 00 00       	mov    $0x61,%edi
     5b8:	85 c0                	test   %eax,%eax
     5ba:	0f 85 15 ff ff ff    	jne    4d5 <gettoken+0x65>
     5c0:	e9 3a ff ff ff       	jmp    4ff <gettoken+0x8f>
      s++;
     5c5:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     5c8:	bf 2b 00 00 00       	mov    $0x2b,%edi
     5cd:	e9 fc fe ff ff       	jmp    4ce <gettoken+0x5e>
     5d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005e0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	57                   	push   %edi
     5e4:	56                   	push   %esi
     5e5:	53                   	push   %ebx
     5e6:	83 ec 0c             	sub    $0xc,%esp
     5e9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5ef:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5f1:	39 f3                	cmp    %esi,%ebx
     5f3:	72 12                	jb     607 <peek+0x27>
     5f5:	eb 28                	jmp    61f <peek+0x3f>
     5f7:	89 f6                	mov    %esi,%esi
     5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     600:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     603:	39 de                	cmp    %ebx,%esi
     605:	74 18                	je     61f <peek+0x3f>
     607:	0f be 03             	movsbl (%ebx),%eax
     60a:	83 ec 08             	sub    $0x8,%esp
     60d:	50                   	push   %eax
     60e:	68 88 18 00 00       	push   $0x1888
     613:	e8 88 05 00 00       	call   ba0 <strchr>
     618:	83 c4 10             	add    $0x10,%esp
     61b:	85 c0                	test   %eax,%eax
     61d:	75 e1                	jne    600 <peek+0x20>
  *ps = s;
     61f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     621:	0f be 13             	movsbl (%ebx),%edx
     624:	31 c0                	xor    %eax,%eax
     626:	84 d2                	test   %dl,%dl
     628:	74 17                	je     641 <peek+0x61>
     62a:	83 ec 08             	sub    $0x8,%esp
     62d:	52                   	push   %edx
     62e:	ff 75 10             	pushl  0x10(%ebp)
     631:	e8 6a 05 00 00       	call   ba0 <strchr>
     636:	83 c4 10             	add    $0x10,%esp
     639:	85 c0                	test   %eax,%eax
     63b:	0f 95 c0             	setne  %al
     63e:	0f b6 c0             	movzbl %al,%eax
}
     641:	8d 65 f4             	lea    -0xc(%ebp),%esp
     644:	5b                   	pop    %ebx
     645:	5e                   	pop    %esi
     646:	5f                   	pop    %edi
     647:	5d                   	pop    %ebp
     648:	c3                   	ret    
     649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000650 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	57                   	push   %edi
     654:	56                   	push   %esi
     655:	53                   	push   %ebx
     656:	83 ec 1c             	sub    $0x1c,%esp
     659:	8b 75 0c             	mov    0xc(%ebp),%esi
     65c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     65f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     660:	83 ec 04             	sub    $0x4,%esp
     663:	68 19 12 00 00       	push   $0x1219
     668:	53                   	push   %ebx
     669:	56                   	push   %esi
     66a:	e8 71 ff ff ff       	call   5e0 <peek>
     66f:	83 c4 10             	add    $0x10,%esp
     672:	85 c0                	test   %eax,%eax
     674:	74 6a                	je     6e0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     676:	6a 00                	push   $0x0
     678:	6a 00                	push   $0x0
     67a:	53                   	push   %ebx
     67b:	56                   	push   %esi
     67c:	e8 ef fd ff ff       	call   470 <gettoken>
     681:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     683:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     686:	50                   	push   %eax
     687:	8d 45 e0             	lea    -0x20(%ebp),%eax
     68a:	50                   	push   %eax
     68b:	53                   	push   %ebx
     68c:	56                   	push   %esi
     68d:	e8 de fd ff ff       	call   470 <gettoken>
     692:	83 c4 20             	add    $0x20,%esp
     695:	83 f8 61             	cmp    $0x61,%eax
     698:	75 51                	jne    6eb <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     69a:	83 ff 3c             	cmp    $0x3c,%edi
     69d:	74 31                	je     6d0 <parseredirs+0x80>
     69f:	83 ff 3e             	cmp    $0x3e,%edi
     6a2:	74 05                	je     6a9 <parseredirs+0x59>
     6a4:	83 ff 2b             	cmp    $0x2b,%edi
     6a7:	75 b7                	jne    660 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6a9:	83 ec 0c             	sub    $0xc,%esp
     6ac:	6a 01                	push   $0x1
     6ae:	68 01 02 00 00       	push   $0x201
     6b3:	ff 75 e4             	pushl  -0x1c(%ebp)
     6b6:	ff 75 e0             	pushl  -0x20(%ebp)
     6b9:	ff 75 08             	pushl  0x8(%ebp)
     6bc:	e8 af fc ff ff       	call   370 <redircmd>
      break;
     6c1:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6c4:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6c7:	eb 97                	jmp    660 <parseredirs+0x10>
     6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6d0:	83 ec 0c             	sub    $0xc,%esp
     6d3:	6a 00                	push   $0x0
     6d5:	6a 00                	push   $0x0
     6d7:	eb da                	jmp    6b3 <parseredirs+0x63>
     6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     6e0:	8b 45 08             	mov    0x8(%ebp),%eax
     6e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6e6:	5b                   	pop    %ebx
     6e7:	5e                   	pop    %esi
     6e8:	5f                   	pop    %edi
     6e9:	5d                   	pop    %ebp
     6ea:	c3                   	ret    
      panic("missing file for redirection");
     6eb:	83 ec 0c             	sub    $0xc,%esp
     6ee:	68 fc 11 00 00       	push   $0x11fc
     6f3:	e8 68 fa ff ff       	call   160 <panic>
     6f8:	90                   	nop
     6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000700 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	83 ec 30             	sub    $0x30,%esp
     709:	8b 75 08             	mov    0x8(%ebp),%esi
     70c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     70f:	68 1c 12 00 00       	push   $0x121c
     714:	57                   	push   %edi
     715:	56                   	push   %esi
     716:	e8 c5 fe ff ff       	call   5e0 <peek>
     71b:	83 c4 10             	add    $0x10,%esp
     71e:	85 c0                	test   %eax,%eax
     720:	0f 85 92 00 00 00    	jne    7b8 <parseexec+0xb8>
     726:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     728:	e8 13 fc ff ff       	call   340 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     72d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     730:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     733:	57                   	push   %edi
     734:	56                   	push   %esi
     735:	50                   	push   %eax
     736:	e8 15 ff ff ff       	call   650 <parseredirs>
     73b:	83 c4 10             	add    $0x10,%esp
     73e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     741:	eb 18                	jmp    75b <parseexec+0x5b>
     743:	90                   	nop
     744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     748:	83 ec 04             	sub    $0x4,%esp
     74b:	57                   	push   %edi
     74c:	56                   	push   %esi
     74d:	ff 75 d4             	pushl  -0x2c(%ebp)
     750:	e8 fb fe ff ff       	call   650 <parseredirs>
     755:	83 c4 10             	add    $0x10,%esp
     758:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     75b:	83 ec 04             	sub    $0x4,%esp
     75e:	68 33 12 00 00       	push   $0x1233
     763:	57                   	push   %edi
     764:	56                   	push   %esi
     765:	e8 76 fe ff ff       	call   5e0 <peek>
     76a:	83 c4 10             	add    $0x10,%esp
     76d:	85 c0                	test   %eax,%eax
     76f:	75 67                	jne    7d8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     771:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     774:	50                   	push   %eax
     775:	8d 45 e0             	lea    -0x20(%ebp),%eax
     778:	50                   	push   %eax
     779:	57                   	push   %edi
     77a:	56                   	push   %esi
     77b:	e8 f0 fc ff ff       	call   470 <gettoken>
     780:	83 c4 10             	add    $0x10,%esp
     783:	85 c0                	test   %eax,%eax
     785:	74 51                	je     7d8 <parseexec+0xd8>
    if(tok != 'a')
     787:	83 f8 61             	cmp    $0x61,%eax
     78a:	75 6b                	jne    7f7 <parseexec+0xf7>
    cmd->argv[argc] = q;
     78c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     78f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     792:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     796:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     799:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     79d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     7a0:	83 fb 0a             	cmp    $0xa,%ebx
     7a3:	75 a3                	jne    748 <parseexec+0x48>
      panic("too many args");
     7a5:	83 ec 0c             	sub    $0xc,%esp
     7a8:	68 25 12 00 00       	push   $0x1225
     7ad:	e8 ae f9 ff ff       	call   160 <panic>
     7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7b8:	83 ec 08             	sub    $0x8,%esp
     7bb:	57                   	push   %edi
     7bc:	56                   	push   %esi
     7bd:	e8 5e 01 00 00       	call   920 <parseblock>
     7c2:	83 c4 10             	add    $0x10,%esp
     7c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7ce:	5b                   	pop    %ebx
     7cf:	5e                   	pop    %esi
     7d0:	5f                   	pop    %edi
     7d1:	5d                   	pop    %ebp
     7d2:	c3                   	ret    
     7d3:	90                   	nop
     7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7db:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     7de:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7e5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     7ec:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7f2:	5b                   	pop    %ebx
     7f3:	5e                   	pop    %esi
     7f4:	5f                   	pop    %edi
     7f5:	5d                   	pop    %ebp
     7f6:	c3                   	ret    
      panic("syntax");
     7f7:	83 ec 0c             	sub    $0xc,%esp
     7fa:	68 1e 12 00 00       	push   $0x121e
     7ff:	e8 5c f9 ff ff       	call   160 <panic>
     804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     80a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000810 <parsepipe>:
{
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	57                   	push   %edi
     814:	56                   	push   %esi
     815:	53                   	push   %ebx
     816:	83 ec 14             	sub    $0x14,%esp
     819:	8b 5d 08             	mov    0x8(%ebp),%ebx
     81c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     81f:	56                   	push   %esi
     820:	53                   	push   %ebx
     821:	e8 da fe ff ff       	call   700 <parseexec>
  if(peek(ps, es, "|")){
     826:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     829:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     82b:	68 38 12 00 00       	push   $0x1238
     830:	56                   	push   %esi
     831:	53                   	push   %ebx
     832:	e8 a9 fd ff ff       	call   5e0 <peek>
     837:	83 c4 10             	add    $0x10,%esp
     83a:	85 c0                	test   %eax,%eax
     83c:	75 12                	jne    850 <parsepipe+0x40>
}
     83e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     841:	89 f8                	mov    %edi,%eax
     843:	5b                   	pop    %ebx
     844:	5e                   	pop    %esi
     845:	5f                   	pop    %edi
     846:	5d                   	pop    %ebp
     847:	c3                   	ret    
     848:	90                   	nop
     849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     850:	6a 00                	push   $0x0
     852:	6a 00                	push   $0x0
     854:	56                   	push   %esi
     855:	53                   	push   %ebx
     856:	e8 15 fc ff ff       	call   470 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     85b:	58                   	pop    %eax
     85c:	5a                   	pop    %edx
     85d:	56                   	push   %esi
     85e:	53                   	push   %ebx
     85f:	e8 ac ff ff ff       	call   810 <parsepipe>
     864:	89 7d 08             	mov    %edi,0x8(%ebp)
     867:	89 45 0c             	mov    %eax,0xc(%ebp)
     86a:	83 c4 10             	add    $0x10,%esp
}
     86d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     870:	5b                   	pop    %ebx
     871:	5e                   	pop    %esi
     872:	5f                   	pop    %edi
     873:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     874:	e9 47 fb ff ff       	jmp    3c0 <pipecmd>
     879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000880 <parseline>:
{
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	57                   	push   %edi
     884:	56                   	push   %esi
     885:	53                   	push   %ebx
     886:	83 ec 14             	sub    $0x14,%esp
     889:	8b 5d 08             	mov    0x8(%ebp),%ebx
     88c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     88f:	56                   	push   %esi
     890:	53                   	push   %ebx
     891:	e8 7a ff ff ff       	call   810 <parsepipe>
  while(peek(ps, es, "&")){
     896:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     899:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     89b:	eb 1b                	jmp    8b8 <parseline+0x38>
     89d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8a0:	6a 00                	push   $0x0
     8a2:	6a 00                	push   $0x0
     8a4:	56                   	push   %esi
     8a5:	53                   	push   %ebx
     8a6:	e8 c5 fb ff ff       	call   470 <gettoken>
    cmd = backcmd(cmd);
     8ab:	89 3c 24             	mov    %edi,(%esp)
     8ae:	e8 8d fb ff ff       	call   440 <backcmd>
     8b3:	83 c4 10             	add    $0x10,%esp
     8b6:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8b8:	83 ec 04             	sub    $0x4,%esp
     8bb:	68 3a 12 00 00       	push   $0x123a
     8c0:	56                   	push   %esi
     8c1:	53                   	push   %ebx
     8c2:	e8 19 fd ff ff       	call   5e0 <peek>
     8c7:	83 c4 10             	add    $0x10,%esp
     8ca:	85 c0                	test   %eax,%eax
     8cc:	75 d2                	jne    8a0 <parseline+0x20>
  if(peek(ps, es, ";")){
     8ce:	83 ec 04             	sub    $0x4,%esp
     8d1:	68 36 12 00 00       	push   $0x1236
     8d6:	56                   	push   %esi
     8d7:	53                   	push   %ebx
     8d8:	e8 03 fd ff ff       	call   5e0 <peek>
     8dd:	83 c4 10             	add    $0x10,%esp
     8e0:	85 c0                	test   %eax,%eax
     8e2:	75 0c                	jne    8f0 <parseline+0x70>
}
     8e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8e7:	89 f8                	mov    %edi,%eax
     8e9:	5b                   	pop    %ebx
     8ea:	5e                   	pop    %esi
     8eb:	5f                   	pop    %edi
     8ec:	5d                   	pop    %ebp
     8ed:	c3                   	ret    
     8ee:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     8f0:	6a 00                	push   $0x0
     8f2:	6a 00                	push   $0x0
     8f4:	56                   	push   %esi
     8f5:	53                   	push   %ebx
     8f6:	e8 75 fb ff ff       	call   470 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8fb:	58                   	pop    %eax
     8fc:	5a                   	pop    %edx
     8fd:	56                   	push   %esi
     8fe:	53                   	push   %ebx
     8ff:	e8 7c ff ff ff       	call   880 <parseline>
     904:	89 7d 08             	mov    %edi,0x8(%ebp)
     907:	89 45 0c             	mov    %eax,0xc(%ebp)
     90a:	83 c4 10             	add    $0x10,%esp
}
     90d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     910:	5b                   	pop    %ebx
     911:	5e                   	pop    %esi
     912:	5f                   	pop    %edi
     913:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     914:	e9 e7 fa ff ff       	jmp    400 <listcmd>
     919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000920 <parseblock>:
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	57                   	push   %edi
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	83 ec 10             	sub    $0x10,%esp
     929:	8b 5d 08             	mov    0x8(%ebp),%ebx
     92c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     92f:	68 1c 12 00 00       	push   $0x121c
     934:	56                   	push   %esi
     935:	53                   	push   %ebx
     936:	e8 a5 fc ff ff       	call   5e0 <peek>
     93b:	83 c4 10             	add    $0x10,%esp
     93e:	85 c0                	test   %eax,%eax
     940:	74 4a                	je     98c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     942:	6a 00                	push   $0x0
     944:	6a 00                	push   $0x0
     946:	56                   	push   %esi
     947:	53                   	push   %ebx
     948:	e8 23 fb ff ff       	call   470 <gettoken>
  cmd = parseline(ps, es);
     94d:	58                   	pop    %eax
     94e:	5a                   	pop    %edx
     94f:	56                   	push   %esi
     950:	53                   	push   %ebx
     951:	e8 2a ff ff ff       	call   880 <parseline>
  if(!peek(ps, es, ")"))
     956:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     959:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     95b:	68 58 12 00 00       	push   $0x1258
     960:	56                   	push   %esi
     961:	53                   	push   %ebx
     962:	e8 79 fc ff ff       	call   5e0 <peek>
     967:	83 c4 10             	add    $0x10,%esp
     96a:	85 c0                	test   %eax,%eax
     96c:	74 2b                	je     999 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     96e:	6a 00                	push   $0x0
     970:	6a 00                	push   $0x0
     972:	56                   	push   %esi
     973:	53                   	push   %ebx
     974:	e8 f7 fa ff ff       	call   470 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     979:	83 c4 0c             	add    $0xc,%esp
     97c:	56                   	push   %esi
     97d:	53                   	push   %ebx
     97e:	57                   	push   %edi
     97f:	e8 cc fc ff ff       	call   650 <parseredirs>
}
     984:	8d 65 f4             	lea    -0xc(%ebp),%esp
     987:	5b                   	pop    %ebx
     988:	5e                   	pop    %esi
     989:	5f                   	pop    %edi
     98a:	5d                   	pop    %ebp
     98b:	c3                   	ret    
    panic("parseblock");
     98c:	83 ec 0c             	sub    $0xc,%esp
     98f:	68 3c 12 00 00       	push   $0x123c
     994:	e8 c7 f7 ff ff       	call   160 <panic>
    panic("syntax - missing )");
     999:	83 ec 0c             	sub    $0xc,%esp
     99c:	68 47 12 00 00       	push   $0x1247
     9a1:	e8 ba f7 ff ff       	call   160 <panic>
     9a6:	8d 76 00             	lea    0x0(%esi),%esi
     9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	53                   	push   %ebx
     9b4:	83 ec 04             	sub    $0x4,%esp
     9b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9ba:	85 db                	test   %ebx,%ebx
     9bc:	74 20                	je     9de <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     9be:	83 3b 05             	cmpl   $0x5,(%ebx)
     9c1:	77 1b                	ja     9de <nulterminate+0x2e>
     9c3:	8b 03                	mov    (%ebx),%eax
     9c5:	ff 24 85 a4 12 00 00 	jmp    *0x12a4(,%eax,4)
     9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     9d0:	83 ec 0c             	sub    $0xc,%esp
     9d3:	ff 73 04             	pushl  0x4(%ebx)
     9d6:	e8 d5 ff ff ff       	call   9b0 <nulterminate>
    break;
     9db:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     9de:	89 d8                	mov    %ebx,%eax
     9e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9e3:	c9                   	leave  
     9e4:	c3                   	ret    
     9e5:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     9e8:	83 ec 0c             	sub    $0xc,%esp
     9eb:	ff 73 04             	pushl  0x4(%ebx)
     9ee:	e8 bd ff ff ff       	call   9b0 <nulterminate>
    nulterminate(lcmd->right);
     9f3:	58                   	pop    %eax
     9f4:	ff 73 08             	pushl  0x8(%ebx)
     9f7:	e8 b4 ff ff ff       	call   9b0 <nulterminate>
}
     9fc:	89 d8                	mov    %ebx,%eax
    break;
     9fe:	83 c4 10             	add    $0x10,%esp
}
     a01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a04:	c9                   	leave  
     a05:	c3                   	ret    
     a06:	8d 76 00             	lea    0x0(%esi),%esi
     a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     a10:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a13:	8d 43 08             	lea    0x8(%ebx),%eax
     a16:	85 c9                	test   %ecx,%ecx
     a18:	74 c4                	je     9de <nulterminate+0x2e>
     a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a20:	8b 50 24             	mov    0x24(%eax),%edx
     a23:	83 c0 04             	add    $0x4,%eax
     a26:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a29:	8b 50 fc             	mov    -0x4(%eax),%edx
     a2c:	85 d2                	test   %edx,%edx
     a2e:	75 f0                	jne    a20 <nulterminate+0x70>
}
     a30:	89 d8                	mov    %ebx,%eax
     a32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a35:	c9                   	leave  
     a36:	c3                   	ret    
     a37:	89 f6                	mov    %esi,%esi
     a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     a40:	83 ec 0c             	sub    $0xc,%esp
     a43:	ff 73 04             	pushl  0x4(%ebx)
     a46:	e8 65 ff ff ff       	call   9b0 <nulterminate>
    *rcmd->efile = 0;
     a4b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a4e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a51:	c6 00 00             	movb   $0x0,(%eax)
}
     a54:	89 d8                	mov    %ebx,%eax
     a56:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a59:	c9                   	leave  
     a5a:	c3                   	ret    
     a5b:	90                   	nop
     a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a60 <parsecmd>:
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	56                   	push   %esi
     a64:	53                   	push   %ebx
  es = s + strlen(s);
     a65:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a68:	83 ec 0c             	sub    $0xc,%esp
     a6b:	53                   	push   %ebx
     a6c:	e8 df 00 00 00       	call   b50 <strlen>
  cmd = parseline(&s, es);
     a71:	59                   	pop    %ecx
  es = s + strlen(s);
     a72:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a74:	8d 45 08             	lea    0x8(%ebp),%eax
     a77:	5e                   	pop    %esi
     a78:	53                   	push   %ebx
     a79:	50                   	push   %eax
     a7a:	e8 01 fe ff ff       	call   880 <parseline>
     a7f:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a81:	8d 45 08             	lea    0x8(%ebp),%eax
     a84:	83 c4 0c             	add    $0xc,%esp
     a87:	68 74 12 00 00       	push   $0x1274
     a8c:	53                   	push   %ebx
     a8d:	50                   	push   %eax
     a8e:	e8 4d fb ff ff       	call   5e0 <peek>
  if(s != es){
     a93:	8b 45 08             	mov    0x8(%ebp),%eax
     a96:	83 c4 10             	add    $0x10,%esp
     a99:	39 d8                	cmp    %ebx,%eax
     a9b:	75 12                	jne    aaf <parsecmd+0x4f>
  nulterminate(cmd);
     a9d:	83 ec 0c             	sub    $0xc,%esp
     aa0:	56                   	push   %esi
     aa1:	e8 0a ff ff ff       	call   9b0 <nulterminate>
}
     aa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     aa9:	89 f0                	mov    %esi,%eax
     aab:	5b                   	pop    %ebx
     aac:	5e                   	pop    %esi
     aad:	5d                   	pop    %ebp
     aae:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     aaf:	52                   	push   %edx
     ab0:	50                   	push   %eax
     ab1:	68 5a 12 00 00       	push   $0x125a
     ab6:	6a 02                	push   $0x2
     ab8:	e8 b3 03 00 00       	call   e70 <printf>
    panic("syntax");
     abd:	c7 04 24 1e 12 00 00 	movl   $0x121e,(%esp)
     ac4:	e8 97 f6 ff ff       	call   160 <panic>
     ac9:	66 90                	xchg   %ax,%ax
     acb:	66 90                	xchg   %ax,%ax
     acd:	66 90                	xchg   %ax,%ax
     acf:	90                   	nop

00000ad0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	53                   	push   %ebx
     ad4:	8b 45 08             	mov    0x8(%ebp),%eax
     ad7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     ada:	89 c2                	mov    %eax,%edx
     adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ae0:	83 c1 01             	add    $0x1,%ecx
     ae3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ae7:	83 c2 01             	add    $0x1,%edx
     aea:	84 db                	test   %bl,%bl
     aec:	88 5a ff             	mov    %bl,-0x1(%edx)
     aef:	75 ef                	jne    ae0 <strcpy+0x10>
    ;
  return os;
}
     af1:	5b                   	pop    %ebx
     af2:	5d                   	pop    %ebp
     af3:	c3                   	ret    
     af4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     afa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	53                   	push   %ebx
     b04:	8b 55 08             	mov    0x8(%ebp),%edx
     b07:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b0a:	0f b6 02             	movzbl (%edx),%eax
     b0d:	0f b6 19             	movzbl (%ecx),%ebx
     b10:	84 c0                	test   %al,%al
     b12:	75 1c                	jne    b30 <strcmp+0x30>
     b14:	eb 2a                	jmp    b40 <strcmp+0x40>
     b16:	8d 76 00             	lea    0x0(%esi),%esi
     b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b20:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b23:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b26:	83 c1 01             	add    $0x1,%ecx
     b29:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     b2c:	84 c0                	test   %al,%al
     b2e:	74 10                	je     b40 <strcmp+0x40>
     b30:	38 d8                	cmp    %bl,%al
     b32:	74 ec                	je     b20 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b34:	29 d8                	sub    %ebx,%eax
}
     b36:	5b                   	pop    %ebx
     b37:	5d                   	pop    %ebp
     b38:	c3                   	ret    
     b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b40:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b42:	29 d8                	sub    %ebx,%eax
}
     b44:	5b                   	pop    %ebx
     b45:	5d                   	pop    %ebp
     b46:	c3                   	ret    
     b47:	89 f6                	mov    %esi,%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b50 <strlen>:

uint
strlen(const char *s)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b56:	80 39 00             	cmpb   $0x0,(%ecx)
     b59:	74 15                	je     b70 <strlen+0x20>
     b5b:	31 d2                	xor    %edx,%edx
     b5d:	8d 76 00             	lea    0x0(%esi),%esi
     b60:	83 c2 01             	add    $0x1,%edx
     b63:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b67:	89 d0                	mov    %edx,%eax
     b69:	75 f5                	jne    b60 <strlen+0x10>
    ;
  return n;
}
     b6b:	5d                   	pop    %ebp
     b6c:	c3                   	ret    
     b6d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     b70:	31 c0                	xor    %eax,%eax
}
     b72:	5d                   	pop    %ebp
     b73:	c3                   	ret    
     b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b80 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	57                   	push   %edi
     b84:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b87:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b8a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b8d:	89 d7                	mov    %edx,%edi
     b8f:	fc                   	cld    
     b90:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b92:	89 d0                	mov    %edx,%eax
     b94:	5f                   	pop    %edi
     b95:	5d                   	pop    %ebp
     b96:	c3                   	ret    
     b97:	89 f6                	mov    %esi,%esi
     b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ba0 <strchr>:

char*
strchr(const char *s, char c)
{
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	53                   	push   %ebx
     ba4:	8b 45 08             	mov    0x8(%ebp),%eax
     ba7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     baa:	0f b6 10             	movzbl (%eax),%edx
     bad:	84 d2                	test   %dl,%dl
     baf:	74 1d                	je     bce <strchr+0x2e>
    if(*s == c)
     bb1:	38 d3                	cmp    %dl,%bl
     bb3:	89 d9                	mov    %ebx,%ecx
     bb5:	75 0d                	jne    bc4 <strchr+0x24>
     bb7:	eb 17                	jmp    bd0 <strchr+0x30>
     bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bc0:	38 ca                	cmp    %cl,%dl
     bc2:	74 0c                	je     bd0 <strchr+0x30>
  for(; *s; s++)
     bc4:	83 c0 01             	add    $0x1,%eax
     bc7:	0f b6 10             	movzbl (%eax),%edx
     bca:	84 d2                	test   %dl,%dl
     bcc:	75 f2                	jne    bc0 <strchr+0x20>
      return (char*)s;
  return 0;
     bce:	31 c0                	xor    %eax,%eax
}
     bd0:	5b                   	pop    %ebx
     bd1:	5d                   	pop    %ebp
     bd2:	c3                   	ret    
     bd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000be0 <gets>:

char*
gets(char *buf, int max)
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	57                   	push   %edi
     be4:	56                   	push   %esi
     be5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     be6:	31 f6                	xor    %esi,%esi
     be8:	89 f3                	mov    %esi,%ebx
{
     bea:	83 ec 1c             	sub    $0x1c,%esp
     bed:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     bf0:	eb 2f                	jmp    c21 <gets+0x41>
     bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     bf8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     bfb:	83 ec 04             	sub    $0x4,%esp
     bfe:	6a 01                	push   $0x1
     c00:	50                   	push   %eax
     c01:	6a 00                	push   $0x0
     c03:	e8 32 01 00 00       	call   d3a <read>
    if(cc < 1)
     c08:	83 c4 10             	add    $0x10,%esp
     c0b:	85 c0                	test   %eax,%eax
     c0d:	7e 1c                	jle    c2b <gets+0x4b>
      break;
    buf[i++] = c;
     c0f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c13:	83 c7 01             	add    $0x1,%edi
     c16:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c19:	3c 0a                	cmp    $0xa,%al
     c1b:	74 23                	je     c40 <gets+0x60>
     c1d:	3c 0d                	cmp    $0xd,%al
     c1f:	74 1f                	je     c40 <gets+0x60>
  for(i=0; i+1 < max; ){
     c21:	83 c3 01             	add    $0x1,%ebx
     c24:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c27:	89 fe                	mov    %edi,%esi
     c29:	7c cd                	jl     bf8 <gets+0x18>
     c2b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c30:	c6 03 00             	movb   $0x0,(%ebx)
}
     c33:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c36:	5b                   	pop    %ebx
     c37:	5e                   	pop    %esi
     c38:	5f                   	pop    %edi
     c39:	5d                   	pop    %ebp
     c3a:	c3                   	ret    
     c3b:	90                   	nop
     c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c40:	8b 75 08             	mov    0x8(%ebp),%esi
     c43:	8b 45 08             	mov    0x8(%ebp),%eax
     c46:	01 de                	add    %ebx,%esi
     c48:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     c4a:	c6 03 00             	movb   $0x0,(%ebx)
}
     c4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c50:	5b                   	pop    %ebx
     c51:	5e                   	pop    %esi
     c52:	5f                   	pop    %edi
     c53:	5d                   	pop    %ebp
     c54:	c3                   	ret    
     c55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c60 <stat>:

int
stat(const char *n, struct stat *st)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	56                   	push   %esi
     c64:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c65:	83 ec 08             	sub    $0x8,%esp
     c68:	6a 00                	push   $0x0
     c6a:	ff 75 08             	pushl  0x8(%ebp)
     c6d:	e8 f0 00 00 00       	call   d62 <open>
  if(fd < 0)
     c72:	83 c4 10             	add    $0x10,%esp
     c75:	85 c0                	test   %eax,%eax
     c77:	78 27                	js     ca0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c79:	83 ec 08             	sub    $0x8,%esp
     c7c:	ff 75 0c             	pushl  0xc(%ebp)
     c7f:	89 c3                	mov    %eax,%ebx
     c81:	50                   	push   %eax
     c82:	e8 f3 00 00 00       	call   d7a <fstat>
  close(fd);
     c87:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c8a:	89 c6                	mov    %eax,%esi
  close(fd);
     c8c:	e8 b9 00 00 00       	call   d4a <close>
  return r;
     c91:	83 c4 10             	add    $0x10,%esp
}
     c94:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c97:	89 f0                	mov    %esi,%eax
     c99:	5b                   	pop    %ebx
     c9a:	5e                   	pop    %esi
     c9b:	5d                   	pop    %ebp
     c9c:	c3                   	ret    
     c9d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     ca0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     ca5:	eb ed                	jmp    c94 <stat+0x34>
     ca7:	89 f6                	mov    %esi,%esi
     ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cb0 <atoi>:

int
atoi(const char *s)
{
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	53                   	push   %ebx
     cb4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cb7:	0f be 11             	movsbl (%ecx),%edx
     cba:	8d 42 d0             	lea    -0x30(%edx),%eax
     cbd:	3c 09                	cmp    $0x9,%al
  n = 0;
     cbf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     cc4:	77 1f                	ja     ce5 <atoi+0x35>
     cc6:	8d 76 00             	lea    0x0(%esi),%esi
     cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     cd0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     cd3:	83 c1 01             	add    $0x1,%ecx
     cd6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     cda:	0f be 11             	movsbl (%ecx),%edx
     cdd:	8d 5a d0             	lea    -0x30(%edx),%ebx
     ce0:	80 fb 09             	cmp    $0x9,%bl
     ce3:	76 eb                	jbe    cd0 <atoi+0x20>
  return n;
}
     ce5:	5b                   	pop    %ebx
     ce6:	5d                   	pop    %ebp
     ce7:	c3                   	ret    
     ce8:	90                   	nop
     ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000cf0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	56                   	push   %esi
     cf4:	53                   	push   %ebx
     cf5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     cf8:	8b 45 08             	mov    0x8(%ebp),%eax
     cfb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cfe:	85 db                	test   %ebx,%ebx
     d00:	7e 14                	jle    d16 <memmove+0x26>
     d02:	31 d2                	xor    %edx,%edx
     d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     d08:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     d0c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     d0f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d12:	39 d3                	cmp    %edx,%ebx
     d14:	75 f2                	jne    d08 <memmove+0x18>
  return vdst;
}
     d16:	5b                   	pop    %ebx
     d17:	5e                   	pop    %esi
     d18:	5d                   	pop    %ebp
     d19:	c3                   	ret    

00000d1a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d1a:	b8 01 00 00 00       	mov    $0x1,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <exit>:
SYSCALL(exit)
     d22:	b8 02 00 00 00       	mov    $0x2,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    

00000d2a <wait>:
SYSCALL(wait)
     d2a:	b8 03 00 00 00       	mov    $0x3,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <pipe>:
SYSCALL(pipe)
     d32:	b8 04 00 00 00       	mov    $0x4,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <read>:
SYSCALL(read)
     d3a:	b8 05 00 00 00       	mov    $0x5,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <write>:
SYSCALL(write)
     d42:	b8 10 00 00 00       	mov    $0x10,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <close>:
SYSCALL(close)
     d4a:	b8 15 00 00 00       	mov    $0x15,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <kill>:
SYSCALL(kill)
     d52:	b8 06 00 00 00       	mov    $0x6,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <exec>:
SYSCALL(exec)
     d5a:	b8 07 00 00 00       	mov    $0x7,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <open>:
SYSCALL(open)
     d62:	b8 0f 00 00 00       	mov    $0xf,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <mknod>:
SYSCALL(mknod)
     d6a:	b8 11 00 00 00       	mov    $0x11,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <unlink>:
SYSCALL(unlink)
     d72:	b8 12 00 00 00       	mov    $0x12,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <fstat>:
SYSCALL(fstat)
     d7a:	b8 08 00 00 00       	mov    $0x8,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <link>:
SYSCALL(link)
     d82:	b8 13 00 00 00       	mov    $0x13,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <mkdir>:
SYSCALL(mkdir)
     d8a:	b8 14 00 00 00       	mov    $0x14,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <chdir>:
SYSCALL(chdir)
     d92:	b8 09 00 00 00       	mov    $0x9,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <dup>:
SYSCALL(dup)
     d9a:	b8 0a 00 00 00       	mov    $0xa,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <getpid>:
SYSCALL(getpid)
     da2:	b8 0b 00 00 00       	mov    $0xb,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <sbrk>:
SYSCALL(sbrk)
     daa:	b8 0c 00 00 00       	mov    $0xc,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <sleep>:
SYSCALL(sleep)
     db2:	b8 0d 00 00 00       	mov    $0xd,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <uptime>:
SYSCALL(uptime)
     dba:	b8 0e 00 00 00       	mov    $0xe,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    
     dc2:	66 90                	xchg   %ax,%ax
     dc4:	66 90                	xchg   %ax,%ax
     dc6:	66 90                	xchg   %ax,%ax
     dc8:	66 90                	xchg   %ax,%ax
     dca:	66 90                	xchg   %ax,%ax
     dcc:	66 90                	xchg   %ax,%ax
     dce:	66 90                	xchg   %ax,%ax

00000dd0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	57                   	push   %edi
     dd4:	56                   	push   %esi
     dd5:	53                   	push   %ebx
     dd6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     dd9:	85 d2                	test   %edx,%edx
{
     ddb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     dde:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     de0:	79 76                	jns    e58 <printint+0x88>
     de2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     de6:	74 70                	je     e58 <printint+0x88>
    x = -xx;
     de8:	f7 d8                	neg    %eax
    neg = 1;
     dea:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     df1:	31 f6                	xor    %esi,%esi
     df3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     df6:	eb 0a                	jmp    e02 <printint+0x32>
     df8:	90                   	nop
     df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     e00:	89 fe                	mov    %edi,%esi
     e02:	31 d2                	xor    %edx,%edx
     e04:	8d 7e 01             	lea    0x1(%esi),%edi
     e07:	f7 f1                	div    %ecx
     e09:	0f b6 92 c4 12 00 00 	movzbl 0x12c4(%edx),%edx
  }while((x /= base) != 0);
     e10:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     e12:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     e15:	75 e9                	jne    e00 <printint+0x30>
  if(neg)
     e17:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e1a:	85 c0                	test   %eax,%eax
     e1c:	74 08                	je     e26 <printint+0x56>
    buf[i++] = '-';
     e1e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     e23:	8d 7e 02             	lea    0x2(%esi),%edi
     e26:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     e2a:	8b 7d c0             	mov    -0x40(%ebp),%edi
     e2d:	8d 76 00             	lea    0x0(%esi),%esi
     e30:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     e33:	83 ec 04             	sub    $0x4,%esp
     e36:	83 ee 01             	sub    $0x1,%esi
     e39:	6a 01                	push   $0x1
     e3b:	53                   	push   %ebx
     e3c:	57                   	push   %edi
     e3d:	88 45 d7             	mov    %al,-0x29(%ebp)
     e40:	e8 fd fe ff ff       	call   d42 <write>

  while(--i >= 0)
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	39 de                	cmp    %ebx,%esi
     e4a:	75 e4                	jne    e30 <printint+0x60>
    putc(fd, buf[i]);
}
     e4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e4f:	5b                   	pop    %ebx
     e50:	5e                   	pop    %esi
     e51:	5f                   	pop    %edi
     e52:	5d                   	pop    %ebp
     e53:	c3                   	ret    
     e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     e58:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e5f:	eb 90                	jmp    df1 <printint+0x21>
     e61:	eb 0d                	jmp    e70 <printf>
     e63:	90                   	nop
     e64:	90                   	nop
     e65:	90                   	nop
     e66:	90                   	nop
     e67:	90                   	nop
     e68:	90                   	nop
     e69:	90                   	nop
     e6a:	90                   	nop
     e6b:	90                   	nop
     e6c:	90                   	nop
     e6d:	90                   	nop
     e6e:	90                   	nop
     e6f:	90                   	nop

00000e70 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
     e74:	56                   	push   %esi
     e75:	53                   	push   %ebx
     e76:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e79:	8b 75 0c             	mov    0xc(%ebp),%esi
     e7c:	0f b6 1e             	movzbl (%esi),%ebx
     e7f:	84 db                	test   %bl,%bl
     e81:	0f 84 b3 00 00 00    	je     f3a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     e87:	8d 45 10             	lea    0x10(%ebp),%eax
     e8a:	83 c6 01             	add    $0x1,%esi
  state = 0;
     e8d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     e8f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e92:	eb 2f                	jmp    ec3 <printf+0x53>
     e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e98:	83 f8 25             	cmp    $0x25,%eax
     e9b:	0f 84 a7 00 00 00    	je     f48 <printf+0xd8>
  write(fd, &c, 1);
     ea1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     ea4:	83 ec 04             	sub    $0x4,%esp
     ea7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     eaa:	6a 01                	push   $0x1
     eac:	50                   	push   %eax
     ead:	ff 75 08             	pushl  0x8(%ebp)
     eb0:	e8 8d fe ff ff       	call   d42 <write>
     eb5:	83 c4 10             	add    $0x10,%esp
     eb8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     ebb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     ebf:	84 db                	test   %bl,%bl
     ec1:	74 77                	je     f3a <printf+0xca>
    if(state == 0){
     ec3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     ec5:	0f be cb             	movsbl %bl,%ecx
     ec8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     ecb:	74 cb                	je     e98 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     ecd:	83 ff 25             	cmp    $0x25,%edi
     ed0:	75 e6                	jne    eb8 <printf+0x48>
      if(c == 'd'){
     ed2:	83 f8 64             	cmp    $0x64,%eax
     ed5:	0f 84 05 01 00 00    	je     fe0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     edb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     ee1:	83 f9 70             	cmp    $0x70,%ecx
     ee4:	74 72                	je     f58 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     ee6:	83 f8 73             	cmp    $0x73,%eax
     ee9:	0f 84 99 00 00 00    	je     f88 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     eef:	83 f8 63             	cmp    $0x63,%eax
     ef2:	0f 84 08 01 00 00    	je     1000 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     ef8:	83 f8 25             	cmp    $0x25,%eax
     efb:	0f 84 ef 00 00 00    	je     ff0 <printf+0x180>
  write(fd, &c, 1);
     f01:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f04:	83 ec 04             	sub    $0x4,%esp
     f07:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f0b:	6a 01                	push   $0x1
     f0d:	50                   	push   %eax
     f0e:	ff 75 08             	pushl  0x8(%ebp)
     f11:	e8 2c fe ff ff       	call   d42 <write>
     f16:	83 c4 0c             	add    $0xc,%esp
     f19:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f1c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f1f:	6a 01                	push   $0x1
     f21:	50                   	push   %eax
     f22:	ff 75 08             	pushl  0x8(%ebp)
     f25:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f28:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     f2a:	e8 13 fe ff ff       	call   d42 <write>
  for(i = 0; fmt[i]; i++){
     f2f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     f33:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     f36:	84 db                	test   %bl,%bl
     f38:	75 89                	jne    ec3 <printf+0x53>
    }
  }
}
     f3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f3d:	5b                   	pop    %ebx
     f3e:	5e                   	pop    %esi
     f3f:	5f                   	pop    %edi
     f40:	5d                   	pop    %ebp
     f41:	c3                   	ret    
     f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     f48:	bf 25 00 00 00       	mov    $0x25,%edi
     f4d:	e9 66 ff ff ff       	jmp    eb8 <printf+0x48>
     f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     f58:	83 ec 0c             	sub    $0xc,%esp
     f5b:	b9 10 00 00 00       	mov    $0x10,%ecx
     f60:	6a 00                	push   $0x0
     f62:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     f65:	8b 45 08             	mov    0x8(%ebp),%eax
     f68:	8b 17                	mov    (%edi),%edx
     f6a:	e8 61 fe ff ff       	call   dd0 <printint>
        ap++;
     f6f:	89 f8                	mov    %edi,%eax
     f71:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f74:	31 ff                	xor    %edi,%edi
        ap++;
     f76:	83 c0 04             	add    $0x4,%eax
     f79:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f7c:	e9 37 ff ff ff       	jmp    eb8 <printf+0x48>
     f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     f88:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f8b:	8b 08                	mov    (%eax),%ecx
        ap++;
     f8d:	83 c0 04             	add    $0x4,%eax
     f90:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
     f93:	85 c9                	test   %ecx,%ecx
     f95:	0f 84 8e 00 00 00    	je     1029 <printf+0x1b9>
        while(*s != 0){
     f9b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
     f9e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
     fa0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
     fa2:	84 c0                	test   %al,%al
     fa4:	0f 84 0e ff ff ff    	je     eb8 <printf+0x48>
     faa:	89 75 d0             	mov    %esi,-0x30(%ebp)
     fad:	89 de                	mov    %ebx,%esi
     faf:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fb2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
     fb5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     fb8:	83 ec 04             	sub    $0x4,%esp
          s++;
     fbb:	83 c6 01             	add    $0x1,%esi
     fbe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     fc1:	6a 01                	push   $0x1
     fc3:	57                   	push   %edi
     fc4:	53                   	push   %ebx
     fc5:	e8 78 fd ff ff       	call   d42 <write>
        while(*s != 0){
     fca:	0f b6 06             	movzbl (%esi),%eax
     fcd:	83 c4 10             	add    $0x10,%esp
     fd0:	84 c0                	test   %al,%al
     fd2:	75 e4                	jne    fb8 <printf+0x148>
     fd4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
     fd7:	31 ff                	xor    %edi,%edi
     fd9:	e9 da fe ff ff       	jmp    eb8 <printf+0x48>
     fde:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
     fe0:	83 ec 0c             	sub    $0xc,%esp
     fe3:	b9 0a 00 00 00       	mov    $0xa,%ecx
     fe8:	6a 01                	push   $0x1
     fea:	e9 73 ff ff ff       	jmp    f62 <printf+0xf2>
     fef:	90                   	nop
  write(fd, &c, 1);
     ff0:	83 ec 04             	sub    $0x4,%esp
     ff3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     ff6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     ff9:	6a 01                	push   $0x1
     ffb:	e9 21 ff ff ff       	jmp    f21 <printf+0xb1>
        putc(fd, *ap);
    1000:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1003:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1006:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1008:	6a 01                	push   $0x1
        ap++;
    100a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    100d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1010:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1013:	50                   	push   %eax
    1014:	ff 75 08             	pushl  0x8(%ebp)
    1017:	e8 26 fd ff ff       	call   d42 <write>
        ap++;
    101c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    101f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1022:	31 ff                	xor    %edi,%edi
    1024:	e9 8f fe ff ff       	jmp    eb8 <printf+0x48>
          s = "(null)";
    1029:	bb bc 12 00 00       	mov    $0x12bc,%ebx
        while(*s != 0){
    102e:	b8 28 00 00 00       	mov    $0x28,%eax
    1033:	e9 72 ff ff ff       	jmp    faa <printf+0x13a>
    1038:	66 90                	xchg   %ax,%ax
    103a:	66 90                	xchg   %ax,%ax
    103c:	66 90                	xchg   %ax,%ax
    103e:	66 90                	xchg   %ax,%ax

00001040 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1040:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1041:	a1 04 19 00 00       	mov    0x1904,%eax
{
    1046:	89 e5                	mov    %esp,%ebp
    1048:	57                   	push   %edi
    1049:	56                   	push   %esi
    104a:	53                   	push   %ebx
    104b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    104e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1051:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1058:	39 c8                	cmp    %ecx,%eax
    105a:	8b 10                	mov    (%eax),%edx
    105c:	73 32                	jae    1090 <free+0x50>
    105e:	39 d1                	cmp    %edx,%ecx
    1060:	72 04                	jb     1066 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1062:	39 d0                	cmp    %edx,%eax
    1064:	72 32                	jb     1098 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1066:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1069:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    106c:	39 fa                	cmp    %edi,%edx
    106e:	74 30                	je     10a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1070:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1073:	8b 50 04             	mov    0x4(%eax),%edx
    1076:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1079:	39 f1                	cmp    %esi,%ecx
    107b:	74 3a                	je     10b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    107d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    107f:	a3 04 19 00 00       	mov    %eax,0x1904
}
    1084:	5b                   	pop    %ebx
    1085:	5e                   	pop    %esi
    1086:	5f                   	pop    %edi
    1087:	5d                   	pop    %ebp
    1088:	c3                   	ret    
    1089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1090:	39 d0                	cmp    %edx,%eax
    1092:	72 04                	jb     1098 <free+0x58>
    1094:	39 d1                	cmp    %edx,%ecx
    1096:	72 ce                	jb     1066 <free+0x26>
{
    1098:	89 d0                	mov    %edx,%eax
    109a:	eb bc                	jmp    1058 <free+0x18>
    109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    10a0:	03 72 04             	add    0x4(%edx),%esi
    10a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    10a6:	8b 10                	mov    (%eax),%edx
    10a8:	8b 12                	mov    (%edx),%edx
    10aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10ad:	8b 50 04             	mov    0x4(%eax),%edx
    10b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10b3:	39 f1                	cmp    %esi,%ecx
    10b5:	75 c6                	jne    107d <free+0x3d>
    p->s.size += bp->s.size;
    10b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    10ba:	a3 04 19 00 00       	mov    %eax,0x1904
    p->s.size += bp->s.size;
    10bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10c5:	89 10                	mov    %edx,(%eax)
}
    10c7:	5b                   	pop    %ebx
    10c8:	5e                   	pop    %esi
    10c9:	5f                   	pop    %edi
    10ca:	5d                   	pop    %ebp
    10cb:	c3                   	ret    
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	57                   	push   %edi
    10d4:	56                   	push   %esi
    10d5:	53                   	push   %ebx
    10d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    10dc:	8b 15 04 19 00 00    	mov    0x1904,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10e2:	8d 78 07             	lea    0x7(%eax),%edi
    10e5:	c1 ef 03             	shr    $0x3,%edi
    10e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    10eb:	85 d2                	test   %edx,%edx
    10ed:	0f 84 9d 00 00 00    	je     1190 <malloc+0xc0>
    10f3:	8b 02                	mov    (%edx),%eax
    10f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    10f8:	39 cf                	cmp    %ecx,%edi
    10fa:	76 6c                	jbe    1168 <malloc+0x98>
    10fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1102:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1107:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    110a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1111:	eb 0e                	jmp    1121 <malloc+0x51>
    1113:	90                   	nop
    1114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1118:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    111a:	8b 48 04             	mov    0x4(%eax),%ecx
    111d:	39 f9                	cmp    %edi,%ecx
    111f:	73 47                	jae    1168 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1121:	39 05 04 19 00 00    	cmp    %eax,0x1904
    1127:	89 c2                	mov    %eax,%edx
    1129:	75 ed                	jne    1118 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    112b:	83 ec 0c             	sub    $0xc,%esp
    112e:	56                   	push   %esi
    112f:	e8 76 fc ff ff       	call   daa <sbrk>
  if(p == (char*)-1)
    1134:	83 c4 10             	add    $0x10,%esp
    1137:	83 f8 ff             	cmp    $0xffffffff,%eax
    113a:	74 1c                	je     1158 <malloc+0x88>
  hp->s.size = nu;
    113c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    113f:	83 ec 0c             	sub    $0xc,%esp
    1142:	83 c0 08             	add    $0x8,%eax
    1145:	50                   	push   %eax
    1146:	e8 f5 fe ff ff       	call   1040 <free>
  return freep;
    114b:	8b 15 04 19 00 00    	mov    0x1904,%edx
      if((p = morecore(nunits)) == 0)
    1151:	83 c4 10             	add    $0x10,%esp
    1154:	85 d2                	test   %edx,%edx
    1156:	75 c0                	jne    1118 <malloc+0x48>
        return 0;
  }
}
    1158:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    115b:	31 c0                	xor    %eax,%eax
}
    115d:	5b                   	pop    %ebx
    115e:	5e                   	pop    %esi
    115f:	5f                   	pop    %edi
    1160:	5d                   	pop    %ebp
    1161:	c3                   	ret    
    1162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1168:	39 cf                	cmp    %ecx,%edi
    116a:	74 54                	je     11c0 <malloc+0xf0>
        p->s.size -= nunits;
    116c:	29 f9                	sub    %edi,%ecx
    116e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1171:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1174:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1177:	89 15 04 19 00 00    	mov    %edx,0x1904
}
    117d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1180:	83 c0 08             	add    $0x8,%eax
}
    1183:	5b                   	pop    %ebx
    1184:	5e                   	pop    %esi
    1185:	5f                   	pop    %edi
    1186:	5d                   	pop    %ebp
    1187:	c3                   	ret    
    1188:	90                   	nop
    1189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1190:	c7 05 04 19 00 00 08 	movl   $0x1908,0x1904
    1197:	19 00 00 
    119a:	c7 05 08 19 00 00 08 	movl   $0x1908,0x1908
    11a1:	19 00 00 
    base.s.size = 0;
    11a4:	b8 08 19 00 00       	mov    $0x1908,%eax
    11a9:	c7 05 0c 19 00 00 00 	movl   $0x0,0x190c
    11b0:	00 00 00 
    11b3:	e9 44 ff ff ff       	jmp    10fc <malloc+0x2c>
    11b8:	90                   	nop
    11b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    11c0:	8b 08                	mov    (%eax),%ecx
    11c2:	89 0a                	mov    %ecx,(%edx)
    11c4:	eb b1                	jmp    1177 <malloc+0xa7>
