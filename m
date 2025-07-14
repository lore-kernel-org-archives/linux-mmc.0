Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8031FBE87
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487733; cv=none; b=DwxL2kP/PyvdzNo6pI2E7nfLWguqBe4x8RLZW4ON/gPH32yXBTypoG2zD5v2vGhI0uErbukNzhZvLBP+KC5RzOZZUfKWiu52/SURoOvK6F3RW+k6IQF/lL/x4h65ThaL7djq8SVhHSHamAeyQIdFsm4ratVEy7kKUk1pAxiNoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487733; c=relaxed/simple;
	bh=BBXs8h7wB+OoJhdeosL1lBJzwnpqBBjYiKb90jottgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4YhWa3GOG1x3FaiAcpW4me3cbp/pm4eUFczXQSygo3HuvJsd+sUpMuLgOnZ6D608WILfTIPcvlOtxDrtb2pHUHxd+CTvnyaPIV9FlbQBTWuFqfcf3FvLuf83RACRdVsDs/PYe8t/nZrsv8l/5SFPjeaQZicntuC4dOXVqnw1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUGvHr+t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUGvHr+t"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso7842015a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Jul 2025 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752487730; x=1753092530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBXs8h7wB+OoJhdeosL1lBJzwnpqBBjYiKb90jottgI=;
        b=GUGvHr+tJdvi51hNcWaz7yUqcsrHFU866n1Sw632fS0Zsdj78YXYgQ3OI7pFKw4yHI
         ZgxyfiWmLSpVaKoTH0KjIIRS8pqDlqfnYdunIJxNjuEftmMHhnQz3Y0bSuOEsSQBXVVc
         h+fhIaSL/mhxZXv/sYaGRrJdiGW9Fl05ok2/4WLwWZo32ww0X2yMiECLMpIP0flOeQRC
         4SNwKPUlNOPFzVRaqiw1Fz7rQvJCSS7Pwo4ejxKAuWftI9N/PgEH+osJ0fP9RMGnzRHt
         QpfrviMGacrMsjOF9Yg3X7v5ho+GhGTsZfU076lBnVeQWLQky4Y+Prhs5JRAicjLvj9r
         F1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752487730; x=1753092530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBXs8h7wB+OoJhdeosL1lBJzwnpqBBjYiKb90jottgI=;
        b=YG76+P0glQlrQdAotMhjSMqMiNvulg+PUPsPJ9x+pAuI+3bFXZUscog2KqJ1FgzEVc
         u5/nKZIZgHYL3NMSKrNVev2FJ/3cGkuV7LobpyfTRRFctaUj0slRLIUjPeuLpt2Efveu
         Ye0UWhw+qwIVcSLb4dAlF2kiI0mZANwK8KWzDgcl5/psssbeuH2spQHjdNasF9MINmC+
         bEYKnRYGg4Wh0edMy0CeMQf4RNKYQwh3ODi7jFyXzuHfEZGsfbrX9mUBcLV/oM1N7QiU
         vGHHxzxRdb+jkEdkXbVei281rp/2N8LcSIeJ8JmpKPpAt1J7mK8S7WwDzUixwNSb9oaO
         MYMg==
X-Forwarded-Encrypted: i=1; AJvYcCUGqhjuKjdCTbfr24fNE/WdHpHFYy8e3xRTNsIPOUC2P7TDpkHb+VmZutWfrMnWjoCAaVw6BTT27jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VttNTgSnfAXrkGUpVMXUXL7rmZZFm+KNy/YBUsG8Ojqlq89L
	HrLuexMn6RgH86TwOqNQyf1+eOS7hKUNA0zbCROCYxDdR2NfGM8ZUFVxF7/OHnb8
X-Gm-Gg: ASbGncsGGWRpgfOW8A2zgeETXUNjYoWSGuw7FqwJNdmfo799L64ah1TXbuB3ub8Za1M
	pMSPgYi1eWCBJGRKN/cVhwBigd8S1IhpHt2AsBYt++kr0gjlfp1rSIZ8UnHNiTyqZbws1WNdBMk
	KRgezPDWvs+ZvNKmRkXXjkbLSkpSMSrDdTbk0ZPp31rsZB9USrifGhYU5TY6y8nPwpXvx43hZgI
	Jn0Y5O2yYv0r0eWIr8s8jkxmTd/spzsqyqOhVTSfzilRIpJiZDOJiIldheif+a6pZO4iZ+rbjY2
	i3TgS9gmgzIIejBdJ7W5jQ8+9GE2N6rI01tf4SSCpr/vWbdvvGTh8facaJ1BDjyuUs8AFcSQHQT
	DxGPUnT9E3EyyvUilU7kqdxZ2
X-Google-Smtp-Source: AGHT+IGlsKhhgurVEdxfRVc0K+ikUnG2fYjLgAjsmLHMug1MgW0fF+8cYDtnGfUC4P/htTaijaFyiQ==
X-Received: by 2002:a05:6402:13d4:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-611e760ff6cmr11134557a12.5.1752487729952;
        Mon, 14 Jul 2025 03:08:49 -0700 (PDT)
Received: from [10.176.234.34] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c952b753sm5839811a12.31.2025.07.14.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:08:49 -0700 (PDT)
Message-ID: <5e1aecc584af765115ee707922aa011acda44e94.camel@gmail.com>
Subject: Re: [PATCH v2] mmc-utils: add ability to flush optional eMMC cache
From: Bean Huo <huobean@gmail.com>
To: Michele Dionisio <michele.dionisio@gmail.com>, Ulf Hansson
	 <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Avri Altman <Avri.Altman@sandisk.com>
Date: Mon, 14 Jul 2025 12:08:48 +0200
In-Reply-To: <20250714064807.1915470-1-michele.dionisio@gmail.com>
References: <20250714064807.1915470-1-michele.dionisio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 08:48 +0200, Michele Dionisio wrote:
> The MMC 5.0 instroduce command to flush cache. This feature can be use on
> embedded device there power is not stable.
>=20
>=20
> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
