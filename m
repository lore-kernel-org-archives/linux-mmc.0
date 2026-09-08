Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4C83815D2
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848013; cv=pass; b=rTqXSaw67//5fDroAqSpR1IwWiwd4KkwvX6W1aHVxWk/FK/7y6P8tJCLxAd+BJrMmFngXnXfzdttIhbhpzn3hYLWOGenitKiI1QrV0DlBhUo0o2UTw4yHjxyV9T+zMJBf3m0tE11uL8z4m5SvWQygii4BBE3UoqKrBYgW/vERIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848013; c=relaxed/simple;
	bh=0BDjLuYH3mpk7/XL6L6W6SmlqTXRd6/nKitMB595JPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dEOjj+PcLuxMIAT/Je0YYpUkefcqCGDtO6hQQuimLhajCQIGRFr/6eTSFG+VeZghrjBs0gX1mBGnMYlymaZW4heAH+EgHVpYESL1VqiHUOKEdlSxRaAOsPvOvkq7PG9lht3V4NfG5ETWKWuVObdDTiDCDsMtsSTlpbGsZ34tVOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsEBB/UR; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsEBB/UR"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c20e70a0962so527193566b.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 23:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788848009; cv=none;
        d=google.com; s=arc-20260327;
        b=qLJ+NWVjhlj3dyhCbAEFZsS/8zUrUbmgAt+fpfgwHflyQ2LRJaqmopZdXrDGptw2Ja
         FqGKPVmXUj3wl8/ifPgp9uuiugnXQzHfXd5IkVXhYfcil6JSfu1XXxGpknKzqd9N8PWO
         gC6q8hIblEzrc3ZKs8o39Ww0QjxjI8r7SOw6fuY7ttKxHwkZ72T+wS0dmXgNYU0FITVd
         PLnzdLWzYS/tTZHzGfQ9WC7rfdYpYfl2wOBmk1cCd2m5tClOHsc6l+DQEgTJPbOpYOaI
         O/pZhjE26UMjcpD0fXTE1q7qhhsNH6pu0qcvOL0fLreVPDe6/UdX31gLwUIObsij2vNu
         Ef1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=0BDjLuYH3mpk7/XL6L6W6SmlqTXRd6/nKitMB595JPg=;
        fh=afYsOFaMR0yqgRrpLFD5viLp5ltCyn/0TcAwau+dvy8=;
        b=S0WH92c0HWv65qByOBKR6/Ds3KJxJpZP8aK3sS+VGH/GGgeS4Z+NarkRYnlbSfRju0
         bEPbEb1cjm4lwx1RFol4W3TeEFU6fsZL6UqDRFPaIWeCAgovKbNX30nk8aB9Jb0dWp7C
         J5q614u8nyyNcOUlpgC2XF9PSZIg2dzCbIzMnj70euVF4wBSWS36RqIdAUsKG05W2XzF
         PFm+GohFqn6PBxE4Jey0XvFuwjiZ8Fl3DVaT8czaY9LcyKOeme8yvHsZQ1QAMWxyy9m0
         FzeJyJKxYq+ngqU+QfddKToHb/jzlAWmP1RbPcOjfT0CneryZW6IyGs9bmuMVfMQjL0C
         xm4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788848009; x=1789452809; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BDjLuYH3mpk7/XL6L6W6SmlqTXRd6/nKitMB595JPg=;
        b=lsEBB/UR06yuTuMjXAT2+rSn0GPvRo6qsLBAGRsMWi2h6tJuPs0uHb/+CHA2pfF2b8
         O034vyZMeWdRDO0ScjncdJc9T2SxlJG8CWx+P7kocg7HP96Ic6V+J7UAHh8rlX0F1zhV
         hs8AJaWkMtLMy7TVRx5ubrQuv1j44kuRnkG7TszglumJ6lmKINbPJI4ry4mHxPIbIsIp
         W3ZuC9bQ4ALOYVtFR37HkSPPbaHRj0cjyRm54M3kSWlVbV/0PbjBg0EcSqk6mjHWsr1e
         9A7dh7kFxEdtf46SEtlKXk8Et088Upxj9tpj8oI5Mna+mIHga6xeiE10sh2w0T4gX9ID
         ikGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848009; x=1789452809;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BDjLuYH3mpk7/XL6L6W6SmlqTXRd6/nKitMB595JPg=;
        b=HY2lOtWIzvHWp0nYzjoR9An0T8zZCXQM1GdG3AOWFeJ+u6mK7s+LcDeOYNUgZ1UrML
         u8RYk3GrkIUmAOtTb6yigvmQ5/nzNoOJAp4ud1+EVOcK6N3feQWM8T7q6u9KOiKAJGZj
         uR1Wh8/aLwYFM/AowM72d73uKX2vvNxEl9ANFX7R30Kfq9DnWX4cbMFR1+oXUdRFr7PD
         mLDrQWH++fJUtl0Q7VFTkenSgv1DY2cpCnkhLwhoGr85TaXYmpd4EIEHldx9M7mhjXfX
         2wdlF66XT4Od/cif+2ZlvbziOhNksC8q5g9niRBHWBlNY54rtJN3EwrWXnNuH9v11ezZ
         m20Q==
X-Gm-Message-State: AFuF++lg8T2cOxjtfG8NT6JIxHCaLaGrmBik5VZhrQnYl+waxzT5thcC
	/6+rhLWogpaVhp0FNQur8GrOjA/8c1PI17FIRYLk8v/OhL3l1Yq85EEg05+0QMMgcOAolZAaQIz
	rwI0Q49lH9tOQHqfAjYZSPpWROpL9jszsobsX
X-Gm-Gg: AYBFou1GFo+fgOvcOlvE4LLVF7biBsnYFBDxwVsCkBMngeTmPPo6S5P2tabJvjdwjX3
	NqrVrN38bw3nA3oYQveCvfMEmnCgWQKoVoZhid9ldlHFC9cL6jxrOYCXHCyda2oTDCO8jCYYjKb
	c36Sixw5k7OmGVHKoDA+74W886BGp475QvZazPf2Oi9qT7ij0cm2XykjhGjtGjzVSzv5Ct6avFm
	rdqfSoNh4fROJVKmZkmKaSkGB7pHvtzut+Cx4kegq951KQV20zZMKAjDG7EtaWxidBHWc5b4zRB
	spLsjHHMJItr/Ird6pia6YFzdRVEWbgkUeI7Zq/JymTCK+M=
X-Received: by 2002:a17:907:6ea2:b0:c25:8bcb:ea0b with SMTP id
 a640c23a62f3a-c260c6a0e93mr1778015766b.4.1788848009144; Mon, 07 Sep 2026
 23:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1788847891-21549-mlmmj-54c85767@vger.kernel.org>
In-Reply-To: <1788847891-21549-mlmmj-54c85767@vger.kernel.org>
From: Pintu Kumar Agarwal <pintu.ping@gmail.com>
Date: Tue, 8 Sep 2026 11:43:16 +0530
X-Gm-Features: AcwNN1Vuxya8lFHVEiYpSdP9mzxhcDq2Y16gVa653TadMCuw_qXOQusF7KYq6hQ
Message-ID: <CAOuPNLhWNfaVzzLhb+rNecLu1sZanQMNnnqHwX1iEA5MhPVOwg@mail.gmail.com>
Subject: unsubscribe
To: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unsubscribe

On Tue, 8 Sept 2026 at 11:42, <linux-mmc+owner@vger.kernel.org> wrote:
>
> Greetings!
>
> This is the mlmmj program managing the <linux-mmc@vger.kernel.org> mailing
> list.
>
> Your message to <linux-mmc@vger.kernel.org> was not delivered to the list
> because it contained a HTML part. Only text/plain messages are allowed on
> this list.
>
> Please configure your mail client to only send plain text mail.
>
> For your reference, the rejected message follows below.
>
>
>
> ---------- Forwarded message ----------
> From: Pintu Kumar Agarwal <pintu.ping@gmail.com>
> To: linux-mmc@vger.kernel.org
> Cc:
> Bcc:
> Date: Tue, 8 Sep 2026 11:41:16 +0530
> Subject: unsubscribe
> unsubscribe
>
> On Mon, 7 Sept 2026 at 18:22, <linux-mmc+owner@vger.kernel.org> wrote:
>>
>> Greetings!
>>
>> This is the mlmmj program managing the <linux-mmc@vger.kernel.org> mailing
>> list.
>>
>> Your mail host rejected some of the messages we tried to deliver.
>> This usually happens if we have accepted a spam message, but your mail
>> server refused to take it from us (because it's spam).
>>
>> This automated probe is just a test to make sure that there are no other
>> problems with mail delivery to your account. No action is required on
>> your part -- if you are seeing this message, that means everything is
>> normal.
>>
>> (In fact, you can add "Subject: Bounce probe" to your filters to avoid
>> seeing this message in the future.)
>>
>> For internal tracking purposes, here is the list of bounced messages:
>> - 13144
>>
