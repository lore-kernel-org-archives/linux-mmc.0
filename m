From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: SDR104 card, Intel Joule and Linux 4.11
Date: Tue, 18 Apr 2017 13:27:51 +0300
Message-ID: <f6080192-30a5-ee81-fb19-7ebb4e0ff56b@intel.com>
References: <CAE+8NkJhOGGrWD1NeLk1AoNtdOqwoMtbpWFgbSoo0O1kdtQuZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:61100 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932413AbdDRKdd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 06:33:33 -0400
In-Reply-To: <CAE+8NkJhOGGrWD1NeLk1AoNtdOqwoMtbpWFgbSoo0O1kdtQuZw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Ewalt <johnewalt@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 17/04/17 03:36, John Ewalt wrote:
> Hi all,
> 
> I am not sure if this is the right way to ask a question about SD cards, so
> please correct me as I am new to Linux kernel development. 
> 
> I am currently working with a Intel Joule SOM and development board (Broxton
> M core) and when I insert the SD card, it is recognized as a SDR104 UHS-I
> card.  Since this host has the MMC_CAP_AGGRESSIVE_PM bit set, it is
> suspended.  That all works as expected.  When the card is resumed, the OCR
> is read expecting bit 24 (switch to 1.8 V accepted (S18A)) to be set, but it
> is clear as the card is still at 1.8v signaling since it was never powered
> down during the suspend.  

I would expect the power to go off.  AFAICS there is ASL in the host
controllers _PS3 method to tell the PMIC to do that.

> 
> I see 3 ways to solve this problem:
> First, power down the card during suspend.  I think this is the intended
> behavior but there is no power manager registered to this host (as compiled)
> and I'm not sure how to add one, let alone the hardware changes necessary to
> implement the powering down of the sd card.
> 
> Second, don't suspend (I have tested this and it works as the card is not
> suspended) 
> 
> Third, the host could remember that the card was at 1.8v signaling and if it
> will not "switch" to 1.8v, assume it is at 1.8v and go through the uhs_setup
> anyway.  I have tried this too and it works for UHS cards, but I doubt it
> would be the right change.
> 
> 
> I would appreciate any help or direction anyone can provide as I would
> really like to use my fast card at the full data rates.  I am currently
> setup to test any suggestions you have.  
> 
> Thank you all,
> 
> -John
> 

