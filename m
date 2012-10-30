From: Daniel Drake <dsd@laptop.org>
Subject: Re: sdhci vccq regulator support drops UHS-I flags
Date: Tue, 30 Oct 2012 14:56:06 -0600
Message-ID: <CAMLZHHTDrzMc8J89dbyuvy6P_Qe0ynoQW7RFje9_8ppYNkFOSw@mail.gmail.com>
References: <CAMLZHHS-xSEEFpKOEZyxG8CLQqwzwCYw8k=bbO3psEeZ78ZeNQ@mail.gmail.com>
	<E4ECCB94-95A7-4350-8FBD-1CB0D6D52ED6@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56945 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934158Ab2J3U4I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 16:56:08 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so434601pad.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Oct 2012 13:56:06 -0700 (PDT)
In-Reply-To: <E4ECCB94-95A7-4350-8FBD-1CB0D6D52ED6@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Oct 30, 2012 at 2:37 PM, Philip Rakity <prakity@nvidia.com> wrote:
> Intentional.
>
> if no vqmmc regulator then just assume it will work.

When you say "it", do you mean "UHS-I support"?
The code in this case will *disable* UHS-I support, because these lines are hit.
+               caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+                      SDHCI_SUPPORT_DDR50);

> if there is a regulator it needs to support 1.8V.  (If I remember correctly UHS mode require 1.8V vccq)  I need to check if we 1.2V should be allowed but it was not in the spec that I had.

I'm asking about the case when there is no regulator.

Thanks
Daniel
