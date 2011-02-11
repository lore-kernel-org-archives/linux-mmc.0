From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Moving platform_data contents to device tree
Date: Fri, 11 Feb 2011 09:01:14 -0700
Message-ID: <AANLkTi=1UH-YBgS18pLbuGRGX02Xwxpek-wTGk5B3rGx@mail.gmail.com>
References: <AANLkTikGa9dkM5DMJrM=RDs9twMY=uE21u5NmOv-=dPG@mail.gmail.com> <4D555983.7090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53954 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247Ab1BKQBv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 11:01:51 -0500
Received: by yib18 with SMTP id 18so1126922yib.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 08:01:50 -0800 (PST)
In-Reply-To: <4D555983.7090102@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, linux-mmc@vger.kernel.org

On Fri, Feb 11, 2011 at 8:45 AM, Rob Herring <robherring2@gmail.com> wrote:
> Thomas,
>
> On 02/10/2011 09:29 PM, Thomas Abraham wrote:
>>
>> Hi,
>>
>> I am currently adding device tree support for Samsung's S5PV310
>> processor. I have a question about handling platform_data when adding
>> device tree support in drivers, specifically about the sdhci-s3c
>> driver.
>>
>> The platform data that is passed to the sdhci-s3c driver is defined in
>> file arch/arm/plat-samsung/plat/sdhci.h, struct s3c_sdhci_platdata. In
>> this structure, there are some function pointers that are passed to
>> the driver. These function pointers are setup by the platform code in
>> arch/arm/plat-samsung. But when platform devices are created from the
>> device tree, how would such function pointers be passed to the driver?
>>
>> Any suggestions on the approach to handle the platform_data
>> information when moving to device tree would be very helpful.
>>
> As suggested by Grant, you can use bus notifiers. Here is an example:
>
> arch/powerpc/platforms/512x/pdm360ng.c
>
> Pure data (flags, quirks, chip select assignments, etc.) should ultimately
> go into the device tree.
>
> For board specific functions, use the bus notifiers. For SoC functions, put
> them in the driver and use the OF match table data pointer.

Yes, Rob is right.  However, things are simpler if the driver can be
designed so that it *doesn't* need platform callbacks.  Sometimes it
is unavoidable, but in a lot of cases platform callback turn into a
way to let platform code twiddle or read GPIOs.  In those cases it
would be better to turn those callbacks into real gpiolib drivers and
design the driver to use the gpio api.

> See sdhci-of-core.c for an example.

On a side note (and not related to sdhci-s3c); I'd like to be rid of
both sdhci-of-core.c and sdhci-pltfm.c.  I'm all for providing common
infrastructure, but I think those two files go about it in the wrong
way.  Rather than having a single platform_device (well, 2 in this
case, but of and non-of can be merged now) that matches against all
'platform' sdhci controllers, each specific controller should have its
own platform_driver structure.  The way it is done now creates too
much indirection (IMHO) and it would be cleaner if the common code was
available to the drivers a library function calls.

I've put splitting them up onto my todo list if somebody else doesn't
beat me to it.

g.
