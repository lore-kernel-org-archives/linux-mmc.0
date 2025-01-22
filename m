Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD3214801
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560706; cv=none; b=lfU9ZmrFze11P4Oe4mkitIpVzxDIJdKf/ew7ff2pfICmjSqP8LuX4hyjpUb2mW29IGb3oQ9HOqESPMTv7tF+1//cA3jMZzRhGfTtYjg12S9Ss+2xfhTRbIHnsOpa0jQBU2mJuv7s59G1bztuI3IscfAFTi53Wg/SzoaQw6Lh1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560706; c=relaxed/simple;
	bh=+KnPpdq96DrOO9oKKY1OtszDJMciyjk01xiiDYEfTg0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=hfm4vrW/xSFukTGt7jU8Q3CWUim+O7yF9jVB7mYKzRnLttnCy3w1WPaLvTpDeE90Sa6maHC9YrloDjfCtMJffnJxHf8xVaFMtIxLa27jfcfPilt56Osp5BEkFNl1St472kb2ryOSH68PzTKjrPcLKTk2YFYFpMwTjO3vk58mgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuwZ0DUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuwZ0DUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406C7C4CED2;
	Wed, 22 Jan 2025 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560706;
	bh=+KnPpdq96DrOO9oKKY1OtszDJMciyjk01xiiDYEfTg0=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=tuwZ0DUy2tryO9Iq1PYdRVHilnQdx0KWI1PrHVJ1dYx5zm9gy7a61vOtV0rylKJKp
	 ApJo08r1S4RkSJ95nOTfKoplahnMXE4YynTQAgVNlJ1APaetWHdlfeXI1BtQRqCDBw
	 MmcMFwEWYr+PUGhvDNnJg/NWSsdmdE7ZKYWSk7EwJ7IqUG5KRFCkG+LZ9iOiysixdS
	 KYkqH/kPyRDsHO31lYtjQ0kpqC0/ZuLqjnlYPLeH/LtPiRFVVqE46IBC1Vjn42nrAU
	 IaOTLqpfA1HC2HKqMl40xIpF+tZmHZWiO/g3Ync/H/4+TIbIjWdbYRjgHiCElph6it
	 fdOFzY2cazj/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB313380AA62;
	Wed, 22 Jan 2025 15:45:31 +0000 (UTC)
From: josiahspore via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:16 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c10-911b1fdef5c8@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

josiahspore writes via Kernel.org Bugzilla:

Did a git bisect and found the culprit.

bede03a579b3b4a036003c4862cc1baa4ddc351f is the first bad commit
commit bede03a579b3b4a036003c4862cc1baa4ddc351f
Author: RickyWu <ricky_wu@realtek.com>
Date:   Tue Feb 19 20:49:58 2019 +0800

    misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260
    
    this enables and adds OCP function for Realtek A series cardreader chips
    and fixes some OCP flow in rts5260.c
    
    Signed-off-by: RickyWu <ricky_wu@realtek.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 65bfdc473b7b85cb423ff528309fc92d73eae5b4 1292d8564f678027d0e5c77550e37d696b134b28 M	drivers

Just revert that and you'll be golden.

rts522a,rts524a,rts525a,rts5260
So somehow OCP got enabled for rts5229 unless a means rts522x. I guess they need to make sure its not enabled for 5229.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c10
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

