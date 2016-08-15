From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM64: dts: meson-gxbb: add MMC support
Date: Mon, 15 Aug 2016 16:33:02 -0500
Message-ID: <m2fuq5afap.fsf@baylibre.com>
References: <201608141319.AeQlvjsy%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201608141319.AeQlvjsy%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (kbuild test
	robot's message of "Sun, 14 Aug 2016 13:25:40 +0800")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Xing Wu <xing.xu-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

> Hi Kevin,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.8-rc1 next-20160812]
> [cannot apply to ulf.hansson-mmc/next robh/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Kevin-Hilman/ARM64-dts-meson-gxbb-add-MMC-support/20160804-072056
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
>
> All errors (new ones prefixed by >>):
>
>>> Error: arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:338.21-22 syntax error
>>> FATAL ERROR: Unable to parse input tree

This is due to a clock dependency[1] which is in the process of being
queued in the clock tree.

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/446650.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
