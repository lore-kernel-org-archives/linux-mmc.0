Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F721348
	for <linux-mmc@vger.kernel.org>; Wed, 16 Apr 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794822; cv=none; b=b52My/sDOL+FFMaeFFSGh6b9W+ABNWgcy8h/dilTY9KYmlFdAnQTBmcuKtbeCnwG28lvTsDZu2WE/54xF2Oy6sLMfNkE6sYrzCG/a5VZqGFaj0hS5obEjP2Zf96PsCg3m4eIXvL1dFVGeOHvyBrDHthlw2bMSUWonYEeOycYlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794822; c=relaxed/simple;
	bh=FKymnQ7W079EWsxIjQ3bZ1p9URNI75qppcMP561dWIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCnguPoz1WSGERgn7GsOIhRazjcB3MfX8LEV7scMdXpDYzt2+QnBQIIrKW/tjPZ73QvBJbY3NnDr92PA9C2Eqkshsrm0+VM/LWHBS+MaqZ5j/Gj7zmKHxPfu21R7r/Xdk/yTZfmPzRxCDesfCdfQ+Eys8KNO6TrJ+zFBsnLsMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E388152B;
	Wed, 16 Apr 2025 02:13:37 -0700 (PDT)
Received: from [10.57.70.193] (unknown [10.57.70.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9403F66E;
	Wed, 16 Apr 2025 02:13:37 -0700 (PDT)
Message-ID: <fb21ad0b-b45f-4636-9d74-1e758c3b2879@arm.com>
Date: Wed, 16 Apr 2025 10:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: eMMC timeout reproduction. Can I send a block of data from the
 host to the card with invalid CRC?
To: Prasad Koya <prasad@arista.com>, linux-mmc@vger.kernel.org
Cc: Baptiste Covolato <baptiste@arista.com>,
 Sushrut Shirole <sushrut@arista.com>, ulf.hansson@linaro.org
References: <CAKh1g556YvHE9eib3WJG+mBHyyr88rxYSbNUHxpFYsUHcdOoUg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKh1g556YvHE9eib3WJG+mBHyyr88rxYSbNUHxpFYsUHcdOoUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 01:13, Prasad Koya wrote:
> Hi
> 
> We use eMMC as a boot drive. At a random time, maybe a month or an
> year of uptime, we run into an issue where we see the eMMC driver
> prints this in the kernel logs and the drive no longer responds after
> that. We see this issue in the field on linux kernel 4.19.142 and
> 5.10.165. From the SDHCI register dump, it looks like CMD25 ran into a
> timeout first. After the first timeout, we see CMD12 in the second
> SDHCI register dump. Status returned by the card at that point in
> card_busy_detect() is 0xE00.
> 
> I looked at the recent commits up to 6.15 and I do not see anything
> obvious that addresses issue like below.
> 
> We are trying to reproduce the issue in our lab and understand the
> driver code. Is there a way I can send a block of data as part of
> CMD25 with invalid CRC?  Appreciate any pointers.

CRC is appended by hardware, so it will always be correct.
What you can do though is change the blocksize of the transfer on the
host side (e.g. from 512 to 514 bytes) without changing it using CMD16.
The 2 bytes will be latched in as CRC by the card. Of course you won't
see the CRC ACK from the card in that case (as it clashes with the
hardware CRC signal from the host). 
You can do all this using the ioctl interface in userspace btw.
