Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A2148856
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034431; cv=none; b=O32o2bEIJfluOtFKU+wgTIwL9DBd5dWiuEV8nS0VYdcLLhJ1qlAP8CjR7gkEoF8I1E0GOXQ5wnWfkVMw8xG1+2KN2K+6A7FSyaXs5MuHnnXGYjbX83RKiiNM+B4+iEzh0uvsGZrNNY3j1Z//UAFkYwEvQ6q/h8H6aUs9XuGQXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034431; c=relaxed/simple;
	bh=TrFu3NvMXipif0qVsury65zj1fyys32TbrJawi/qAkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B19sGtOKowl4Of+as7keeUZcgvfYro1nn+MxdMzlMSCcfUVZF+J6tHq1quAzmN6vy0dZpXe5o/CfAlFfu86ELuTZFQrKHs/XDhd/rS0crxZ1sCVIpLy1jboQ91aY9OHx3IPG7nnjaPNaJf8GWrN0VB0Y5Pp4GyPee2IC6Iz5CIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2Ngdcvb; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2Ngdcvb"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e25c5ed057dso1817097276.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2024 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728034427; x=1728639227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J1D/LWfXxv6m9ipV6uG0fmVLIuIwojDCExU8vAnBDsU=;
        b=w2NgdcvbkiykFOCmXvUOu46BDSwKPnspaTpEUevPBgVzAPN+UW8susdpRDUeeMLvxj
         LbC68S0j2sVzhy0yhDBjJXe59VEpFu7sIQNEu6y/L0MHlApDh3KDGZM9tSCnb3lnVDU8
         mombti4MioPcAEEes5oO3+EoG87FJAkNicvRQ6kYISwZAWKU+yM5oIuxA15Deuxe0Be5
         wMyRL5dHqHU1tLjlqXsgMy4A0Co1STBcEmp4YZJ9LI6Q+OaPbNG2hB7A0cQnxDy1wNci
         ilzg9OzrQ6SBFRnVzL7hp3hOZPfi4Dzkw1uMJIUPekaJrBO41GExG1LaqXDmzX2sUgSH
         GNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728034427; x=1728639227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1D/LWfXxv6m9ipV6uG0fmVLIuIwojDCExU8vAnBDsU=;
        b=pK6kvhP1RU2E0Fyop0U4LU7TNIaH67soYwwNXqEJJ9u2TN2AX0bdWxRnarYZ8q5WSD
         VhMpatPovMG57+IT7cBr5BRwPW3uPvq0t0r8pg3i64aRiO1hHgMIRCux18OmNiISc1ap
         WkydOhjTHoTRdQ0AgUECVt9X25yeufRBstYJZS3b4ACY0YnrSXaMrfrewLCgpfoMv28+
         gE9BiCQXgnrUzgzSEJFIELS20hr+URKmwZSVfSUscdtDLp6dqvQINuER+cqVrpazYgl5
         n475oMk4vDCOg8pCk/0cplo2XgzePWts4I8c3FfwLL/n47XV7Cfre3dnfcYBc381Csxk
         NvZw==
X-Gm-Message-State: AOJu0YzdMme2Al7swaHD+ERHMmpz1305OOq7yEzpvcf9Iu6YDUwD6qNp
	96jCPKRKMYmmC33Tj7wh/7/mXWOkzHuEHIKbDVpkIAuYwOdunv1DW4k1ly7B1vizZQq9nenRQv7
	X823T5K3BDVJtVSn8lTX5PN5jJ8J+82Zi9NX05w==
X-Google-Smtp-Source: AGHT+IECkhQ6FiCGpVW58PzjXdc31WQOkGcQQ5BYWvxbbZsL1MzRD1/Jf40yF5auu9itUH9RXxBkQiKk0skD0ZZqVi8=
X-Received: by 2002:a05:6902:140f:b0:e25:fc6f:9cc0 with SMTP id
 3f1490d57ef6-e28936c82aemr1299778276.9.1728034427629; Fri, 04 Oct 2024
 02:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <20240908102018.3711527-3-avri.altman@wdc.com>
 <CAPDyKFpZJQ7kGngaUmLfgyKNwhVjjGEuDw96kFBY3s6hXaEJTw@mail.gmail.com> <DM6PR04MB65755F48D1F6A263584F802BFC712@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65755F48D1F6A263584F802BFC712@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Oct 2024 11:33:11 +0200
Message-ID: <CAPDyKFpebDAFKDsNYmLDbKDEvmi1oLXRb7LD1b1D1taHnRA7SQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] mmc: sd: Add Extension memory addressing
To: Avri Altman <Avri.Altman@wdc.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 18:31, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > > +int mmc_send_ext_addr(struct mmc_host *host, u32 addr) {
> > > +       struct mmc_command cmd = {
> > > +               .opcode = SD_ADDR_EXT,
> > > +               .arg = addr,
> > > +               .flags = MMC_RSP_R1 | MMC_CMD_AC,
> > > +       };
> > > +
> > > +       if (!mmc_card_ult_capacity(host->card))
> > > +               return 0;
> > > +
> > > +       return mmc_wait_for_cmd(host, &cmd, 0); }
> > > +EXPORT_SYMBOL_GPL(mmc_send_ext_addr);
> >
> > This doesn't need to be exported as it's only used by the core module.
> I've got a kernel test robot warning on this in v1:
> https://www.spinics.net/lists/linux-mmc/msg81530.html

I don't recall how the code looked in v1. Probably there was a call to
mmc_send_ext_addr() from the mmc block device driver that isn't there
anymore, which seems very much correct to me.

You can for sure drop the EXPORT_SYMBOL_GPL from here, it isn't needed.

Kind regards
Uffe
