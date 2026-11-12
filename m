Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486735;
	b=irGoRo8xZ8LVoboQTly/qi4HVeKTt5JAg07+As51JSzdPFz1eGtMrwSxEkSsJKIg2A59
	 3Z2557H7EetXEUBqVAYPMhmMIySp8KoHFURB57ssRtWPWANWfGiqzvv8Uas+NRZONINAr
	 Q1qqTsT/21NX5Q+XnQxFULjf4h/rKMFTUE5HaT74RBxXZgXu3jaxsnXQNkxGMyf30VRsL
	 /2nIXYjlh3+3LJlyfvB7TO2zRrhmIdR96iZsa75rMakYDr2GAscG/RovKnqW0zh1z/9B4
	 DSTrvpYWDq4TRcQc8WNGaTNefkoektDIK9B9VquA8NO8NpA5L9dpkKYM+BZQjKhqgKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486735;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TOXxOKWso1TazH7ld7sFDjNk7p2tHy0y8okZLG5HPz4=;
	b=k9ma6IBZpkxpWVPIjrsipVdX5R+66IZ+oyNnf2ayI9E9oiKLytP4JhN3Zyqd+CX3tT8b
	 tlnIfG/88xo0Tx/x/QFbIsZXIVaDNwaqOsSAMRirxbL8yzuTvap9sPndlNZ+csXvsb+ux
	 1+pBs+8JJIsLVZVKrkX1gFk5PGrWqNSIc8gXT/+Nk1cXGrnCBqvxyDlrN7q96d7bCqD1H
	 oDkqgGH9Jx4Hhv580NwNauUOOAqL+chJeHHcxVGGf+MzfVGO7f2Lt+XpCdjK2pmi/HNDT
	 Zu4/451/owY7vqErDaKlHUpS7Sv3KlEnSzt7GJVxi5bbIy0Bw6ilUwynHFps/ACabJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jghg0KTe;
	arc=none smtp.remote-ip=95.215.58.28
Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C98606A330
	for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2026 12:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C98606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jghg0KTe
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C1VFcq6I0sFyOtf24jWVjMt72rPgj+CjBqrs04ic92A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794486729; v=1; x=1795091529;
 b=jghg0KTeZ4U//iXLJShxFLBERH0ml1GA7OgRjs0Q+f/ULhkEtSmby2Cg40qRoERYk8g+MPSu
 jmqdyjnxY9aymluIIlEFpUuKnqO2bWT863OVK1VCUx4bKNqzcZNZNlyK81+FHuatzRC8DxqtSvV
 R2th2L51l2Q2iFJmVV1BU9F8=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0af92d601ae0eed7;
	Thu, 12 Nov 2026 12:32:09 +0000
X-Mizu-Trace-ID: 0af92d601ae0eed7
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 13:32:04 +0100
From: Luka Gejak <luka.gejak@linux.dev>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Ulf Hansson <ulfh@kernel.org>
CC: linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_mmc=3A_?=
 =?US-ASCII?Q?sdio=3A_Set_acpi=5Fdevice=2Epow?=
 =?US-ASCII?Q?er=2Eflags=2Eignore=5Fparent_flag_on_sdio=5Ffunc_companion?=
In-Reply-To: <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
References: <20261112120204.98633-1-johannes.goede@oss.qualcomm.com> <20261112120204.98633-2-johannes.goede@oss.qualcomm.com>
Message-ID: <339AA265-E4AF-4C6D-8886-AC14A8E32545@linux.dev>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Hans,

Thanks for the v2, it looks good to me.

On November 12, 2026 1:02:04 PM GMT+01:00, Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:

> @@ -402,6 +423,8 @@ int sdio_add_func(struct sdio_func *func)
>       ret = device_add(&func->dev);
>       if (ret == 0)
>               sdio_func_set_present(func);
> +     else
> +             sdio_acpi_clear_handle(func);

This clear seems redundant, since on any sdio_add_func() failure
mmc_attach_sdio() ends up in sdio_remove_func(), which clears the flag
again. It is harmless though, and I don't think it is worth a respin.

The commit message has a few typos:

        looses -> loses
        safe todo -> safe to do
        wills -> will
        inline with -> in line with

Ulf, would you be fine fixing these when applying, so Hans doesn't need
to resend?

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Best regards,
Luka Gejak
