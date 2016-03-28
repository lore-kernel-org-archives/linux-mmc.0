From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] regulator: s2mps11: Fix invalid minimal selector for buck9
 supplying SD card
Date: Mon, 28 Mar 2016 14:37:49 +0900
Message-ID: <56F8C32D.3090609@samsung.com>
References: <1459126489-18311-1-git-send-email-k.kozlowski@samsung.com>
 <56F8900D.3080203@osg.samsung.com> <56F8A5E8.5010908@samsung.com>
 <CANAwSgRm1djUXUUua9mDM37qa7_jz_7X88igQtejupC5GoSQoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CANAwSgRm1djUXUUua9mDM37qa7_jz_7X88igQtejupC5GoSQoQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-mmc@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 28.03.2016 14:35, Anand Moon wrote:
> Should their be a fix in the u-boot for HK for this issue ?

It depends whether U-Boot S2MPS11 driver has this bug or has not. I did
not observe any issues with U-Boot at this matter.

> mmc card detection logic is pretty old in HK u-boot.

This is not related to MMC card detection logic.

Best regards,
Krzysztof
