From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci: wakeup from runtime PM
Date: Fri, 8 Apr 2016 22:51:51 +0200
Message-ID: <CAPDyKFqMOmNhXfJGVyvBvc5dD=wTR3Wvz64CuL8iq4dQJSHk3g@mail.gmail.com>
References: <CAPDyKFqJ4Q9hdsv427GaT_2qFpvv=Nn3rZQUS+P8O7FF-gKgyw@mail.gmail.com>
	<Pine.LNX.4.44L0.1604081114480.2069-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1604081114480.2069-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 April 2016 at 17:19, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 8 Apr 2016, Ulf Hansson wrote:
>
>> From power consumption point if view we already discussed this
>> particular case in an earlier thread, but let me elaborate what I
>> think one more time:
>>
>> Now, this is relevant for removable cards lacking GPIO card detect, as
>> for other cases and non-removable cards I think we are in agreement
>> that their is no issue from power consumption point of view, right!?
>>
>> 1. The current solution:
>> - Use MMC_CAP_NEEDS_POLL which makes the mmc core to re-schedule a
>> work once every second to poll for a card (Why is it one second? Could
>> we perhaps have that configurable?).
>
> The block layer handles media polling for removable block devices, and
> it is configurable.  For example, /sys/block/sr0/events_poll_msecs can
> be set to control how often the system polls for a disc in my DVD
> drive.
>
> Does MMC do its own polling separate from the block layer?  If so, why?

Good question. Probably because of legacy or perhaps to deal with corner cases.

When I get some spare bandwidth I will check to see if it makes sense
to convert MMC polling to the block layer polling.

Kind regards
Uffe
