Received: from speedy.danman.eu (speedy.danman.eu [46.227.180.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7917740
	for <linux-mmc@vger.kernel.org>; Tue, 21 May 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.180.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277554; cv=none; b=s6PJ4of/AlIGmdZO9Qh7/rd5Ud6e1eEBZZFdlNPUPtBbCUA0nbTsUp/wUEXgV7NtDuE/NJYeMWrbgOFYhv1qDH+KkMqdlx31SZ1Dc9M1mG5kYdTpJ0b2pS2nPolguRrT64q2BNgzBDuXYk9qntxgOVcN7QmaGY8xn3LNGyK3VG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277554; c=relaxed/simple;
	bh=QbmUIn5Z3O1aeoWPKubvlaDVS+g1Ajcgk4veMn0bDs0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nNr7dLmEABwJNkw0Vv9dpl6DPqOpZrv4DVY5zVghJVUjpz9sRbjVx3FC1ibVt6BWdS75vPTEZTms2EVTuwiMcHVi6PxegNcOpqKdh2cl/WxJUoy1D2q+dV2b2aRWuHRXsppmoAaw1KhMnyJ8ux4rQWripBTpt6dGt/edOGtKXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu; spf=pass smtp.mailfrom=danman.eu; arc=none smtp.client-ip=46.227.180.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danman.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danman.eu
Received: from mail.danman.eu (localhost [IPv6:::1])
	by speedy.danman.eu (Postfix) with ESMTPA id 451682402B6;
	Tue, 21 May 2024 09:45:42 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 May 2024 09:45:42 +0200
From: Daniel Kucera <linux-mmc@danman.eu>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-mmc@vger.kernel.org, avri.altman@wdc.com, ulf.hansson@linaro.org
Subject: Re: [PATCH] mmc-utils: implemented CMD42 locking/unlocking
In-Reply-To: <48d2e9b2-d423-43fe-a28c-47db381ea999@arm.com>
References: <20240519070843.467268-1-linux-mmc@danman.eu>
 <48d2e9b2-d423-43fe-a28c-47db381ea999@arm.com>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <6091a9d09371148462a901ed04a36f0b@danman.eu>
X-Sender: linux-mmc@danman.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-20 11:08, Christian Loehle wrote:
> On 5/19/24 08:08, linux-mmc@danman.eu wrote:
>> ------ Tessian Warning ------
>> 
>> Be careful, the email's sending domain "@danman[.]eu" has never been 
>> seen on your company's network before today
>> 
>> This warning message will be removed if you reply to or forward this 
>> email to a recipient outside of your organization.
>> 
>> ---- Tessian Warning End ----
>> 
>> From: Daniel Kucera <linux-mmc@danman.eu>
>> 
>> Implemented locking/unlocking using CMD42 according to Micron
>> Technical Note
>> 
>> original link 
>> https://media-www.micron.com/-/media/client/global/documents/products/technical-note/sd-cards/tnsd01_enable_sd_lock_unlock_in_linux.pdf?rev=03f03a6bc0f8435fafa93a8fc8e88988
>> currently available at 
>> https://github.com/danielkucera/esp32-sdcard/blob/master/tnsd01_enable_sd_lock_unlock_in_linux.pdf
> 
> You explained it nicely in v1 why this feature is indeed more
> dangerous than a simple erase:
> https://lore.kernel.org/linux-mmc/DM6PR04MB6575AC22506EDEBB7C7E9310FCE82@DM6PR04MB6575.namprd04.prod.outlook.com/T/#m4241fce85459336e2ca4d2abbcccf6d6227e9501
> 
> Locking a card will essentially brick it for all practical purposes if
> it is removed (or the system shuts down)
> between locking and unlocking until mmcblk supports initialization of
> locked cards.
> I'd upstream that first, I had a similar patch like you mentioned, but
> didn't get around to it.

I think this is a chicken-egg problem:
If you don't have the tools to lock you cannot test correct detection 
with kernel.
If you don't have kernel supporting locked cards you cannot unlock (but 
can lock).

Regarding the potential damage: what can cause a bigger damage? Loosing 
data or loosing the medium?

But anyway, I will prepare the kernel patch shortly.

D.
