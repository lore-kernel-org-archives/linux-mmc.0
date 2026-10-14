Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523F371898
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010872; cv=none; b=efZdHRU/jIp9/wp8T1BkHarjksJfXHOUd+Y9vkGvTJW3hgxWVXwWkvrXXBF/MmxCaoh20C6ygTal7oQ3STtBbyChbbaFpasWgN+zDy8GFWSunxax1BQ2r7YG3t5RYXuHwwwKwqdx9O5mF9wghL77JQnlCGeymQnU1gQHB1DR1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010872; c=relaxed/simple;
	bh=d6uXW4bn83NHBXQ8a+ItYwcvTucarLHVf1vUohJOHAs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ex0Q6W0qBD84vSzlwGUdiunZSqWw0B+R6a3B5qlKEjcUxqDOY0HW2ByYLsL+VFWl90I7qse3+sTaa3k2yI38gvVmRxdn176VyLC9EgzYc4ADBa8YvwiLFfyyTMQ2AKBKAd8QDRXT+zzr75xYBPmYpon+AiY9efG9qd7a5w0nuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ror5yoLm; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ror5yoLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792010862; x=1792270062;
	bh=gMtoxkbqrfXZbPzOMMuidNvYO4EvY+7tNmvjjnXsy8M=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ror5yoLmn9wbvOG7Fly1EsNZCEcMuxKrUEOBqj+Iyboq+qmTS3qltlnM1tusmX9AC
	 5YVVObbjyZEJqXoFHkVVF4QAKxtRPo4H5SVbAeew+rpC21PegSdMOMxA+u2w3XstoB
	 nfUAnhYtFy6SZ3+ODAnLoBW3WU0aYwR7DwwuQDs6s5HCIPPlb1l8oDzWgVdM40uqVs
	 Ws6YFqx/tUjH4OHM4yJJ+QRWbbWxo4tD7BEHmkOTgtdU+oSvqUBJinKq0PhCOAg9+N
	 +Z4mPRQYeA6sKCxObuZekm4cV3EmSaOX9YMtjzFIiYsVhOpAtQS4bapRA7hvZr5GxQ
	 jp3S2Y/RS2lEQ==
Date: Wed, 14 Oct 2026 20:47:38 +0000
To: "ulfh@kernel.org" <ulfh@kernel.org>
From: wisdomwebman <wisdomwebman@proton.me>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "nyanpasu256@gmail.com" <nyanpasu256@gmail.com>
Subject: Re: rtsx_pci_sdmmc aborts suspend when /sys/power/wakeup_count is enabled
Message-ID: <MiymQuzpi87stsM7XA5bfyMV6n_W41wNq15OMA_RnicheHtlyXzpdRw6_hg8wwrkFdSclRgrh6ZqKLg1xpBSUA7cBxO6sX0eIPHg3Mx2tw0=@proton.me>
Feedback-ID: 182157067:user:proton
X-Pm-Message-ID: ede10444d167e479b8ddc0c8aa8e9ff6cb2b86d2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on this thread [1] with another affected machine, since
it looks like the fix hasn't been merged yet.

I'm seeing the same thing on an HP ProBook 450 G8 with KDE Plasma
(so wakeup_count is written before suspend). The SD slot is empty.

- Realtek RTS522A [10ec:522a] rev 01, subsystem [103c:87e1]
- HP BIOS T70 Ver. 01.22.00
- 7.2.9-arch1-1, s2idle, systemd 262, KDE Plasma 6.7.5

The first suspend after closing the lid gets aborted, and userspace
retries successfully right after. In one boot 8 suspends were aborted
(failed_suspend=3D8, last_failed_errno=3D-16), with mmc0 wakeup_count=3D8.

With pm_debug_messages=3D1:

[  165.254293] PM: suspend entry (s2idle)
[  165.625762] PM: Wakeup pending, aborting suspend
[  165.625893] PM: active wakeup source: mmc0
[  165.625900] PM: suspend of devices aborted after 178.421 msecs
[  165.626031] PM: Some devices failed to suspend, or early wake event dete=
cted
[  165.695020] PM: suspend exit
[  165.695161] PM: suspend entry (s2idle)
[  169.376798] PM: suspend-to-idle

mmc0 wakeup source afterwards: event_count=3D1, expire_count=3D1,
max_time_ms=3D5181. That's the 5 s hold from _mmc_detect_change().

As far as I can tell, current mainline rtsx_pci_runtime_resume() still
calls card_event() unconditionally, so the pm_suspend_target_state
check Adrian suggested isn't in yet.

I'm happy to test that change on this machine. I can run repeated
lid-close suspend cycles with and without the patch and report
whether the abort goes away.

[1] https://lore.kernel.org/linux-mmc/b6ddabc6-dd9c-4230-b19c-b2b1f5192635@=
intel.com/

Thanks,
WisdomWebMan

