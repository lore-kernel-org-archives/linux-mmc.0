From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: confusion regarding the CMD19 and CMD21 in eMMC/SD card spec
Date: Fri, 16 Sep 2011 11:44:29 +0530
Message-ID: <CAGxe1ZEfuXJkVXTqBACoDXtGaYzQf29z+3-_Du7d4HpXfZw5xg@mail.gmail.com>
References: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
	<0356427A-B949-4DA6-9F5D-FE0DD54AEDFF@marvell.com>
	<CAGxe1ZG4QjwB5OfrxupG_C+DtQ7sTQ4_EURaF-QrqPPSA3A0jw@mail.gmail.com>
	<20110916044706.GA4030@lovegaga>
	<CAGxe1ZGNBPcCMZQDdxCbO_CBBAm5FcF8R7FV0_P8MLEOcXqwYg@mail.gmail.com>
	<20110916055735.GA3938@lovegaga>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55562 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab1IPGOb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 02:14:31 -0400
In-Reply-To: <20110916055735.GA3938@lovegaga>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

our host controller supports both
SD/MMC. single controller to read both cards.

On 16 September 2011 11:27, Aaron Lu <aaron.lu@amd.com> wrote:
> On Fri, Sep 16, 2011 at 11:00:12AM +0530, Girish K S wrote:
>> Hello Aaron Lu,
> Hi,
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 please check the mmc 4.5 spe=
cification CMD21 is
>> tuning command.
>
> So you are using a mmc card with a sd host?
>
> -Aaron
>
>
