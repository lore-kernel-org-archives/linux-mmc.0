From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Handle late vmmc regulator with EPROBE_DEFER
Date: Fri, 7 Jun 2013 08:01:34 -0700
Message-ID: <CAD=FV=V8fn3MHWjBJLu=eSo42UeHVog5FEmmSZiT-edFt7VkPg@mail.gmail.com>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
	<1664692.GUOAAQ3FLn@flatron>
	<20130607102404.GO31367@sirena.org.uk>
	<1841650.N6Drbs67FD@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:42043 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab3FGPBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jun 2013 11:01:36 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so4273767lbh.24
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jun 2013 08:01:35 -0700 (PDT)
In-Reply-To: <1841650.N6Drbs67FD@flatron>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Andrew Bresticker <abrestic@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, lgirdwood@gmail.com, Will Newton <will.newton@gmail.com>

Tomasz / Mark,

On Fri, Jun 7, 2013 at 3:30 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Friday 07 of June 2013 11:24:04 Mark Brown wrote:
>> On Fri, Jun 07, 2013 at 12:19:58PM +0200, Tomasz Figa wrote:
>> > This interesting case makes me think that regulator core should
>> > differentiate between regulator lookup failure due to no lookup
>> > specified and due to the regulator specified in lookup being
>> > unavailable, returning appropriate (different) error codes.
>>
>> It does exactly that in so far as it can - you get -ENODEV if there's
>> definitely no supply and -EPROBE_DEFER otherwise.
>
> Oh, right, thanks. I somehow felt that it should be doing this already,
> but I was looking at 3.9 on Free Electron's LXR. It does so since commit
>
> 1e4b545cdd regulator: core: return err value for regulator_get if there is
> no DT binding

Thanks, this is much cleaner.  That's what I get for doing the
majority of my work on 3.8 at the moment.  :-P

I will rework the patch and send it out again.

-Doug
