Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76313D24D;
	Thu,  5 Jun 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128615; cv=none; b=Gzd7SzZKSAoWwcWjXBM0DVBUndruRdN0KPxHzSZ3HfkQdx6K/9EfpaBT89BXd1CIIsZ+KPq5B0uAQEj/RDpcN523i1ONJaDyXpgrkQjJV5sp1BkEoPXsweYjajqkHEN3qx/Bao0jWHo1Tnde2ivdVDOnSqzEkdsWCoygxZbkeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128615; c=relaxed/simple;
	bh=5+namEfMQIGPYgmHxqTNqELm22XPrHRhndFiys8WzEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWC14o+nuSZ+ACWt7H8f+AtOPJabdSsLBWSozss/w3VtuAoaM1H0oBkKJCCZRcQOCpoer5qMYoWmFy2/DjRVVS000SYEDfqXNl5M5VXtfhzyN3MIkJ+ZMZrONKto8jT0mlAUFU9r0BBXVH8EKALt+U1g/QwyGEFXlAadbuEqaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVk8lrP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVk8lrP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C836C4CEE7;
	Thu,  5 Jun 2025 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749128613;
	bh=5+namEfMQIGPYgmHxqTNqELm22XPrHRhndFiys8WzEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVk8lrP6Tnl/DfcbWfV7fHloYVRc9fE0uVQHvqBEu1ZfHg86NKTKpSQH283CveosV
	 368XEv/a0UurV1WBbOvm8x6kEWIjG/WKB9DFFv+L7R9LO/fYw/CsOstz/oohf6Gxwk
	 0uw9VKOZfrTUDOfwW4vgux+B07D4hu8EAK3tXTupVK5VuP82L2d5JacJizjYVJk2Xo
	 kkQ4LlYlFqUSW9Ioa+JelbqK81vc0Hn6PxqEzLhHpYqureRbKB57jjteRFiHWz+6xR
	 iOazyAumKPp2ykgLLMWdPHen9izS6rfGTk7dTOVi3Xqj3q2d72kyAWalW2oyIN+dKc
	 3lp6zMB1Hl7kQ==
Date: Thu, 5 Jun 2025 08:03:31 -0500
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdhci: Make interrupt optional
Message-ID: <20250605130331.GA2370690-robh@kernel.org>
References: <a527f5adffc6efe4c1ad2ccc40e1e095d73efe74.1749027112.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a527f5adffc6efe4c1ad2ccc40e1e095d73efe74.1749027112.git.michal.simek@amd.com>

On Wed, Jun 04, 2025 at 10:51:54AM +0200, Michal Simek wrote:
> Bootloader (as U-Boot) is not using interrupt which doesn't need to be even
> described in DT that's why make interrupt optional property.

That's true for 'interrupts' everywhere. It could also be true for 
clocks, resets, etc. If the h/w always has the resource, it should be 
required in DT.

Rob
