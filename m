Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC14683
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652173; cv=none; b=X1rDDZfpDRYdYpMNsqqa5Y+6m2NBsYdywP7ILYF2DKGrRLu9BktXTNu4qS6YxA9ELf+6QVXrOSLjykHPXWPDIiVvqk1uzyzNUa8sAh63zzPQH5AddpK9nGdNsZdyOmmxvIknvQYJZlTNy+dKZbhuOZHKM7ug2NLj2n536qqLoq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652173; c=relaxed/simple;
	bh=NAksTplgP+1kB7z27r4ZG8oA+BXm0kdONRWxuNIl+u0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I3uHlw2Fv8wKAdiGUq2+RkuxPH4/YeiKTbnIoAD/sZ3YbQvr+SpZjs7Rj9sYgxXGbzzekCxgNIeUNNc41x9VxkC/nDtXlFXtmY292v+ktUwLK0h9TmqwBk3ZOA1MW9lbWJ18+KjarzkjSuXcyai91eZ0UUQw+5RVLHDcl8tYGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1iqjvc9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1iqjvc9"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a458b6d9cfeso199081966b.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 07:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709652170; x=1710256970; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NAksTplgP+1kB7z27r4ZG8oA+BXm0kdONRWxuNIl+u0=;
        b=C1iqjvc9ZNWvKK+NAdg2FBvtcAZBVP1HVEr7kPNeT1NCVMeHkmn3X6dcd9XGh+3jgK
         WDcA3tgCZ3s5B2cHjpi02vVr19Z5VvYopoLlBNDYYPh+lt5QzMuhhECzI9ImkKTiRG2M
         9I1bxlho3hW7aI2P1NHY+9EX/xd/AlpACEqzzrpNOLTkLH/XZ1UTQXwnPfcxLRfD/eA4
         bAmnrhhsyuEf9dCewm2fVXoU7QHsJwPUrbc4AvoYJrIB74EiujWncLsHUkf1ofQ1ivIk
         SRBcNdQnMD4MIH0g0NE+K5X+FZ8c07r9fcaEDqGJWZpaW0MY7A0tEiI706iekwVJcchw
         w3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652170; x=1710256970;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAksTplgP+1kB7z27r4ZG8oA+BXm0kdONRWxuNIl+u0=;
        b=jluj/RTsWjkLcbeTFeDdQSsJ6wDLckLpmb/4Chto14PUFT2UNGtrZZ33ykPg3+OIVU
         rHhCylxdw8rc7ikCXDxZ8W40kAiuDhWidK8VMvyAkyfSUCzELQvVYCbDCTaXvKoc0acO
         5ZLDdRgu7zlTSr4pJZ0tfKhXKXsTx/dCPJLauR0nf5bEfDvwkH3gOFVKcdJ/V30Kj/U6
         q1DPx2QRXMTeZcrliYirzO5ijFKcI5fJ8NpamQcglTzENdaXTGSaF9RUReiVWpmZusDD
         Mk5ujmXWIgkwq9xWhP+o3m8GQCA/RcJkUG+nTzZ1cLUJjfu0al5UFxz/WoyPmZA9Tikh
         kAgw==
X-Gm-Message-State: AOJu0YzWED5vc25kjuq1mGEVrbGRk8hJvvBCjRKjzzMtzwBznvHKZK5U
	m/bPWkGF8CvVyIHh30AWDOqVQtXgLA2y0UvJvqhT0dMv/MlI+YuxTWCy8ygsQrkjSjqTDOcANuN
	fPOU9Tck6L85fimY52oiayiX9d6dnL35RqQbTDw==
X-Google-Smtp-Source: AGHT+IGEhUzdxIT/Pkpfwt1/LtJhyxV2HBqUEH1waEbqlfffzqfgBsliBto5A9U6ePzQTTcPk5BhhugmObxFdU3VmQY=
X-Received: by 2002:a17:906:3d3:b0:a3d:482f:3fc4 with SMTP id
 c19-20020a17090603d300b00a3d482f3fc4mr7702999eja.70.1709652170000; Tue, 05
 Mar 2024 07:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Tue, 5 Mar 2024 16:22:37 +0100
Message-ID: <CA+DkFDZbYvL9ecEtbpkj=HLMuPC=5QuQHgM8fi_WH2Qu-taDOg@mail.gmail.com>
Subject: Question regarding informing MMC subsystem about upcoming power loss.
To: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I'm wondering - is there a way/interface that I could use to notify
the Linux kernel that the power is about to go down? I'm thinking
about SD cards in particular and how to make them more immune to
unexpected power loss, and I've found that some SD cards support
something like "mmc_poweroff_notify", which is called in the
mmc_suspend function.

Assuming that I have the information about upcoming power loss
(provided by e.g. external interrupt, PSU voltage monitoring etc) how
should I pass this information to the Kernel so that it will try to
clean up resources - in particular MMC subsystem?

Let me show some background - we have a SoM which has a lot of
components. On the SoM we have a PSU which operates on 24V voltage. We
would like to monitor the PSU's voltage and when we detect that the
voltage has dropped from 24V to 12V this is highly likely an
unexpected power loss/cut, therefore we would like to inform the
Kernel (in particular mmc subsystem) that the power loss is coming. I
can imagine something like this - we have a driver that does voltage
measurements or waits for an external interrupt (triggered when PSU's
voltage drops from 24V to 12V) and then calls some functions that will
allow the Kernel to do some cleanups, but the question is what are
these functions? Are there any?

BR
Patryk
