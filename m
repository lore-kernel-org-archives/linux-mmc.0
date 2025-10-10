Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508936B
	for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 04:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760071274; cv=none; b=eKUl8Kvsws6Prqh/ShzEOSPLU+Si+dVZL7DTQJfNEIB9jMkYCCioxJ3ccZ0hGNFf5g1n98eLDvI/I8I8rBbss51L2FiX7ujBn+fJrjogXQ7QJFpMa6GX6JIOuwJ7BqMXzQOwuN9HbO/YTmgz/gETrk6rLN/Efs51l13kJ9fFH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760071274; c=relaxed/simple;
	bh=Svrst4sNWvZPM9ptRkVgFgBmuigM6Siiz8w5w3Sqplk=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=VHkzZYdAlLdYpEy9skzG22eJ5psHs3w3eUjIYzu0paTDu1J/pFG8NA/F3veMjHwzicLaCs2cVyE0Qdb49oVyfMs0OInvwIyqaTUtQpiB41C+jRhs10MHjgU7NaWxy5W8wclighXINp4TMYwpypC4j8yEj8cmFj5p087JvYrRCls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miuGGOCa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miuGGOCa"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782bfd0a977so1485605b3a.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2025 21:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760071270; x=1760676070; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzXQ6gKxFAXIJd8vP8znvGajrLDgu7v1EN7Ipv13j7s=;
        b=miuGGOCascncdRbdvrea1WCWyUCv1YyOtHvk/HMsnurAj4y0H2Abwxo5YYG2NU9JaX
         gvCDHVrpcRy4q0kAmriaclR4x4j6Ps0M/vIVpFIiyJNQwPrpMjUycOwIRs88qnev6q71
         jUrX0g+3OgAEHEoQSD9OOhZIYvBf+YT96qlk8Kna/G0fN/ZsgJCZ1Aq0HBVsP3TaLHuJ
         7SFoBifeulb1s0k1+Acf9RZ0pShA1AIA3M5gPSpFVvZvm2RhZZr11O60pkulBw6+/ptT
         DwVMVw3lslO3yw0HoodoKhxbh8+jzRgFhRsqO6oN8lhAgTUC927yDBJuQp1jB5UiXmSq
         IOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760071270; x=1760676070;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzXQ6gKxFAXIJd8vP8znvGajrLDgu7v1EN7Ipv13j7s=;
        b=dnMgVOgbdDYqePZsOsETg8GA/1huX2Wu616fuePtwT5eokF6/j5afdBWhSs4YSKViY
         hi1bxtWuHd6VAgWA1Ub0CZ0fwMuN6n1OZktctzTHcTb0L8wE//OfMUGzTFwQdyPX3T14
         f1Bk2Dx4+CaB14WeQe0Woc/F9gwVZK7iPCH91r3zu/ULcOCRSuXkhrgFLEng3K6oInRY
         Qu3e+t5iR4zLk/M1bFwsjiC/04FV0t3fiE9hfpP6XKqJMn7MdVD13gOAUdf7jgrZ+Pve
         MpLBqNzNRbhS/Ay1lVo0lv1pXWznRbaSQJMRJLLdagZCNSK1hIr52w5KRwzZ1zkMu+MB
         vmPQ==
X-Gm-Message-State: AOJu0YzUExss1zxpDWVE+Ay4R32AAePMvpd9RWAD2MoF5I1E46PYgVJl
	c0tYUAqSmBUydO3FeIOk7ZXerVgThvCXssum8ti4pkY5o2k6RFiR3MTQm0qA3A==
X-Gm-Gg: ASbGncs0qX/fZLpJFsy76jtGRetIVWyJg/qtlW4cM20RfktZBOC6vCnj6tGRJEK+dyS
	PS9kc50z/ddjEuyUqNfhqQcdaWvqKyAQ4wNlb+AGctGOFrBrp4GaqdvBW1QNAV0XjohbMpLYabP
	jhH/mmkRIc//ge3q0rqCQCVxt1PJtwoStNEzzZX+UsMQ4Fq2iuAB7tJBPze5XHnwvj3Z2euBjcA
	TsAuBNTNJEtoS6IkypMp7+hjhCjFnfO8GyB9xkFlHfveDodFULybKSB6pg+y9oau2jabvZK1wA5
	yj2m/0STZTYM762oEpamo+GnG+uNj1S4y2H8OCRXmm1MvtsILm+2HUCEhsLCVKZpg90aAEMSXpl
	pIeustGwelLSH1o/V9PRFXCa2MoEPylLjzXxIaxZZunXpMQtfvQUnyP6ULv8zqJa6krwGkgqsHT
	r78TcuQHfbQbYL2kxHi4bsXOBIsqwI
X-Google-Smtp-Source: AGHT+IHT/LiJv9lB8fWt5MHdf0oFjcahHACB4GQjNlEFj0mZAgT/UMpt+NVJf3p2rWEl9SP2rAf3hA==
X-Received: by 2002:a05:6a20:914f:b0:2f9:4cde:34fb with SMTP id adf61e73a8af0-32da80bbb01mr13756813637.1.1760071270146;
        Thu, 09 Oct 2025 21:41:10 -0700 (PDT)
Received: from ?IPv6:2409:40e3:2084:f4c4:99fd:d346:f152:46c7? ([2409:40e3:2084:f4c4:99fd:d346:f152:46c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060754sm1489478b3a.13.2025.10.09.21.41.08
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 21:41:09 -0700 (PDT)
From: Vimal Yadav <vy147591@gmail.com>
To: linux-mmc@vger.kernel.org
Subject: RE:Appointment request
Message-ID: <6414e083-d96e-3042-9331-cf1f04e01c20@gmail.com>
Date: Fri, 10 Oct 2025 10:11:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB

Hello there,

We did not hear back from you.

Can we schedule a call for Friday (10th october) or Monday (13th 
october) so we
can discuss Artificial Intelligence and Machine Learning requirements
you may have?

Kindly share your contact details and suggest a day/time for our call.

Thanks and regards
Vimal Yadav
Technical Solution Manager


On 28-07-2025 16:17, Vimal Yadav wrote:


Hello there,

Are you exploring ways to streamline operations, reduce costs, or
deliver smarter customer experiences?

We’re offering a free AI readiness consultation to help you identify
opportunities and create a roadmap tailored to your business.

Let’s talk about what AI and ML can actually do for your business.

Look forward to your response.

Thanks and regards
Vimal Yadav
Technical Solution Manager
