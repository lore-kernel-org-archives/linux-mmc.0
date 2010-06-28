From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] SDHCI: 8-bit data transfer width support
Date: Mon, 28 Jun 2010 12:48:29 -0700
Message-ID: <AANLkTim4yfMX60NoHODkc695R7k0ZwRKPVTXB_JOg7C_@mail.gmail.com>
References: <20100612054502.GA25686@july> <20100628113948.7778048d.akpm@linux-foundation.org>
	<AANLkTilBSjjmninq8VNxgFe2I41-b9guo5VKuiZWnAwU@mail.gmail.com>
	<20100628193334.GA1926@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55925 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab0F1Tsu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2010 15:48:50 -0400
Received: by qyk38 with SMTP id 38so1264428qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2010 12:48:49 -0700 (PDT)
In-Reply-To: <20100628193334.GA1926@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Colin Cross <ccross@android.com>, Andrew Morton <akpm@linux-foundation.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On Mon, Jun 28, 2010 at 12:33 PM, Olof Johansson <olof@lixom.net> wrote=
:
> On Mon, Jun 28, 2010 at 11:56:26AM -0700, Colin Cross wrote:
>> These patches are not coming from the tegra/for-next branch, they ar=
e
>> coming from Grant's devicetree-next branch. =A0Grant, why are these
>> patches in your tree, and why is tegra/for-next in your tree? =A0It'=
s
>> going to cause conflicts when we rebase our for-next branch. =A0Plea=
se
>> remove tegra and this sdhci patch from your tree.
>
> Yeah, this seems to be a mixup by Grant. I gave him a few patches I h=
ad
> picked up locally to work with, and he seems to have published the
> work accidentally.

Hi Colin,

I've fixed it now.  Profuse apologies, sorry for the noise, and I owe
you a beer or 3.

g.
