Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD52206E
	for <linux-mmc@vger.kernel.org>; Tue, 19 Mar 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859413; cv=none; b=hxcwdAszxLssH8la/gpySpfGgJZi54Zo8cu933DC/CkXyJILKXlZrsFx70+VplYVlfAX37qt01TG4o+vtf283VQMJBBoWFppFXd8/11uJdGM6fSn1ipEJU77BdHCetqmMjy1CbSZF1x1qU4F1omD9AbZyrevVUFerLwwa0f6TDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859413; c=relaxed/simple;
	bh=au6IXNXq9FpfpZliN7ZuzD5VbLJHdPwrp313UdvgFv0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p3h2oO9Sbs65xaBjJ1SGKg6D9uKNiAObJJGBFwI74U+I+9LJkvR+3wAqpJz/0j+IHuXxpANUKs6523IAzFYK8w3BveWNmHEHHUqAo05UXLl6YcDZ+EDrLVr+eC8cYEfN69Y74xFaXkxgxacZ72dleP+TNRbjQ6aWaTqNclyOb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=videowindow.eu; spf=pass smtp.mailfrom=videowindow.eu; dkim=pass (2048-bit key) header.d=videowindow.eu header.i=@videowindow.eu header.b=konS/h0a; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=videowindow.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=videowindow.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=videowindow.eu header.i=@videowindow.eu header.b="konS/h0a"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a468226e135so500289566b.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 Mar 2024 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=videowindow.eu; s=google; t=1710859409; x=1711464209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s610CtFwTBOx1SNWcwRP7XSLlDS3XCufsA00i0DGLbM=;
        b=konS/h0a8Oid4RO1togx4f+E4lj/CDazDkJJcO2FzCCCRv0UR1cU5XoH3p6Gl1Kdwb
         eSeLnZ+Q4AibcmTVmATyJv42Lv4BsXbmhtGJUhaZkjA8BTpCdtfz+Ho274v4d6Atirg9
         rAjcf1LzwmgpNite85E35O2FdEPMUCRPfT0xVxgwMJYwTohgIk5FwFwqvYqp8ZYlsNqa
         VSQWUV3lSsZ6co3vM69p7ER8DGRqjzsrb2xZlyCGhB4T74XmkCUkbzZ1jTmHs6Ni4ov2
         41EipYYJNxd0rf6U8TgcI1XvhtCoJXU2gw5qbb5PNJ0vCqOf1Qsdu/gWICuCn481p1CI
         qwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710859409; x=1711464209;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s610CtFwTBOx1SNWcwRP7XSLlDS3XCufsA00i0DGLbM=;
        b=KkXXWw+LlzYi5arreApPQduMehcZI1LgGPYb0XBlc7zC0QULwed7xlIQPmUGehtbCc
         A/+7peFUrWYA7OA/HlKmATzR44DCPnzsFm0ZazHRlxmmsrL5FoAcDcetik7ThaXE8kmf
         B5dtMXH38YbghVm0Cz0w+sbBeBLcCRiZ77HVkUmjf0N/OCquJ6wexiPp3MfwIo1uOD2u
         JoG6tb4EE9GL/kXT2n5Yx+m9OtNW7kJJ0ftjFeWECzXe5vUQsg3wQsD474gS9O9mVets
         lf4Kv8u9+fLUVaeQhyNlHozef0DMQKxqeOQubqmZiuG238PlwlcAoKlkGJvO9UsLhwQ5
         bmDw==
X-Gm-Message-State: AOJu0Yz4of0D4tbWqvlfoC+gFkAw9TVZS/AogwvpcdwoXF1qe97dsXND
	k0WFIdVt8zeyRWxuIHqGRVKoGV40HfSkGmDbd72R1c02qNm72pbAmG+tpxTGwOAum16uvDGZYKp
	oq8o44jjAC/60+ogTaGrp9alpT0hz1+9xSHGpFjmUgsZOC4UqfoE=
X-Google-Smtp-Source: AGHT+IGQsEGYvrtMDhSPk+XXI7C5kIzZw19ZGoQWQxCWi4eamDZzfr5tHwLBs2tJ+Sz+Evz+YeUhqNCjUVixz7JKLU8=
X-Received: by 2002:a17:906:bfe6:b0:a46:4c8e:1afd with SMTP id
 vr6-20020a170906bfe600b00a464c8e1afdmr11438633ejb.6.1710859409039; Tue, 19
 Mar 2024 07:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Francisco Ayala Le Brun <francisco@videowindow.eu>
Date: Tue, 19 Mar 2024 15:43:18 +0100
Message-ID: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
Subject: Bug report: probe of AMDI0040:00 failed with error -16
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report a bug.

Issue description:
After updating a GHF51 SBC to a newer kernel version, the system was
no longer able to boot. Running the "lsblk" command in the recovery
console showed no mmc storage detected.

System Information:
OS: Fedora 40 x86_64
Kernel: 6.8.0-0.rc6.49.fc40.x86_64

Relevant Logs:
[   10.920756] Call Trace:
[   10.920763]  <TASK>
[   10.920771]  dump_stack_lvl+0x4d/0x70
[   10.920786]  __setup_irq+0x530/0x6c0
[   10.920801]  request_threaded_irq+0xe5/0x180
[   10.920813]  ? __pfx_sdhci_thread_irq+0x10/0x10 [sdhci]
[   10.920843]  __sdhci_add_host+0x108/0x360 [sdhci]
[   10.920871]  sdhci_acpi_probe+0x3a8/0x500 [sdhci_acpi]
[   10.920894]  platform_probe+0x44/0xa0
[   10.920908]  really_probe+0x19e/0x3e0
[   10.930244]  __driver_probe_device+0x78/0x160
[   10.930264]  driver_probe_device+0x1f/0xa0
[   10.930273]  __driver_attach_async_helper+0x5e/0xe0
[   10.930284]  async_run_entry_fn+0x34/0x130
[   10.930296]  process_one_work+0x170/0x330
[   10.930309]  worker_thread+0x273/0x3c0
[   10.934639]  ? __pfx_worker_thread+0x10/0x10
[   10.934654]  kthread+0xe8/0x120
[   10.934663]  ? __pfx_kthread+0x10/0x10
[   10.934671]  ret_from_fork+0x34/0x50
[   10.934681]  ? __pfx_kthread+0x10/0x10
[   10.934688]  ret_from_fork_asm+0x1b/0x30
[   10.934708]  </TASK>
[   10.940978] mmc0: Failed to request IRQ 7: -16
[   10.943885] sdhci-acpi: probe of AMDI0040:00 failed with error -16
