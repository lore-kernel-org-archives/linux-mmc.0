From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Use platform_get_irq_optional() for
 optional interrupt
Date: Wed, 2 Oct 2019 10:32:04 +0200
Message-ID: <CAMuHMdWBghL8Em0OoCKjJdU7OiY_pV3Lmc=SXhV2yY=sKJJ-aw@mail.gmail.com>
References: <20191001180834.1158-1-geert+renesas@glider.be>
 <20191002081553.GB1388@ninjato> <TYAPR01MB454472C76E03930717A2898BD89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TYAPR01MB454472C76E03930717A2898BD89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jiri Slaby <jslaby@suse.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shimoda-san, Wolfram,

On Wed, Oct 2, 2019 at 10:26 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Wolfram Sang, Sent: Wednesday, October 2, 2019 5:16 PM
> <snip>
> > Tested on a R-Car H2: it does make the error message go away and the
> > MMCIF device acts normal during boot. Can't enter userspace currently
> > with v5.4-rc1 but this is unrelated to this patch and MMCIF. Looks like a
> > configuration thing on my side, so I will still give:
>
> I also should have reported this though, my environment (R-Car H2 + NFS +
> buildroot on v5.4-rc1 with shmobile_defconfig) also has a similar issue
> like the following:
>
> [    3.573488] VFS: Mounted root (nfs filesystem) on device 0:16.
> [    3.579869] devtmpfs: mounted
> [    3.588014] Freeing unused kernel memory: 1024K
> [    3.651771] Run /sbin/init as init process
> Starting syslogd: OK
> Starting klogd: OK
> Initializing random number generator... [    4.073629] random: dd: uninitialized urandom read (512 bytes read)
> urandom start: failed.
> done.
> Starting network: ip: OVERRUN: Bad address
> ip: OVERRUN: Bad address
> ip: OVERRUN: Bad address

Please cherry-pick the top commit from renesas-devel:
6e47c841329eb9b0 ("ARM: fix __get_user_check() in case uaccess_* calls
are not inlined")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
