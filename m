From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCHv2] mmc: dw_mmc: use __devexit_p macro for .remove()
Date: Thu, 4 Oct 2012 13:11:40 +0100
Message-ID: <CAFbHwiTziS2Q+av6e2z6vZk0uoStZb8C8C5KkfCjtw5c4p=SEw@mail.gmail.com>
References: <CAGxe1ZHF--qR68A4PGBwmFe85DZUK3gxQWE+05PT9yKBUWOPrg@mail.gmail.com>
	<1349271927-6260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49573 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab2JDMLl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Oct 2012 08:11:41 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so294998lbo.19
        for <linux-mmc@vger.kernel.org>; Thu, 04 Oct 2012 05:11:40 -0700 (PDT)
In-Reply-To: <1349271927-6260-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

On Wed, Oct 3, 2012 at 2:45 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/dw_mmc-pci.c   |    2 +-
>  drivers/mmc/host/dw_mmc-pltfm.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
