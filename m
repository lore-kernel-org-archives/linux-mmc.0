From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: SDIO driver return -ENOSYS behaviour change?
Date: Fri, 28 Feb 2014 16:49:52 +0800
Message-ID: <53104DB0.9010709@intel.com>
References: <530F0118.2010501@intel.com>	<CAPDyKFrZAAVfFcaFx7o3TWMikWx7TvSPW_AuV1VsiuQF656uXg@mail.gmail.com>	<530F20E5.9000107@intel.com>	<CAPDyKFpcJ5T9QXbFzZnu4fdgfjsTntfrtS=mo=5Wb_uJa7iMbw@mail.gmail.com>	<530FF686.2080901@intel.com> <CAPDyKFpWS+hRJM2Fz=TZxyFzQWkGwE7YRTuToB_t+1ODY0SQeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpWS+hRJM2Fz=TZxyFzQWkGwE7YRTuToB_t+1ODY0SQeg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: NeilBrown <neilb@suse.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 02/28/2014 04:30 PM, Ulf Hansson wrote:
> On 28 February 2014 03:37, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 02/27/2014 09:05 PM, Ulf Hansson wrote:
>>> I think it's more a matter of having a controlled suspend sequence.
>>> The mmc core are not able to serve any new SDIO requests while it is
>>> suspended, therefore it tells the sdio func driver about when it safe
>>> to send request - using it's PM callbacks.
>>
>> Does this mean after the function device is suspended from PM core's
>> pespective, the mmc core will still send some requests to the function
>> device? I did see one such request, disable_width, get sent after the
>> function driver's suspend callback is invoked, don't know if there are
>> others.
> 
> Nope. The mmc core will send request to the "card device" during
> suspend. Those are part's of a sequence to put the card in a proper
> "suspend mode".

I suppose this request is sent after calling function driver's suspend
callback? BTW, what request is it?

> 
>>
>> From the mmc_sdio_suspend function I can see two things are done:
>> 1 function device driver's suspend callback is called;
>> 2 optionally disable_width and power off the card according to some flags.
>>
>> So once we fixed the -ENOSYS problem, can we have the function device
>> run its own suspend callback and have the mmc_sdio_suspend just did the
>> disable_width and power off thing?
> 
> That requires that all sdio func devices get suspended before the card
> devices. (And resumed after, but that will of course be implicit.)

Yes, and this is guaranteed by PM core as the function device is the
child of the card device.

> 
> I guess the guarantee for that is already present, since we have added
> the func device to the driver model after we have added the card
> device at mmc_sdio_attach(). So, I suppose this could work.

Exactly.

> 
> Do you want me to create a patch that you can test?

That would be good. I do not have any SDIO card at hand, but I would be
glad to review the patch.

Thanks,
Aaron
