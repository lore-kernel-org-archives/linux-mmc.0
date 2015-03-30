From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
Date: Mon, 30 Mar 2015 09:55:32 +0900
Message-ID: <55189F04.8000404@samsung.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com>
 <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61320 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbbC3Azf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Mar 2015 20:55:35 -0400
In-reply-to: <5506707D.40708@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dear Doug,

I'm considering to control HLE error..So holding this patch.
If this is absolutely necessary patch, let me know, plz.

Best Regards,
Jaehoon Chung

On 03/16/2015 02:56 PM, Jaehoon Chung wrote:
> Hi, Doug.
> 
> On 03/14/2015 05:27 AM, Doug Anderson wrote:
>> Hi,
>>
>> On Fri, Mar 13, 2015 at 4:30 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi, Doug.
>>>
>>> On 03/11/2015 12:48 AM, Doug Anderson wrote:
>>>> The dw_mmc driver enables HLE errors as part of DW_MCI_ERROR_FLAGS but
>>>> nothing in the interrupt handler actually handles them and ACKs them.
>>>> That means that if we ever get an HLE error we'll just keep getting
>>>> interrupts and we'll wedge things.
>>>>
>>>> We really don't expect HLE errors but if we ever get them we shouldn't
>>>> silently ignore them.
>>>>
>>>> Note that I have seen HLE errors while constantly ejecting and
>>>> inserting cards (ejecting while inserting, etc).
>>>
>>> Right, It is occurred when card inserting/ejecting.(This case is the case of removable card.)
>>> Did you test with eMMC? We needs to consider how control HLE error.
>>
>> I'm running it on systems with eMMC, SD Cards, and SDIO WiFi.  HLE
>> doesn't show up in normal circumstances, only in ejecting the SD card
>> at the wrong time.  ...since you can't eject eMMC, I didn't see
>> problems there.
> 
> When card is inserting/removing, HLE is often occurred.
> Since there is some request into queue when card is removed.(in my understanding.)
> It's also related with controlling clock.
> 
>>
>>> But I think this patch can't solve all of HLE problem.
>>
>> Agreed.  HLE means that the controller is pretty wedged and (as I
>> understand it) means that there's something else we're doing wrong
>> elsewhere in the dw_mmc driver (like writing more data to an already
>> busy controller).  We should probably track down and find those cases,
>> too.
>>
>> I agree also that this code probably won't fix the controller in all
>> cases of HLE errors.  ...but I'm not 100% certain of the best way to
>> really do that, do you know?
>>
>> ...but in any case the absolute worst thing to do is what the driver
>> is already doing: unmask the HLE interrupt but never handle it
>> anywhere...  My patch is at least better than that...
> 
> Agreed, your patch should be at least better than now.
> But if pending is set HLE error bit,
> it should hit the cases of DW_MCI_DATA_ERROR_FLAGS & DW_MCI_CMD_ERROR_FLAGS.
> and i think send_stop_abort() can't run, doesn't?
> (If HLE is occurred at non-removable card, controller can't do anything.)
> 
> If i can reproduce HLE error, i can check more detailedly.(Trying to reproduce it.)
> I don't find fully solution yet. But finding the solution is my or our(?) part/role in future.
> Actually, i'm using the ctrl reset at my local tree, when HLE error is occurred.
> (Also it's not solution..)
> According to TRM, "HLE is raised, software then has to reload the command."
> We needs to consider how reload the command without lost previous request.
> 
>>
>> If you have another suggested way to make HLE error handling better
>> (or avoid them to begin with) I'm happy to test!  :)
> 
> I will try to find HLE error handling..if you also have other opinion, let me know, plz.
> I needs to listen other opinion, it's great helpful to me.. :)
> 
> Thank you a lot!
> 
> Best Regards,
> Jaehoon Chung
> 
>>
>>
>> -Doug
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

