Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D21C3C18
	for <linux-mmc@vger.kernel.org>; Mon,  5 May 2025 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471368; cv=none; b=MSLHfVXYJgiYR3144Dv7i5cP8OMoxBL1+k4w7/tRmP8+ArDwfe33RWzs/DvV6LrK+WTy45S8oyrYuexJfRfBrWKyeckqpN8KPMGvHx2RqpLc2pP4SRKOYctLpEIquucF9V02BcIO6CMGnR5uLm2Xax0gatuNcR78MZ1tlhSinUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471368; c=relaxed/simple;
	bh=Rpw5uPm9OVDOhGTgBAsMugKqns2cW9QeKHwHn4j4+BE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RbdN2NYUb1BjFcAQk7VkEyEWeXzcS3VMIN17Uw/rSuITaK/3iWYSoRhcZgq9ZHAXN3H+U/mwl2uR7jiQNE0amfUw7HE1ioZzkBGznhXRWxNIWmCjjAndTFhL2HV5bSw11rBAJkDLyKzSC4lDYx2h1QJ4Qdn2lb3Nh9W169ScqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+NvLJlM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+NvLJlM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3015001f862so3519717a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 05 May 2025 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746471365; x=1747076165; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vh/o/jInMaRT01dyecdcZeqUsKJxFcbFHKAJ49jHLmk=;
        b=Y+NvLJlMbG7UxNaHNnqS/ir/4iMEMZSksUfnqg2eLtr5krPDmA2MxBxANnL5p647e1
         yzhod4EoTidBiIsaM7RM+U+k1Uqn8kDMxul7FxdROVMbWh7HlCZNT+u8tY286BJDcbqL
         2ME4xC9L/DO0Qd4Kk6OMhWP8sIv7rEthOB5+IHKq9PE+6PfVln0rk+FihntDBNB3DmE+
         leO1aIAFA8ZaNCbjR45ml9uoL7RB92UabVw3wqDvQu22ageRoOfRUFNTpCp/OvgRznrt
         LF2y9MfH8hV0XV1bpG9/v8L8ra4Vi4AMey8hheTIDozFO/+gV1Q+fprtvxIiXAyi+T0F
         BZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746471365; x=1747076165;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vh/o/jInMaRT01dyecdcZeqUsKJxFcbFHKAJ49jHLmk=;
        b=FGLwB9w2Jt7RFWAICz45iBlz8JRbDcJgke+AMMTBhnncdgy9VW9NvQTzcpZjUiZbu0
         3xO4qxHQ4qDp/XN3stQ1o6YejNgdyOcY8NJAfTc++gIJR2X8zv4baQ5/Xr1Awg0mUoot
         840Hnkk5e1fJvFM4YgiFy3iM95o1ml9NssdJh5OyPwyzVy9X2oIKKCGLWFIcQU56yNtO
         Rn8yHV2MYLQVu9hKoi3J9L70JxpOSInUM/VfGjduiFXHatnyqWYZVKIjFGwqwG8I1aO7
         6cPTnEe86cMJyjeWfFIPluA/xcjwHW2DQtnxSgGCnc9e30ktOlQwAitXR6DYu3L6btYD
         uUDA==
X-Gm-Message-State: AOJu0YxvC/IO+F6tkmLs1UdKK9gRV8PPg7V+juRNXPo+gRhuTd68Q/el
	KpEUoIKSDeh6Qb/6vGV3iTvCYuyGPg20Iu63icsJqFIGi3K3PodSlhQTyfSD6cdZ9+fdXJQWsMe
	zOayIdOqRcKpEsXBb1Jbbfbl6dlWoFa0R5Yo=
X-Gm-Gg: ASbGncuOjeQRAy1+UEBRlb/C3YCpLvrfJCJCj6T1KsduXddMppqH042ggEQvrM6wyxF
	bAWA9eYTdNLBZpSqCSiYbakD8TNrEvRzeUb8ii/xxFSD1agg6jlmAzH1E82bt1HE3jj9yfJ5xRS
	UdTZW2mP8HdrvYYdzSHws=
X-Google-Smtp-Source: AGHT+IE0h+6IbR0P9kt6Sd84kXRj5O9P9SZWE2JYjykKTxjNzNF/xZeyD2Q8xepW3mEfjlin6jcdhgaTMNe6gszhsPQ=
X-Received: by 2002:a17:90b:55d0:b0:30a:2162:c76a with SMTP id
 98e67ed59e1d1-30a5aeb7ce5mr15840693a91.25.1746471365442; Mon, 05 May 2025
 11:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Mon, 5 May 2025 21:55:53 +0300
X-Gm-Features: ATxdqUHEyQgyTlXEjuH4BPAGRTZkspUBZveXs_bCbfm2wBDNif1HhcUhqZLmG3Y
Message-ID: <CAJs94Ebmyf_5BWNvSRa2O+3oEcwnYFN4Zs-BP5_fPqxQsxKvzw@mail.gmail.com>
Subject: mmc_test framework: failures at rtsx_usb
To: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


I've just run mmc_test suite on rtsx_usb mmc host controller module
with RTS5170 hardware attached.
Kernel version is 6.14.0. The following four test has been failed:

May 05 21:06:47 localhost.localdomain kernel: mmc0: Test case 15.
Proper xfer_size at write (start failure)...
May 05 21:06:47 localhost.localdomain kernel: mmc0: Result: FAILED
May 05 21:06:47 localhost.localdomain kernel: mmc0: Test case 16.
Proper xfer_size at read (start failure)...
May 05 21:06:57 localhost.localdomain kernel: mmc0: Result: FAILED
May 05 21:06:57 localhost.localdomain kernel: mmc0: Test case 17.
Proper xfer_size at write (midway failure)...
May 05 21:06:57 localhost.localdomain kernel: mmc0: Result: FAILED
May 05 21:06:57 localhost.localdomain kernel: mmc0: Test case 18.
Proper xfer_size at read (midway failure)...
May 05 21:07:08 localhost.localdomain kernel: mmc0: Result: FAILED

Should I normally report it or it is known not to work?


-- 
With best regards,
Matwey V. Kornilov
