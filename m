From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] SDHCI: Change AMD SDHCI quirk application scope
Date: Fri, 5 Jun 2015 11:20:01 +0200
Message-ID: <20150605092001.GB3679@pd.tnic>
References: <1433428437-6067-1-git-send-email-Vincent.Wan@amd.com>
 <20150604153220.GA4521@pd.tnic>
 <CAKT61h8E3=gvO=ZfFDPhBuWsWuPnGCxtxYa-izSOJk=RWKyUtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54499 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbbFEJUD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Jun 2015 05:20:03 -0400
Content-Disposition: inline
In-Reply-To: <CAKT61h8E3=gvO=ZfFDPhBuWsWuPnGCxtxYa-izSOJk=RWKyUtQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Wan ZongShun <Vincent.Wan@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Wan ZongShun <linux@mcuos.com>

On Fri, Jun 05, 2015 at 09:37:09AM +0800, Wan ZongShun wrote:
> Boris, I means I put this KERCZ Mircro in pci_ids.h, and I also will
> send the other patch to instead the following '0x790b' of codes. I
> think it is reasonable, right?

No, it means two things:

* why does it contain KERNCZ? What does that mean?

* #define PCI_DEVICE_ID_AMD_<better_name>_SMBUS 0x790b should be in
drivers/mmc/host/sdhci-pci.c as it is used only there.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
