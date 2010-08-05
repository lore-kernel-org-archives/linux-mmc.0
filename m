From: Youngjin Na <linuxppc.yjna@gmail.com>
Subject: kernel panic on MPC8323 custom board
Date: Thu, 5 Aug 2010 11:57:11 +0900
Message-ID: <AANLkTikxEqfk0RnuBtpH9n2b58pPtCAWoJbyji0M7Xwu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6355927879044620287=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

--===============6355927879044620287==
Content-Type: multipart/alternative; boundary=000e0cd34846e8d0fb048d0ab486

--000e0cd34846e8d0fb048d0ab486
Content-Type: text/plain; charset=ISO-8859-1

Hi.. all

I'm porting the linux 2.6.27 kernel to the custom board with Freescale8270.
The base is the pq2fads board. The board is noproblem with linux-2.6.17.1
and linux-2.6.25.

When booting this machine, a crash takes place such as :



---------------------------------------------------------------------

Using FCC1 ETHERNET device
TFTP from server 192.168.0.12; our IP address is 192.168.0.161
Filename 'cuImage.pq2fads'.
Load address: 0x100000
Loading: #########################################################
done
Bytes transferred = 822097 (c8b51 hex)
[codec]$ bootm 100000
## Booting kernel from Legacy Image at 00100000 ...
   Image Name:   Linux-2.6.27
   Created:      2010-08-05   1:35:22 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    822033 Bytes = 802.8 kB
   Load Address: 00400000
   Entry Point:  00400ba0
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using board info...
Memory <- <0x0 0x10000000> (256MB)
CPU clock-frequency <- 0x1ad27480 (450MHz)
CPU timebase-frequency <- 0x17d7840 (25MHz)
CPU bus-frequency <- 0x5f5e100 (100MHz)

zImage starting: loaded at 0x00400000 (sp: 0x0ff65ac8)
Allocating 0x1e4924 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x005da9f0)...done 0x1b3224 bytes

Linux/PowerPC load: root=/dev/nfs rw
nfsroot=192.168.0.12:/project/target/target_nadatel
ip=192.168.0.161:192.168.0.12:192.168.0.1::h264codec:eth0:off
Finalizing device tree... flat tree at 0x40c038
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
[    0.000000] Using Freescale PQ2FADS machine description
[    0.000000] Linux version 2.6.27 (vyna@aLinux) (gcc version 3.3.1
(MontaVista 3.3.1-3.0.10.0300532 2003-12-24)) #55 Thu Aug 5 10:35:18 KST
2010
[    0.000000] console [udbg0] enabled
setup_arch: bootmem
pq2fads_setup_arch()
pq2fads_setup_arch(), finish
arch: exit
[    0.000000] Top of RAM: 0x10000000, Total RAM: 0x10000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00010000
[    0.000000]   Normal   0x00010000 -> 0x00010000
[    0.000000]   HighMem  0x00010000 -> 0x00010000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00010000
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c01adb3c, node_mem_map
c01e7000
[    0.000000]   DMA zone: 65024 pages, LIFO batch:15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 65024
[    0.000000] Kernel command line: root=/dev/nfs rw
nfsroot=192.168.0.12:/project/target/target_nadatel
ip=192.168.0.161:192.168.0.12:192.168.0.1::h264codec:eth0:off
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] time_init: decrementer frequency = 25.000000 MHz
[    0.000000] time_init: processor frequency   = 450.000000 MHz
[    0.000000] clocksource: timebase mult[a000000] shift[22] registered
[    0.038127] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.060153] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.134314] High memory: 0k
[    0.141880] Memory: 257792k/262144k available (1648k kernel code, 4204k
reserved, 76k data, 194k bss, 124k init)
[    0.172857] Calibrating delay loop... 49.79 BogoMIPS (lpj=24896)
[    0.207709] Mount-cache hash table entries: 512
[    0.234059] Unable to handle kernel paging request for data at address
0x00000032
[    0.255641] Faulting instruction address: 0xc0183c50
[    0.270489] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.286545] Freescale PQ2FADS
[    0.295392] Modules linked in:
[    0.304504] NIP: c0183c50 LR: c0183ef4 CTR: 00000000
[    0.319345] REGS: cf821db0 TRAP: 0300   Not tainted  (2.6.27)
[    0.336514] MSR: 00009032 <EE,ME,IR,DR>  CR: 82004024  XER: 00000000
[    0.355515] DAR: 00000032, DSISR: 20000000
[    0.367750] TASK = cf81f8a0[1] 'swapper' THREAD: cf820000
[    0.383362] GPR00: c0183ef4 cf821e60 cf81f8a0 00000000 c015e5e0 cf821ec0
00000024 0000013f
[    0.408348] GPR08: 3860ffda c01a0000 00000002 8124000c 24004024 ffffffff
0fffe000 11fc6000
[    0.433334] GPR16: fffffffb fcfdffff fffffeff ffffffff 00000000 0fff8c94
00000002 0ff65e80
[    0.458319] GPR24: 00000000 00000000 00000000 c01b0000 cf821ec0 c01b0000
c01b0000 cf821eb8
[    0.483863] NIP [c0183c50] find_section32+0x14/0xb8
[    0.498409] LR [c0183ef4] vdso_do_find_sections+0x28/0xc8
[    0.514537] Call Trace:
[    0.521839] [cf821e60] [c00f5ce8] kobject_uevent_env+0x2f4/0x318
(unreliable)
[    0.543176] [cf821e90] [c0183ef4] vdso_do_find_sections+0x28/0xc8
[    0.561394] [cf821eb0] [c01841b4] vdso_setup+0x2c/0xb8
[    0.576749] [cf821f10] [c0184308] vdso_init+0x64/0x1dc
[    0.592113] [cf821f30] [c0003904] do_one_initcall+0x54/0x184
[    0.609022] [cf821fb0] [c017d848] do_initcalls+0x34/0x58
[    0.624897] [cf821fd0] [c017d92c] kernel_init+0x40/0x94
[    0.640528] [cf821ff0] [c000f9f8] kernel_thread+0x44/0x60
[    0.656643] Instruction dump:
[    0.665493] 41a2000c 7c0803a6 4e800021 80010014 38210010 7c0803a6
4e800020 9421ffd0
[    0.688656] 7c0802a6 bf010010 90010034 7cbc2b78 <a1230032> 3b400001
7c7f1b78 81630020
[    0.712438] ---[ end trace 31fd0ba7d8756001 ]---
[    0.726196] Kernel panic - not syncing: Attempted to kill init!
[    0.743876] Rebooting in 180 seconds..
-------------------------------


I don't know what is could someone help me?

Thanks
Best Regards


Victor

--000e0cd34846e8d0fb048d0ab486
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br></div><div><br></div><div>Hi.. all</div><div><br></=
div><div>I&#39;m porting the linux 2.6.27 kernel to the custom board with F=
reescale8270.</div><div>The base is the pq2fads board. The board is noprobl=
em with linux-2.6.17.1 and linux-2.6.25.</div>
<div><br></div><div>When booting this machine, a crash takes place such as =
:</div><div><br></div><div><br></div><div><br></div><div>------------------=
---------------------------------------------------</div><div><br></div>
<div>Using FCC1 ETHERNET device</div><div>TFTP from server 192.168.0.12; ou=
r IP address is 192.168.0.161</div><div>Filename &#39;cuImage.pq2fads&#39;.=
</div><div>Load address: 0x100000</div><div>Loading: ######################=
###################################</div>
<div>done</div><div>Bytes transferred =3D 822097 (c8b51 hex)</div><div>[cod=
ec]$ bootm 100000</div><div>## Booting kernel from Legacy Image at 00100000=
 ...</div><div>=A0=A0 Image Name: =A0 Linux-2.6.27</div><div>=A0=A0 Created=
: =A0 =A0 =A02010-08-05 =A0 1:35:22 UTC</div>
<div>=A0=A0 Image Type: =A0 PowerPC Linux Kernel Image (gzip compressed)</d=
iv><div>=A0=A0 Data Size: =A0 =A0822033 Bytes =3D 802.8 kB</div><div>=A0=A0=
 Load Address: 00400000</div><div>=A0=A0 Entry Point: =A000400ba0</div><div=
>=A0=A0 Verifying Checksum ... OK</div>
<div>=A0=A0 Uncompressing Kernel Image ... OK</div><div>=A0=A0 Booting usin=
g board info...</div><div>Memory &lt;- &lt;0x0 0x10000000&gt; (256MB)</div>=
<div>CPU clock-frequency &lt;- 0x1ad27480 (450MHz)</div><div>CPU timebase-f=
requency &lt;- 0x17d7840 (25MHz)</div>
<div>CPU bus-frequency &lt;- 0x5f5e100 (100MHz)</div><div><br></div><div>zI=
mage starting: loaded at 0x00400000 (sp: 0x0ff65ac8)</div><div>Allocating 0=
x1e4924 bytes for kernel ...</div><div>gunzipping (0x00000000 &lt;- 0x0040d=
000:0x005da9f0)...done 0x1b3224 bytes</div>
<div><br></div><div>Linux/PowerPC load: root=3D/dev/nfs rw nfsroot=3D192.16=
8.0.12:/project/target/target_nadatel ip=3D192.168.0.161:192.168.0.12:192.1=
68.0.1::h264codec:eth0:off</div><div>Finalizing device tree... flat tree at=
 0x40c038</div>
<div>id mach(): done</div><div>MMU:enter</div><div>MMU:hw init</div><div>MM=
U:mapin</div><div>MMU:setio</div><div>MMU:exit</div><div>[ =A0 =A00.000000]=
 Using Freescale PQ2FADS machine description</div><div>[ =A0 =A00.000000] L=
inux version 2.6.27 (vyna@aLinux) (gcc version 3.3.1 (MontaVista 3.3.1-3.0.=
10.0300532 2003-12-24)) #55 Thu Aug 5 10:35:18 KST 2010</div>
<div>[ =A0 =A00.000000] console [udbg0] enabled</div><div>setup_arch: bootm=
em</div><div>pq2fads_setup_arch()</div><div>pq2fads_setup_arch(), finish</d=
iv><div>arch: exit</div><div>[ =A0 =A00.000000] Top of RAM: 0x10000000, Tot=
al RAM: 0x10000000</div>
<div>[ =A0 =A00.000000] Memory hole size: 0MB</div><div>[ =A0 =A00.000000] =
Zone PFN ranges:</div><div>[ =A0 =A00.000000] =A0 DMA =A0 =A0 =A00x00000000=
 -&gt; 0x00010000</div><div>[ =A0 =A00.000000] =A0 Normal =A0 0x00010000 -&=
gt; 0x00010000</div><div>
[ =A0 =A00.000000] =A0 HighMem =A00x00010000 -&gt; 0x00010000</div><div>[ =
=A0 =A00.000000] Movable zone start PFN for each node</div><div>[ =A0 =A00.=
000000] early_node_map[1] active PFN ranges</div><div>[ =A0 =A00.000000] =
=A0 =A0 0: 0x00000000 -&gt; 0x00010000</div>
<div>[ =A0 =A00.000000] On node 0 totalpages: 65536</div><div>[ =A0 =A00.00=
0000] free_area_init_node: node 0, pgdat c01adb3c, node_mem_map c01e7000</d=
iv><div>[ =A0 =A00.000000] =A0 DMA zone: 65024 pages, LIFO batch:15</div><d=
iv>[ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping on=
. =A0Total pages: 65024</div>
<div>[ =A0 =A00.000000] Kernel command line: root=3D/dev/nfs rw nfsroot=3D1=
92.168.0.12:/project/target/target_nadatel ip=3D192.168.0.161:192.168.0.12:=
192.168.0.1::h264codec:eth0:off</div><div>[ =A0 =A00.000000] PID hash table=
 entries: 1024 (order: 10, 4096 bytes)</div>
<div>[ =A0 =A00.000000] time_init: decrementer frequency =3D 25.000000 MHz<=
/div><div>[ =A0 =A00.000000] time_init: processor frequency =A0 =3D 450.000=
000 MHz</div><div>[ =A0 =A00.000000] clocksource: timebase mult[a000000] sh=
ift[22] registered</div>
<div>[ =A0 =A00.038127] Dentry cache hash table entries: 32768 (order: 5, 1=
31072 bytes)</div><div>[ =A0 =A00.060153] Inode-cache hash table entries: 1=
6384 (order: 4, 65536 bytes)</div><div>[ =A0 =A00.134314] High memory: 0k</=
div><div>
[ =A0 =A00.141880] Memory: 257792k/262144k available (1648k kernel code, 42=
04k reserved, 76k data, 194k bss, 124k init)</div><div>[ =A0 =A00.172857] C=
alibrating delay loop... 49.79 BogoMIPS (lpj=3D24896)</div><div>[ =A0 =A00.=
207709] Mount-cache hash table entries: 512</div>
<div>[ =A0 =A00.234059] Unable to handle kernel paging request for data at =
address 0x00000032</div><div>[ =A0 =A00.255641] Faulting instruction addres=
s: 0xc0183c50</div><div>[ =A0 =A00.270489] Oops: Kernel access of bad area,=
 sig: 11 [#1]</div>
<div>[ =A0 =A00.286545] Freescale PQ2FADS</div><div>[ =A0 =A00.295392] Modu=
les linked in:</div><div>[ =A0 =A00.304504] NIP: c0183c50 LR: c0183ef4 CTR:=
 00000000</div><div>[ =A0 =A00.319345] REGS: cf821db0 TRAP: 0300 =A0 Not ta=
inted =A0(2.6.27)</div>
<div>[ =A0 =A00.336514] MSR: 00009032 &lt;EE,ME,IR,DR&gt; =A0CR: 82004024 =
=A0XER: 00000000</div><div>[ =A0 =A00.355515] DAR: 00000032, DSISR: 2000000=
0</div><div>[ =A0 =A00.367750] TASK =3D cf81f8a0[1] &#39;swapper&#39; THREA=
D: cf820000</div>
<div>[ =A0 =A00.383362] GPR00: c0183ef4 cf821e60 cf81f8a0 00000000 c015e5e0=
 cf821ec0 00000024 0000013f</div><div>[ =A0 =A00.408348] GPR08: 3860ffda c0=
1a0000 00000002 8124000c 24004024 ffffffff 0fffe000 11fc6000</div><div>[ =
=A0 =A00.433334] GPR16: fffffffb fcfdffff fffffeff ffffffff 00000000 0fff8c=
94 00000002 0ff65e80</div>
<div>[ =A0 =A00.458319] GPR24: 00000000 00000000 00000000 c01b0000 cf821ec0=
 c01b0000 c01b0000 cf821eb8</div><div>[ =A0 =A00.483863] NIP [c0183c50] fin=
d_section32+0x14/0xb8</div><div>[ =A0 =A00.498409] LR [c0183ef4] vdso_do_fi=
nd_sections+0x28/0xc8</div>
<div>[ =A0 =A00.514537] Call Trace:</div><div>[ =A0 =A00.521839] [cf821e60]=
 [c00f5ce8] kobject_uevent_env+0x2f4/0x318 (unreliable)</div><div>[ =A0 =A0=
0.543176] [cf821e90] [c0183ef4] vdso_do_find_sections+0x28/0xc8</div><div>[=
 =A0 =A00.561394] [cf821eb0] [c01841b4] vdso_setup+0x2c/0xb8</div>
<div>[ =A0 =A00.576749] [cf821f10] [c0184308] vdso_init+0x64/0x1dc</div><di=
v>[ =A0 =A00.592113] [cf821f30] [c0003904] do_one_initcall+0x54/0x184</div>=
<div>[ =A0 =A00.609022] [cf821fb0] [c017d848] do_initcalls+0x34/0x58</div><=
div>[ =A0 =A00.624897] [cf821fd0] [c017d92c] kernel_init+0x40/0x94</div>
<div>[ =A0 =A00.640528] [cf821ff0] [c000f9f8] kernel_thread+0x44/0x60</div>=
<div>[ =A0 =A00.656643] Instruction dump:</div><div>[ =A0 =A00.665493] 41a2=
000c 7c0803a6 4e800021 80010014 38210010 7c0803a6 4e800020 9421ffd0</div><d=
iv>[ =A0 =A00.688656] 7c0802a6 bf010010 90010034 7cbc2b78 &lt;a1230032&gt; =
3b400001 7c7f1b78 81630020</div>
<div>[ =A0 =A00.712438] ---[ end trace 31fd0ba7d8756001 ]---</div><div>[ =
=A0 =A00.726196] Kernel panic - not syncing: Attempted to kill init!</div><=
div>[ =A0 =A00.743876] Rebooting in 180 seconds..</div><div>---------------=
----------------</div>
<div><br></div><div><br></div><div>I don&#39;t know what is could someone h=
elp me?</div><div><br></div><div>Thanks=A0</div><div>Best Regards</div><div=
><br></div><div><br></div><div>Victor</div>

--000e0cd34846e8d0fb048d0ab486--

--===============6355927879044620287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============6355927879044620287==--
