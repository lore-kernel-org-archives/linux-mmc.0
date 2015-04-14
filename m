From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Tue, 14 Apr 2015 18:52:10 +0200
Message-ID: <552D45BA.9090403@broadcom.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>	<551BDAEA.20405@intel.com>	<551C0A4C.9020602@broadcom.com>	<CAPDyKFp=DBj1==KVBxbZqE9Zo9F7QAxENcU_dqXUb5pvyNrv5A@mail.gmail.com>	<551D1A59.5060803@broadcom.com>	<CAPDyKFqdwQVEoKWH-Et32PZxVrcOabt7rek=Xq01yLmebgXuOA@mail.gmail.com>	<551D3391.8040508@intel.com>	<CAPDyKFrFoiKFC+i_TF_NR9Mg6b9JxzqRHyyN72z331s+0Gge2A@mail.gmail.com>	<551D35C6.7070605@broadcom.com>	<551D396F.1020301@intel.com>	<CAPDyKFpyu5fYw4e_ptP-WYfsQWmJairu4CnVk7abOvE5pZJU8g@mail.gmail.com>	<5524DBD1.8020606@intel.com> <CAPDyKFr+Q=tjL5NqDHr566cj7n4xNAt6Z3kEnyUFBfFtO-4Hvg@mail.gmail.com> <552D183B.5080409@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:62899 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932958AbbDNQwO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2015 12:52:14 -0400
In-Reply-To: <552D183B.5080409@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Neil Brown <neil@brown.name>

On 04/14/15 15:38, Adrian Hunter wrote:
>> To enumerate a SDIO card the mmc core first needs to apply power to
>> >  it. At this point the PM domain isn't yet attached to the SDIO func
>> >  device (the device doesn't even exist yet) and thus it can't be used
>> >  to provide power the card. Right?
> In the ACPI case the SDIO function device ACPI nodes are children of the
> host controller ACPI node. One possibility is to have the host controller
> driver power on its children.

This has recently been added to the DT as well as some SDIO devices 
first need to be powered to be discoverable.

Regards,
Arend


