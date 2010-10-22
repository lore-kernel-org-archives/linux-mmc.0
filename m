From: kerstin jonsson <kerstin.jonsson@ericsson.com>
Subject: Re: mount rootfs over NFS problem
Date: Fri, 22 Oct 2010 12:17:08 +0200
Message-ID: <4CC164A4.7030604@ericsson.com>
References: <4CBF04CD.3090902@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw9.se.ericsson.net ([193.180.251.57]:52975 "EHLO
	mailgw9.se.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab0JVKRK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 06:17:10 -0400
In-Reply-To: <4CBF04CD.3090902@ericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

As it turned out the PPC32 build was broken - due to changes in the
initramfs size calculation - I ended up with a __initramfs_size of zero, 
after
which not much worked.
Sorry for cluttering the list with misleading information, however, no 
one seem
to have taken any notice so I guess - no harm done.
Patch to follow...

Rgds,
Kerstin

On 10/20/2010 05:03 PM, kerstin jonsson wrote:
> Hi,
>
> I have a powerpc based platform and would like to have access to all the
> latest
> RapiodIO patches included in the mm-tree, but I fail to mount my rootfs
> over nfs using the latest mm-kernel.
>
> I can see that the code handling nfs mount in the mm-tree differs
> significantly from the  code in the kernel I used earlier (where nfs
> mount of rootfs works for me - linux-2.6 currently 2.6.36-rc8).
>
> I'm using the same default_config options as input to the mm-build as I
> do for 2.6.36-rc8 and the same kernel cmdline options, the console log
> from the boot show no significant deviation from the two kernels, not
> until I reach the point init init/main.c:kernel_init() where
> /dev/console is supposed to be opened. If it is helpfull in any way, the
> nfs mount attempt fails at:
>
> line 2131 of fs/namespace.c:do_mount()
>
> I guess that there is something that I need to do different to make this
> happen in the mm-tree - possibly something my platform init code should
> have prepared or some extra kernel config option(s) that  is/are needed
> when building the mm kernel.
>
> Please advice!
> Kerstin
>
> Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.201:/srv/nfs
> ip=192.168.0.142:192.168.0.201:192.168.0.1:255.255.255.0:unknown:eth0:off console=ttyS0,115200
> riohdid=0 nfsrootdebug
>
> console printout from mm-kernel:
> ...
> IP-Config: Complete:
>        device=eth0, addr=192.168.0.142, mask=255.255.255.0, gw=192.168.0.1,
>        host=unknown, domain=, nis-domain=(none),
>        bootserver=192.168.0.201, rootserver=192.168.0.201, rootpath=
> Warning: unable to open an initial console.
> Root-NFS: nfsroot=/srv/nfs
> VFS: Unable to mount root fs via NFS, trying floppy.
> ...
>
> console printout from 2.6.36-rc8:
>
> ...
> IP-Config: Complete:
>        device=eth0, addr=192.168.0.142, mask=255.255.255.0, gw=192.168.0.1,
>        host=unknown, domain=, nis-domain=(none),
>        bootserver=192.168.0.201, rootserver=192.168.0.201, rootpath=
> Root-NFS: Mounting /srv/nfs on server 192.168.0.201 as root
> Root-NFS:     rsize = 4096, wsize = 4096, timeo = 0, retrans = 0
> Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
> Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
> Looking up port of RPC 100003/2 on 192.168.0.201
> PHY: mdio@fa724520:09 - Link is Up - 100/Full
> Root-NFS: Portmapper on server returned 2049 as nfsd port
> Looking up port of RPC 100005/1 on 192.168.0.201
> Root-NFS: mountd port is 34144
> VFS: Mounted root (nfs filesystem) on device 0:12.
> ...
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    


