Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061B225A2
	for <linux-mmc@vger.kernel.org>; Mon, 20 May 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716196103; cv=none; b=Wo4JUevMrXUaD5KF58MihfFKzsxOq82CcRAiu9yOcTHR3v+FDOHfAebFZ3DC3IfMcNOYSL97IEFLfGaDtuvblf2ODjOCN8WtASz8AsJ8UX/KA1+M0uw4AqhAqtx6Jawjv8lSBRCJOwg9AZX5hq7GdLKsT9noaJZEz6aB+ir2z9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716196103; c=relaxed/simple;
	bh=7hntFWOcsPQ52NpiyXHAuXbv8mxYsSahi9WExGF/KAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oJ1KMh0r1GwKJRodOPNtiVeU0mYbbRzVRVpXGH6kH8COY4oa8aTJ5RMFT77GIpimCUT1XpN3VLBNyY4nyx9FYtsMQaBslejWrQjYzJb4Hd/VG/DGhdvmqSdiWNxSZ6/GPUA+/HlXBqxdxegyCpBGP2qcKdQ2drrLyCAsCMbcYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66BA2FEC;
	Mon, 20 May 2024 02:08:45 -0700 (PDT)
Received: from [10.57.81.9] (unknown [10.57.81.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5E373F766;
	Mon, 20 May 2024 02:08:20 -0700 (PDT)
Message-ID: <48d2e9b2-d423-43fe-a28c-47db381ea999@arm.com>
Date: Mon, 20 May 2024 10:08:19 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc-utils: implemented CMD42 locking/unlocking
To: linux-mmc@danman.eu, linux-mmc@vger.kernel.org, avri.altman@wdc.com,
 ulf.hansson@linaro.org
References: <20240519070843.467268-1-linux-mmc@danman.eu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240519070843.467268-1-linux-mmc@danman.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/24 08:08, linux-mmc@danman.eu wrote:
> ------ Tessian Warning ------
> 
> Be careful, the email's sending domain "@danman[.]eu" has never been seen on your company's network before today
> 
> This warning message will be removed if you reply to or forward this email to a recipient outside of your organization.
> 
> ---- Tessian Warning End ----
> 
> From: Daniel Kucera <linux-mmc@danman.eu>
> 
> Implemented locking/unlocking using CMD42 according to Micron
> Technical Note
> 
> original link https://media-www.micron.com/-/media/client/global/documents/products/technical-note/sd-cards/tnsd01_enable_sd_lock_unlock_in_linux.pdf?rev=03f03a6bc0f8435fafa93a8fc8e88988
> currently available at https://github.com/danielkucera/esp32-sdcard/blob/master/tnsd01_enable_sd_lock_unlock_in_linux.pdf

You explained it nicely in v1 why this feature is indeed more dangerous than a simple erase:
https://lore.kernel.org/linux-mmc/DM6PR04MB6575AC22506EDEBB7C7E9310FCE82@DM6PR04MB6575.namprd04.prod.outlook.com/T/#m4241fce85459336e2ca4d2abbcccf6d6227e9501

Locking a card will essentially brick it for all practical purposes if it is removed (or the system shuts down)
between locking and unlocking until mmcblk supports initialization of locked cards.
I'd upstream that first, I had a similar patch like you mentioned, but didn't get around to it.

