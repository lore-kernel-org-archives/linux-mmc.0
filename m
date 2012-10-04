From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use helper macro module_platform_driver()
Date: Thu, 4 Oct 2012 13:10:57 +0100
Message-ID: <CAFbHwiQQ9KJ_hddRng54THBQ5E=8L5ge=Pkcv3pak2MKnoavHg@mail.gmail.com>
References: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1349270797-19189-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34272 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab2JDMK7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Oct 2012 08:10:59 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so294444lbo.19
        for <linux-mmc@vger.kernel.org>; Thu, 04 Oct 2012 05:10:57 -0700 (PDT)
In-Reply-To: <1349270797-19189-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, Oct 3, 2012 at 2:26 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Since v3.2 we have nice macro to define the platform driver's init and exit
> calls. This patch simplifies the dw_mmc platform driver by using that macro.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
