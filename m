From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 0/5] mmc: host: omap_hsmmc: a few improvements
Date: Thu, 24 Apr 2014 20:13:16 +0530
Message-ID: <53592304.3070105@ti.com>
References: <1395878690-9650-1-git-send-email-balbi@ti.com> <53592037.8050106@ti.com> <20140424143931.GE26661@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140424143931.GE26661@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday 24 April 2014 08:09 PM, Felipe Balbi wrote:
> On Thu, Apr 24, 2014 at 08:01:19PM +0530, Balaji T K wrote:
>> On Thursday 27 March 2014 05:34 AM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> this series lets us access the newer registers introduced
>>> back in OMAP4 which give us some valid information about
>>> the OMAP HSMMC IP like max block size, support for ADMA,
>>> support for Retention.
>>
>> "Support for Retention" looks interesting, can you shed more lights on
>> it
>
> HWINFO has a bit (bit 6) which tells you whether retention is supported,
> it's in all TRMs since OMAP3630 or so.
>
> "6	RERETMODE		Retention mode generic parameter
> 				This bit field indicates whether the
> 				retention mode is supported using the
> 				pin PIRFFRET.
>
> 				0x0: Retention mode disabled
> 				0x1: Retention mode enabled"
>

I have seen that but just wondering how the driver can make use of it :-)
