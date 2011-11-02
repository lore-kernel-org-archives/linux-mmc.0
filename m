From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH v2] mmc: sdhci: remove "state" argument from sdhci_suspend_host
Date: Wed, 2 Nov 2011 15:26:41 +0100
Message-ID: <CAOLZvyH8pzeme2j8dbfnLkpSKEYmoo34YL_5y+8nWgciKBJXvQ@mail.gmail.com>
References: <1320242806-2365-1-git-send-email-manuel.lauss@googlemail.com> <4EB151E9.8080607@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39571 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab1KBO1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 10:27:23 -0400
Received: by ywf7 with SMTP id 7so180720ywf.19
        for <linux-mmc@vger.kernel.org>; Wed, 02 Nov 2011 07:27:22 -0700 (PDT)
In-Reply-To: <4EB151E9.8080607@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Nov 2, 2011 at 3:21 PM, Adrian Hunter <adrian.hunter@intel.com>=
 wrote:
> On 02/11/11 16:06, Manuel Lauss wrote:
>> Drop the "state" argument from sdhci_suspend_host. =A0It's only user
>> is the PCI glue; =A0this allows to move all SDHCI glues to use
>> dev_pm_ops instead.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> V2: sdhci-s3c does not use sdhci-pltfm.c and gets its own dev_pm_ops=
=2E

> Also need to remove "pm_message_t state =3D { .event =3D PM_EVENT_SUS=
PEND };"
> e.g.
>
> =A0 =A0 =A0 =A0drivers/mmc/host/sdhci-pci.c: In function 'sdhci_pci_r=
untime_suspend':
> =A0 =A0 =A0 =A0drivers/mmc/host/sdhci-pci.c:1103:15: warning: unused =
variable 'state' [-Wunused-variable]

Interesting, I didn't see a warning.  Will fix.

Thank you,
        Manuel Lauss
