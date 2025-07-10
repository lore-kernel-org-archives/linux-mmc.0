Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA62505CE
	for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148638; cv=none; b=mrjFWlk5GL7kut9NwKqqT2pdOUAwS8Muaxlzdn2sej8Qooap94bXEZwMqVj0S412Rq6ZWcTVB4I9C0Cv0MP0M9sRY5Z+iw1iCEXgSJqp4MKBJDaOOwyTalOYnsl6yXfXINmXU4jol/Bpt0DwPM2406+LzLyIKEVRufT1UqNPYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148638; c=relaxed/simple;
	bh=BQqb0SNgVoNGsycGR92DhtpKw0yCcu6Foev7kKByCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXlzFfMprw61i2zo0bkzH3A35NogTNaEmZG+Uxf3j6neJqdxk6ouf4Zx6qp6etdRgBW6cM0cwNFo93Qwh4jUago6GXwZHmqzVvI/zCYqN8j2BUfSInDmYIS2PtELE5n1kKAgCp6Bj9cvqNP4vcYRQH7ehz9yRPBGuFIW9w8EfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmTB+0Qy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmTB+0Qy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d6ade159so6924485e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2025 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752148635; x=1752753435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1zsrIgu077n8B1zg/1wvmigSX0f2Vi+tNtLjeU3vJk=;
        b=cmTB+0QybMFOT4aHmIz5jlbddjftxW9z5a4c6MunEY7Di1I+oJzxQluKNY9xSV4+ek
         Uc0+Ro0+ZN9+6drF4lkwL2mOAGH36A9bw8VYLe+LESSXzi99gKTHqDRu6+IFoZsOQJPK
         6EPrW49QJf9+GTHXgLN1YoZzF3MEpgBM0O1t7EHWnorF/ITpetkEm4mOZaCohn3xZngb
         /sXNOW374Wagbux9dETKC2/XAl84ayfStxcLZhLoUlK8vaMws3HNThWYKStVjEXsu715
         FEjZQ3gBIJ0Q8Znf9o+Zr3iFc8zESzpzUt8YDzSaerZSkSrxFgjb8P44eukCnEeA6l21
         4pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148635; x=1752753435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1zsrIgu077n8B1zg/1wvmigSX0f2Vi+tNtLjeU3vJk=;
        b=ha9en7spvlnA9I4EJcvvNrzPkRp+ipBpspduh52Bc3lzz1VjS5yd8oZG+UNZoPts+z
         +QejAfRb+TUAZJ1rBODbZgmXHnbRYaeyVVOnJoS8yKacxag07+3hfKHcHgDm0kMKE+sb
         ck4EHhkRTttRexg+J9NCjT/6Rz6FPNAg5okpILNjn/6uo80WGpnj24JoqOWhBD7tnIB5
         nwMFS3OJRKTIh/2jrc6bmnrW6EOqugorcjXamqbM3SmbE4Nz44gwx+V9xIslYLfxjWw5
         wfdCZoMGuX0/Q9iYRRcKhyrMpcY5539F4S0n6gC3eZ1E02Ny74Zf4OcK4EZYEPzCdDqu
         XtJg==
X-Gm-Message-State: AOJu0YzpsH1ccxRmVLcSxM2NZR9CGJnt6itugqwlX2byvaokb9K0kRtQ
	VjA/ojlFbIJ8q3zXOV1rsNS5X4e5adjZ09z9j88JuwClwjhsmymlQdXZxATzug==
X-Gm-Gg: ASbGncvRKOZvx9hUtV3oUKowXpK8F4xCv+O4Sq7XvHdhICkcnvQ0QHnF6+4nCNIN2Rj
	ijzGeTcY0/23IP5LlWR5BlzvIy+wNqCZTlJzY42SqG+uaKFWfXC6EtYrgkkqGikACnhzIhfTwoM
	ziw/STnhgiu9DKfge6a3CU5hy69SsdBgs/KELJBeQKZhJ9AEKwRXDBTwRrpbYOSO4MTCRIpL4MZ
	J7gbYAwwjNSkCgL4OwnTUjI3Db7CevkzIumx+UfNgAAZVkn2r1bz3jEmNYCEWi2hulIx/P8Ctme
	JS1xBvN7aNTPwddrwivh/srWDqz19j88ulAlVgW7p4Zc/NXWRaiuxASypJVRTRAyYva43MYEcka
	iojD1v6A/fAW2pE9ElIr+aMD9e7qs6oMb4jGP1QcT/do=
X-Google-Smtp-Source: AGHT+IEGX0Ptj2Ur/qwHXRX80USwfOD9tLt1KYSZrfw3N9twYoaWmMgkmsD1kpe25E9vJ/lRW9uYRw==
X-Received: by 2002:a05:6000:387:b0:3a5:2c18:b181 with SMTP id ffacd0b85a97d-3b5e86e3447mr2698184f8f.53.1752148635194;
        Thu, 10 Jul 2025 04:57:15 -0700 (PDT)
Received: from mdionisio-OptiPlex-7070.powersoft.it (srvsp.powersoft.it. [93.146.228.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2747fsm1652622f8f.100.2025.07.10.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:57:14 -0700 (PDT)
From: Michele Dionisio <michele.dionisio@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: avri.altman@wdc.com,
	ulf.hansson@linaro.org
Subject: 
Date: Thu, 10 Jul 2025 13:56:31 +0200
Message-ID: <20250710115653.2808619-1-michele.dionisio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PH7PR16MB6196D50A37E3A318ED6B98BEE54EA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <PH7PR16MB6196D50A37E3A318ED6B98BEE54EA@PH7PR16MB6196.namprd16.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I update docs/HOWTO.rst, add check to not flush if cache is disabled,
and other minor change that you suggest, but I not update log message 
because detail error message is printed inside read/write_extcsd.

I split my patch in 3 because the first 2 does not add nothing but
only do the same change that you suggest for the other command that
involve 'cache'

