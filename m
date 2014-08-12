From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: ARM: shmobile: Koelsch fails to resume due to sh_mobile_sdhi or regulator-fixed
Date: Tue, 12 Aug 2014 16:28:39 +0200
Message-ID: <CAMuHMdWTudFK_EiL8xQpmL5OmJxYX1i80WjfAA+L2Dfn21NWtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>, Ian Molton <ian.molton@codethink.co.uk>, Mark Brown <broonie@kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Magnus, Ian, Mark,

r8a7791/Koelsch fails to resume from s2ram with

    CONFIG_REGULATOR_FIXED_VOLTAGE=y
    CONFIG_REGULATOR_GPIO=y
    CONFIG_MMC_SDHI=y

Disabling CONFIG_REGULATOR_FIXED_VOLTAGE or CONFIG_MMC_SDHI,
or both, fixes resume.

Note that SDHI on r8a7791 uses both regulator-fixed and regulator-gpio.
However, CONFIG_REGULATOR_GPIO doesn't seem to have any impact
on the resume failure, it resumes fine with CONFIG_REGULATOR_GPIO=y.

Anyone with a clue?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
