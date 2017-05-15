From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] Use device_property_read instead of of_property_read in
 the dw_mmc driver
Date: Mon, 15 May 2017 16:30:08 +0300
Message-ID: <CAHp75VdqV35EDUo3m19_9M7cYzvZnsJ7Ou1+ks9_S-8qDhDLZQ@mail.gmail.com>
References: <1493134767-19170-1-git-send-email-dwoods@mellanox.com> <CAPDyKFpRsHGkS9hH9c_SGMNNU8ZC-=9Kk8-iVDnKrMUXbACNag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34185 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933359AbdEONaK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2017 09:30:10 -0400
In-Reply-To: <CAPDyKFpRsHGkS9hH9c_SGMNNU8ZC-=9Kk8-iVDnKrMUXbACNag@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Woods <dwoods@mellanox.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Heiner Kallweit <hkallweit1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, cmetcalf@mellanox.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, May 15, 2017 at 12:36 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 25 April 2017 at 17:39, David Woods <dwoods@mellanox.com> wrote:
>> Using the device_property interfaces allows the dw_mmc driver to work
>> on platforms which run on either device tree or ACPI.

> Can you please split this to two separate changes. One for dw_mmc with
> a proper prefix (mmc: dw_mmc:) and one for the mmc core (prefix "mmc:
> core:").

Btw, for the core part of change I would recommend to check other API
functions which might go slightly different in case of ACPI vs DT vs
built-in device properties.

For example, if any code is using of_gpio header and of_ related stuff
it should be rethought as well (not sure if we would change there
anything, though worth to double check).

-- 
With Best Regards,
Andy Shevchenko
