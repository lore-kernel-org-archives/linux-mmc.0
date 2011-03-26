From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] tegra/mmc: add pm_flags
Date: Fri, 25 Mar 2011 17:38:40 -0700
Message-ID: <BANLkTimyxA0iT9c7gAkoDVSNUWM+Jz_OyA@mail.gmail.com>
References: <20110326000712.DD5D3208182@grundler.mtv.corp.google.com>
	<m3wrjmk9pk.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:55122 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122Ab1CZAip (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 20:38:45 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p2Q0chmN009816
	for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2011 17:38:43 -0700
Received: from ewy1 (ewy1.prod.google.com [10.241.103.1])
	by wpaz37.hot.corp.google.com with ESMTP id p2Q0cf43022615
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2011 17:38:41 -0700
Received: by ewy1 with SMTP id 1so739575ewy.13
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2011 17:38:40 -0700 (PDT)
In-Reply-To: <m3wrjmk9pk.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Grant Grundler <grundler@google.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, linux-tegra@vger.kernel.org, linux-mmc@vger.kernel.org, grundler@chromium.org, vrao@broadcom.com

On Fri, Mar 25, 2011 at 5:27 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Mar 25 2011, Grant Grundler wrote:
>> Enable fast bcm4329 WIFI suspend/resume on Tegra2 board.
>>
>> This part allows the mach-tegra support tell the tegra MMC host controller
>> to NOT turn off power for the MMC controller the WIFI part lives behind.
>> Thus bcm4329 firmware doesn't need to be reloaded.
>>
>> Signed-off-by: Venkat Rao <vrao@broadcom>
>> Tested-by: Grant Grundler <grundler@chromium.org>
>> Reviewed-by: Olof Johansson <olofj@chromium.org>
>> ----
>> I'm not certain if this should go through tegra or mmc tree.
>> Can you advise please?
>
> I'm happy to take it through the MMC tree for .40, but would like
> an Acked-by: from an arch/arm/mach-tegra maintainer to show Linus.
> Olof is one such person, so getting an Acked-by from him would work.
>
> (Also, Venkat's e-mail address is malformed in the S-o-b.)

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
