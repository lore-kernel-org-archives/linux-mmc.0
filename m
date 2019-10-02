From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] mmc: sh_mmcif: Use platform_get_irq_optional() for
 optional interrupt
Date: Wed, 2 Oct 2019 08:26:00 +0000
Message-ID: <TYAPR01MB454472C76E03930717A2898BD89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191001180834.1158-1-geert+renesas@glider.be>
 <20191002081553.GB1388@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002081553.GB1388@ninjato>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jiri Slaby <jslaby@suse.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

> From: Wolfram Sang, Sent: Wednesday, October 2, 2019 5:16 PM
<snip>
> Tested on a R-Car H2: it does make the error message go away and the
> MMCIF device acts normal during boot. Can't enter userspace currently
> with v5.4-rc1 but this is unrelated to this patch and MMCIF. Looks like a
> configuration thing on my side, so I will still give:

I also should have reported this though, my environment (R-Car H2 + NFS +
buildroot on v5.4-rc1 with shmobile_defconfig) also has a similar issue
like the following:

[    3.573488] VFS: Mounted root (nfs filesystem) on device 0:16.
[    3.579869] devtmpfs: mounted
[    3.588014] Freeing unused kernel memory: 1024K
[    3.651771] Run /sbin/init as init process
Starting syslogd: OK
Starting klogd: OK
Initializing random number generator... [    4.073629] random: dd: uninitia=
lized urandom read (512 bytes read)
urandom start: failed.
done.
Starting network: ip: OVERRUN: Bad address
ip: OVERRUN: Bad address
ip: OVERRUN: Bad address

Best regards,
Yoshihiro Shimoda
