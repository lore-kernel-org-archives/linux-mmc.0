From: Jaya Kumar <jayakumar.sc@gmail.com>
Subject: Re: [PATCH v4] ARM: davinci: AM18x: Add wl1271/wlan support
Date: Thu, 4 Aug 2011 16:40:01 +0800
Message-ID: <CADqH6Vz3gn6dwLHtfZkzLxkHfHqRV3e+C_w_hfYO2-PK_TU4eA@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DF05D8E@dbde02.ent.ti.com>
	<1312444283-25581-1-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40269 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1HDIkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Aug 2011 04:40:03 -0400
Received: by ewy4 with SMTP id 4so762098ewy.19
        for <linux-mmc@vger.kernel.org>; Thu, 04 Aug 2011 01:40:01 -0700 (PDT)
In-Reply-To: <1312444283-25581-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>
Cc: Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Thu, Aug 4, 2011 at 3:51 PM, Ido Yariv <ido@wizery.com> wrote:
> +static __init int da850_wl12xx_init(void)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D davinci_cfg_reg_list(da850_wl12xx_pins);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("wl12xx/mmc mux setup failed: %d=
\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D da850_register_mmcsd1(&da850_wl12xx_mmc_config)=
;
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("wl12xx/mmc registration failed:=
 %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_=
LOW, "wl12xx_en");
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not request wl12xx enable=
 gpio: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, "wl1=
2xx_irq");
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not request wl12xx irq gp=
io: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_wlan_en;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 da850_wl12xx_wlan_data.irq =3D gpio_to_irq(DA850_WLAN_I=
RQ);
> +
> + =A0 =A0 =A0 ret =3D wl12xx_set_platform_data(&da850_wl12xx_wlan_dat=
a);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not set wl12xx data: %d\n=
", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_wlan_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;

Hi Ido,

A quick question for my own understanding. What's the mechanism by
which wl12xx is bound with above. I see above wl12xx_set_platform_data
but I didn't see something like .name =3D "wl1271" or dev_name that
comes in through platform_device_register. If I look at other board
files, I see:

321 #ifdef CONFIG_WL12XX_PLATFORM_DATA
322         {
323                 .name           =3D "wl1271",
324                 .mmc            =3D 2,
325                 .caps           =3D MMC_CAP_4_BIT_DATA |
MMC_CAP_POWER_OFF_CARD,
326                 .gpio_wp        =3D -EINVAL,
327                 .gpio_cd        =3D -EINVAL,
328                 .nonremovable   =3D true,
329         },
330 #endif

and

729 #ifdef CONFIG_WL12XX_PLATFORM_DATA
730         /* WL12xx WLAN Init */
731         if (wl12xx_set_platform_data(&omap3evm_wlan_data))
732                 pr_err("error setting wl12xx data\n");
733         platform_device_register(&omap3evm_wlan_regulator);
734 #endif

Thanks,
jayakumar
