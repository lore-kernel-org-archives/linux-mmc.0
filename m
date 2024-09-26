Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2026AD3;
	Thu, 26 Sep 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364723; cv=none; b=HaoC1vt06DUwuaCNXXmYRN97sDU5ewA9+GDj/GQNQWRKV13hEFVSkQNy7M8J0TcgdUePNzYcAn/STFqyodPlsZYG6/kE5ItiZKKkXS6beKd3JjGiPjfuP6nDUAuRC9gL341N2bk1MKF+16/s42TRt2abABdFPzH4k6DTyo3OKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364723; c=relaxed/simple;
	bh=ElQI735mmSW/cb2a57ES5/GLkNMwZurWVJDC/EHiA/E=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mu/mIwUS+AM1fpf2tyfVHtxKKji8WJdyhV0fHnmf3nUEVeE+9lcTAz9uE6SzdJrIQmhc8uoL6KYgDQTKvpM2vIpd7K1FscfMGYiBG3jnckZCc9ozatUtFYs+CkIYzTS7yNsLae9c8zmbRdXV0W2VbjIHnnx/GcoddCjTVxCv2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=c23tO8aD; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="c23tO8aD"
Received: from [192.168.178.76] (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 32F3C2FC004A;
	Thu, 26 Sep 2024 17:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1727364712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6PGKOprAPhoSd4R3DZyQL+gtBIZBj4rbnu5yfritEW8=;
	b=c23tO8aDBI/ZJPU/Zgv+tkf03Azm6mpz1K1YD7lBhPAWqjmML4+joF51J3VU/A/KgtNvrQ
	e1OogNy8ht2XtpGdacvR6uMjRREaEzzgCDOr5TCT2Mu0+eL0W841BEEWYQb0it+iF0Yv5b
	tJN60EI+Mj/yeSqn37WsFhSr5yHhcxo=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <8235497b-421c-4af7-90e4-95ad4e271ead@tuxedocomputers.com>
Date: Thu, 26 Sep 2024 17:31:48 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: victor.shih@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw,
 adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Georg Gottleuber <ggo@tuxedocomputers.com>
Subject: sdhci_pci module is blocking low power s0ix sleep with GL9767
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have a problem with s0ix sleep on a laptop with GL9767 SD card reader.

The device is a TUXEDO InfinityBook Pro 14 Gen9 Intel laptop and 
consumes 6 watts in s2idle (not reaching s0ix). If I blacklist sdhci_pci 
in /etc/modprobe.d/blacklist.conf then the device sleeps with 1.2 watts 
(this is not super good, but OK). Unfortunately unloading and reloading 
does not work either. Once the module has been loaded, the high power 
consumption remains, even after a rmmod.

I tested this behavior with linux mainline 6.11, 
6.11.0-rc7-next-20240909. Kernel mmc/next does not work either.

In an AMD device (InfinityBook Pro 14 Gen9 AMD), however, the same card 
reader sleeps without any problems.

Link https://bugzilla.kernel.org/show_bug.cgi?id=219284

Any ideas?

Kind regards
Georg Gottleuber
