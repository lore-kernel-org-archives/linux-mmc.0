From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Tue, 31 May 2016 13:54:31 +0200
Message-ID: <574D7B77.4000606@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <20160505224240.GA31429@rob-hp-laptop>
 <CAPDyKFqpoi03Egfuvd8qJXnn_+FBgPXAb7S4UvkxVs8BA+zwnA@mail.gmail.com>
 <20160509181829.GA19687@rob-hp-laptop>
 <CAPDyKFq2=mqujFjvJSYxg2nVmK=OrBKLtFfb-ErNJO3Zr_LMVw@mail.gmail.com>
 <20160528033613.GA3291@shlinux2> <20160531005808.GA7913@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160531005808.GA7913@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-usb@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, hverkuil@xs4all.nl, tjakobi@math.uni-bielefeld.de, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On 05/31/2016 02:58 AM, Peter Chen wrote:
> On Sat, May 28, 2016 at 11:36:13AM +0800, Peter Chen wrote:
>> All, how we move on for this?
>>
>> 1. Using a generic driver to manage both mmc and USB (and further
>> subsystem), USB and further subsystem do not use pwrseq node in dts.
>> 2. USB creates the similar driver under drivers/usb for its own use. 
>>
>> Which one do you prefer, thanks.
>>
> 
> Hi Krzysztof Kozlowski,
> 
> I think option 1 may be better according to Rob and Ulf's comment.

Hi,

I like the option #1 as well. The generic driver should rely and parse
existing bindings like 'reset-gpios'. Still additional property (e.g.
"do-the-power-sequence") seems needed as we do not want to play with all
reset-gpios in DTB.

> Would you like going on your patch set? You can work on generic pwrseq
> driver, I will do USB stuffs based on generic pwrseq driver?

Great, that sounds good! I'll start the work.

Best regards,
Krzysztof
