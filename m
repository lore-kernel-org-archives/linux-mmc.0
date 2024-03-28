Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813352F6F
	for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632338; cv=none; b=Cce0eLEDK3qQJHve6G/IruicGpT2SH8X4VaiG7f7n+rtAQ7QZu515iLoyTBl0pqmdt/FdHTizghF2efTApQJbSPymFdNeh5HssHd5K6Y8WvZgbcdSjWCCCE/rG6BJ6/AAWs7wEvDJORt7UX/O1Oe+cALs4vzL7EPE04BeYF50Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632338; c=relaxed/simple;
	bh=VjZ0qzupPy28bMkRtM24lJPeXcSzB+GsGth6y5l4UmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eYG303jOXIsxn+IJBpAsBK5/Tu28SUNPefMnVDMK9QwCqklWJN8goxUuPQt/tNeDsXa4FFoZvXSFUQwLjvTAfulbbHXdOqO6KZY/1EPYBBNfDtKlP4wORibdVva5yr6VHJLTY4MWJMZfbS5t9myq6JYbAPgw+PSHPvPyfszg8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B65D51476;
	Thu, 28 Mar 2024 06:26:07 -0700 (PDT)
Received: from [10.1.35.17] (e133047.arm.com [10.1.35.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B8AE3F64C;
	Thu, 28 Mar 2024 06:25:33 -0700 (PDT)
Message-ID: <0cc46baf-8924-4ca7-98f3-c8376f7a5d87@arm.com>
Date: Thu, 28 Mar 2024 13:25:31 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SD card specification and eSDHC controller
To: Patryk <pbiel7@gmail.com>, linux-mmc@vger.kernel.org
References: <CA+DkFDb7HQukpUyxVemvoH4rXxt3F3Q957EnKzasnehKfbEEzA@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CA+DkFDb7HQukpUyxVemvoH4rXxt3F3Q957EnKzasnehKfbEEzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 13:13, Patryk wrote:
> Hi,
> I've got a question regarding sd cards, their specifications, and the
> ability to support them by a host controller.
> In my eSDHC (NXP LS1028a soc) features summary I can find the following:
> - Conforms to the SD Host controller standard specification version
> 3.0, including test event register support
> - Compatible with the SD memory card specification version 3.01, and
> supports the high-capacity SD memory card
> - Compatible with the SDIO card specification version 3.0
> 
> I have found that SD cards compatible with SD card specification 4.10
> and higher support something like an extension register and in
> particular power management. I've searched through kernel code and
> found that these registers are parsed by the let's say generic part of
> sd/mmc subsystem not by the host controller driver.
> Does it mean that I can connect the SD card compatible with spec 4.10
> and expect that the sd/mmc subsystem will use power management
> features if the card supports them?
Yes. mmc core will handle it if the card supports it.
"power management features" is a bit misleading, it's
SD_EXT_POWER_OFF_NOTIFY.

> Best regards
> Patryk
> 

