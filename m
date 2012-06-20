From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: tmio: Don't access hardware registers after stopping clocks
Date: Wed, 20 Jun 2012 02:22:19 -0400
Message-ID: <87fw9q4i5g.fsf@octavius.laptop.org>
References: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<Pine.LNX.4.64.1206131527080.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1206131527080.17854@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 13 Jun 2012 15:27:35 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 13 2012, Guennadi Liakhovetski wrote:
> On Tue, 12 Jun 2012, Laurent Pinchart wrote:
>
>> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
>> width. When the mmc core requests the driver to power off the card, we
>> inform runtime PM, that the controller can be suspended. This can lead
>> to the MSTP clock being turned off.
>> 
>> Writing to any 16-bit hardware registers with the MSTP clock off leads
>> to timeouts and errors being printed to the kernel log. This can occur
>> both when stopping the MMC clock and when configuring the bus width.
>> 
>> To fix this, stop the MMC clock before calling put_runtime_pm(), and
>> skip bus width configuration when power is off.
>> 
>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
