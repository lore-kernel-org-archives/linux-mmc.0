From: Philip Rakity <prakity@marvell.com>
Subject: Re: confusion regarding the CMD19 and CMD21 in eMMC/SD card spec
Date: Thu, 15 Sep 2011 09:23:07 -0700
Message-ID: <0356427A-B949-4DA6-9F5D-FE0DD54AEDFF@marvell.com>
References: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


Different committee's --- Different standards.

There is no issue with overlap.  


On Sep 15, 2011, at 4:58 AM, Girish K S wrote:

> Dear all,
>             The eMMC 4.5 specification mentions that the CMD21 in
> class 2 is a SEND_TUNING BLOCK command. where as the SD card
> specification
> in the given link says CMD19 in class 2 is the SEND_TUNING_BLOCK
> http://www.scribd.com/doc/50685191/53/Figure-4-8-Send-Tuning-Block-Command.
> Also the implementation in the drivers/mmc/host/sdhci.c uses the CMD19
> as the SEND_TUNING_BLOCK.
> Can anybody clarify why there is overlapping in this command number.
> May be my understand is wrong.
> 
> In the MMC spec the CMD19 is BUS_TEST_W in class 0 and CMD21 is
> reserved till eMMC 4.41 version.
> But in the SD specification (given link) CMD19 is SEND_TUNING_BLOCK
> and CMD21 is reserved.
> 
> Thanks and regards
> Girish K S
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
