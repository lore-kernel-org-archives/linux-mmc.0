From: "Simon Raffeiner (SCC)" <simon.raffeiner@kit.edu>
Subject: Re: "Timeout waiting for hardware interrupt" on Lenovo Thinkpad Tablet
 10
Date: Mon, 2 Feb 2015 14:38:19 +0100
Message-ID: <54CF7DCB.8070302@kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from scc-mailout-kit-02.scc.kit.edu ([129.13.231.82]:39503 "EHLO
	scc-mailout-kit-02.scc.kit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754325AbbBBN5H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 08:57:07 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sb@m-labs.hk
Cc: linux-mmc@vger.kernel.org

Hello S=C3=A9bastien,

I own a Lenovo Thinkpad Tablet 8, which is quite similar to the Thinkpa=
d
Tablet 10, and we seem to run into the same issues with both devices.

I am currently trying to install Ubuntu 15.04 using an USB stick, so my
kernel version is 3.18.0-12-generic (which is based on the 3.18.3
upstream stable kernel).

As you reported, the tablet reliably freezes after about 15 to 20
minutes, regardless if "debug_quirks2=3D0xc0" is set or not. The last
kernel message is "mmc0: Timeout waiting for hardware interrupt". But i=
n
my case, the tablet also crashes if the eMMC storage is not used as the
root filesystem, it also happens in the live environment booted off the
USB stick, e.g. when trying to do an mkfs on one of the eMMC partitions=
=2E

Thanks a lot for reporting this issue, I was already about to send the
device back because I thought the eMMC was broken.

regards,
Simon




S=C3=A9bastien Bourdeauducq wrote:

> Hi,
>
> Under Linux, the most annoying problem that the Lenovo Thinkpad Table=
t
> 10 has is the unreliable eMMC.
>
> I intermittently get an error "mmc0: Timeout waiting for hardware
> interrupt" followed by a crash of the machine (when the eMMC is used
> as rootfs).
>
> I have been able to work around this issue with kernel 3.13.0 by
> passing the debug_quirks2=3D0xc0 option to the sdhci module, which
> disables the HS200 and DDR50 transfer modes. The read data rate (as
> measured by hdparm -t) drops from 119MB/s to 42MB/s, but at least the
> computer no longer crashes every 20 minutes and my files are not
> corrupted anymore.
>
> Unfortunately, with more recent kernels such as 3.18.4, the sdhci
> module (still with debug_quirks2=3D0xc0) appears to select another
> problematic transfer mode. The read data rate jumps to 65MB/s and the
> bug manifests itself again.
>
> What changes in sdhci between 3.13.0 and 3.18.4 could cause that? I'd
> like to be able to use the eMMC reliably at least at 42MB/s using
> recent kernels, which hopefully will introduce fixes for the
> gazillion other problems that this crippled machine has under Linux
> (absolutely nothing works correctly except the CPU, display and USB).
>
> Thanks,
> S=C3=A9bastien
