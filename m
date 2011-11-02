From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: move suspend/resume hooks to dev_pm_ops
Date: Wed, 2 Nov 2011 12:12:04 +0100
Message-ID: <CAOLZvyGvNj3P9O3GYJ6PZv2UcSBDqajOcYVcd1kQj_a2jxHZkA@mail.gmail.com>
References: <1320150845-4185-1-git-send-email-manuel.lauss@googlemail.com> <4EB11137.4090404@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32913 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab1KBLMq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 07:12:46 -0400
Received: by gyb13 with SMTP id 13so9624gyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 02 Nov 2011 04:12:45 -0700 (PDT)
In-Reply-To: <4EB11137.4090404@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Adrian,

On Wed, Nov 2, 2011 at 10:45 AM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> On 01/11/11 14:34, Manuel Lauss wrote:
>> Move suspend/resume/freeze/thaw hooks from struct pci_driver to dev_=
pm_ops,
>> mainly to shut up the driver cores' complaints about this driver usi=
ng
>> both new and legacy PM methods.

[...]

>> +static int sdhci_pci_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct pci_dev *pdev =3D container_of(dev, struct pci_dev,=
 dev);
>> + =A0 =A0 return sdhci_pci_do_suspend(pdev, PMSG_SUSPEND);
>
> We need to get rid of state entirely. =A0Unfortunately that means
> changing sdhci_suspend_host() and all callers

This first attempt was a quick hack to get rid of the annoying messages=
=2E
I'll cook up something more thorough, hang on.

Thanks!
      Manuel Lauss
