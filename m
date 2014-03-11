From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Tue, 11 Mar 2014 10:42:11 +0100
Message-ID: <CALtMJEAv36qubJbNKZnnQPktP5UYYcxKc4e_K51AhQw6qePqjQ@mail.gmail.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com>
	<1393331866-28307-2-git-send-email-afenkart@gmail.com>
	<20140227213335.GJ11654@atomide.com>
	<CALtMJEArwH4g1o+_v8daoxiYZtpHvPMbxM4CZjTxnyGgxTS+aQ@mail.gmail.com>
	<20140305163331.GC4983@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140305163331.GC4983@atomide.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

2014-03-05 17:33 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> * Andreas Fenkart <afenkart@gmail.com> [140305 00:30]:
>> Hi,
>>
>> 2014-02-27 22:33 GMT+01:00 Tony Lindgren <tony@atomide.com>:
>> >
>> > The wake-irq is needed for omaps with wake-up path and also
>> > when doing GPIO remuxing. So the wake-up handling is pretty
>> > much the same for both cases.
>> I added this comment to the patch, since I was puzzled that you need
>> a wake_irq even whithout remuxing.
>
> Yeah we need it because omap_hsmmc is already doing runtime PM,
> so there's nothing stopping from shutting it down. And there's
> really no need to block runtime PM for it as it's working.
>
Also added this comment, since it really clarifies the issue.

FYI, just tried the patch without pin remuxing on am335x and
it actually works. Read: I'm always using the sdio pinmux never
reconfiguring the pin as a GPIO, but still get GPIO interrupts.
Yes, it fails if I comment out the pm_runtime_resume.

So it's not that the am335x suddenly has a swakeup line,
but looks like an implementation detail of the am335x GPIO
block.
