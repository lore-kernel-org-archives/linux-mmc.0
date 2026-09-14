Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB644606E;
	Mon, 14 Sep 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387222; cv=none; b=Z0iBR3eRmuTnpJNsY229w43zbI6EnyNxJ99ADb8JroPehfOPqQDRrQwtepXaEhWjROZwh+VTrHwCtMywYSv2xJhm/p1kP5SdOEi9q3J/SmMX9IdJkvVPqkKltLuabKcCZdhGOqQDEcfOLBKIPQ6QadlBvwazC5zma+f5P/C6r6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387222; c=relaxed/simple;
	bh=BGMQ6EWLf/crhh4n82wLwyUvPbOkT4y82s4qttH3UHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf5Fc+bnHfQi9DKBBcQ8SBq7x5K/IxxXxBX3PMK+SRSJaFiGd/J3E8ojjqZ+bKhwKgGbKVuY8ey5Wm5wolJ2DiYPPQKfhppdVw0PmlPkQNb2IFlFNduYFiZI/7PJki78OpiAH2bDecY1PMynXv6C1xZeSk19v1LjF0ybNdXGi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qvjB6YL1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qvjB6YL1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5301F000FF;
	Mon, 14 Sep 2026 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789387202;
	bh=uB/BqueuYWDrWRp0XoRqovqXfVVBi/rfc9IrpUC09B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qvjB6YL1HB2p+5ygdrt2ftpTJxFovlf3ubbE53vmi7Qbwkda4wG0lf7AhmsWrzXUQ
	 j/IohAxFKPcdSEvG45hNoytclk3+JZBMIpc78OB81QLgkt/BoZoVxrTu3sm2bxPYl5
	 /kDRazU1oX+mGYFivUDlUqrV5wbgJkN2f3207np0=
Date: Mon, 14 Sep 2026 13:59:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] mmc: vub300: Remove the driver for the obsolete HW
Message-ID: <2026091445-blemish-lumpiness-c66b@gregkh>
References: <20260914111642.169707-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914111642.169707-1-ulf.hansson@oss.qualcomm.com>

On Mon, Sep 14, 2026 at 01:16:42PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> The Hw is obsolete since many years and its corresponding driver has not
> been actively maintained for a very long time.
> 
> In this regards we are lately receiving a lot of AI generated bug fixes as
> the driver is a real mess. Rather than continue this path, with small fixes
> instead of making a proper rework of the driver, let's just remove the
> driver altogether.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
