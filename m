From: Arik Nemtsov <arik@wizery.com>
Subject: Re: [PATCH] mmc: core: claim host during mmc_power_off on suspend
Date: Wed, 18 Jan 2012 15:22:07 +0200
Message-ID: <CA+XVXfdZZBEQqG5wxweyO4odyqo43TGZWuF3BZikmxsdoRxRSg@mail.gmail.com>
References: <1326293468-18604-1-git-send-email-arik@wizery.com> <4F1520D6.6070703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48344 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab2ARNWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jan 2012 08:22:24 -0500
Received: by bkas6 with SMTP id s6so2748787bka.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jan 2012 05:22:23 -0800 (PST)
In-Reply-To: <4F1520D6.6070703@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Jan 17, 2012 at 09:18, Adrian Hunter <adrian.hunter@intel.com> =
wrote:
>> - =A0 =A0 if (!err && !mmc_card_keep_power(host))
>> + =A0 =A0 if (!powered_off && !err && !mmc_card_keep_power(host)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
>
> Why not mmc_try_claim_host() etc?
>

Sure, mmc_try_claim_host() sounds better. I'll respin a v2.

Arik
