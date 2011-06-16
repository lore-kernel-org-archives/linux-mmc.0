From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Thu, 16 Jun 2011 12:03:44 -0700
Message-ID: <E9495851-8BFC-40D2-9E38-346A028AFF9D@marvell.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
 <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
 <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
 <BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
 <BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
 <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
 <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
 <BANLkTimngwDzxW04AMFWBNYLvYFXUhMWQQ@mail.gmail.com>
 <BANLkTikUaKt3ESg0RKGpxCBK1t6fVvvGqx__uGzp_thPyzcmpA@mail.gmail.com>
 <BANLkTin43tZO1s-MFCnNt0q7pKvf1XRC9w@mail.gmail.com>
 <BANLkTim2NfCcfRRmcVXepLA0evusZoTJGA@mail.gmail.com>
 <BANLkTimg08VnOMrUwnH6dKzXPJO1fpOh6w@mail.gmail.com>
 <BANLkTinfeGUADyi1dTSjPRMnbP+TCtN0dQ@mail.gmail.com>
 <BANLkTimbxSA_86a=2QH1pEGg1-O9neEyhw@mail.gmail.com>
 <BANLkTimQUkf9ZsanZ-czqtYnyRSSSch4nQ@mail.gmail.com>
 <BANLkTi=jsPYEQOnRDyoXD_EzKdqby-QhYw@mail.gmail.com>
 <BANLkTi=VWUcCQJaBChnitVq1_TT1huE30A@mail.gmail.com>
 <BANLkTinG-CmEh9yXL9Sp+W7PyatvEdOhZQ@mail.gmail.com>
 <BANLkTi=zuMosw68EMSYjrVi+0dBQkNicJw@mail.gmail.com>
 <BANLkTi=6Fa66QYay_R6vkmREPcb1Bw_FRw@mail.gmail.com>
 <BANLkTimOVsSe=mPOZ=ArGfy4w2QrYgLA+Q@mail.gmail.com>
 <BANLkTino3hz9NCfjtqM2UYtncYa6y_k=Qg@mail.gmail.com>
 <BANLkTi==drxM8Y4BffQwDSzraWXQ3-ta0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:49456 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041Ab1FPTG6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2011 15:06:58 -0400
In-Reply-To: <BANLkTi==drxM8Y4BffQwDSzraWXQ3-ta0g@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Seeing something similar but the details are a little different.  My kernel is somewhat old but ...
Seeing this with sd card and android.
card is removed/inserted/removed/inserted etc very quickly during power operations.  After 20-30 times
a problem occurs.  this can be anything from file system errors, partition not recognized or a kernel hang.

My thought is this is not a quirk issue but power down needs to be delayed during the power up
sequence until processing has been completed in the mmc layer.  Any thoughts on how to 
debug this would be welcome.  When the hang happens the system is not dead (as in 
console output showing card insert/remove still happens but console is locked etc.

thanks,

Philip

I do not think a quirk is the answer.  
On Jun 16, 2011, at 10:27 AM, Daniel Drake wrote:

> On 13 June 2011 20:52, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> We need to debug the suspend/resume path. Now that we have the other
>> runtime pm paths working, we can pretty much tell there's no hw issue
>> at hand.
> 
> Found it. It's a timing issue. In our other tests we had not yet hit
> the case when power is removed then immediately restored.  However,
> during resume, the card is powered up, powered down, powered up, and
> then probed by libertas.
> 
> A msleep(250) is needed during power_restore. Then the reset works fine.
> 
> Why is there so much power flipping going on during resume? Is this a
> bug? Shouldn't it power it up, realise it has a driver already loaded,
> and go straight into probe?
> 
> But even if that gets fixed, we still need to fix the case where the
> network interface is brought down then up immediately (another way to
> trigger the issue). Would you suggest a card quirk for that? Adding
> another 250ms to the already-slow libertas powerup routine would be a
> bit painful, would you support the added complexity needed to make the
> 250ms delay only occur when >250ms has passed since it was powered
> off?
> 
> Thanks,
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

