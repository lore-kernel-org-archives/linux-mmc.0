Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE252E41C
	for <linux-mmc@vger.kernel.org>; Thu, 21 Mar 2024 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003175; cv=none; b=rtom8x5rAL9l4gqjnyzs1daa1LBtCxPL4R5n3Qxo0dZl65BI4S60C9UfkPsYeYevRcUJKJpxHTrduhUcookE9l5QG6nvsAJyl75JNSA5F4g6IOqcjoeJbk04g7Jr03CmBZJLMo3TJdWLmzzcqlw2DAiqXtYSj+JPIuIBlxHX42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003175; c=relaxed/simple;
	bh=IWzoRyiIq34RmhOn0iDV7qym3hPufd8Mn7S0DjBmBYA=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=e+jGs5789zaioYNnx69HGqcDNwaIx7Es9SrsLQDzKLSVvbB5pOn9bSs2WU39rhCa3bXKjo0Vc/ZWGKmwuhm/Rbz7NMLR5ta/Qrblakb6krytrMtuBEew53gCa6TLgcWv5WmTaflzUFt2aSZYi1rMW7lu5wadwOKkAl5Xh7Tr+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eol7zw7k; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eol7zw7k"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c38eced701so412938b6e.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Mar 2024 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711003173; x=1711607973; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=eol7zw7kJ3H0Ceo6iRB1UPi1Wa+z0/vbDyiDocoIhj1nCdIdgTBxlYdtoFroxVXeho
         6RcNoIx0cH8CmTtQGjwLsHIkdiFXmMgBkpyxrzSNDbx9oRvrGdKW2qxaCytqpQwWA4yx
         n6iXE5JOAKi62zfzzakQ6Xi7TWaoMIAbMQfRRFfEW4SMXN2LbDHMOvw5EfviSEKiZV3P
         /S/jLnL08JtzHNMRchNlGr6oSgAqNkZK2TG8Bf0u4pwI2LTE83UFa3CnruiraXT341G+
         YPLHWCm1s8KR1XAUO3nvfKW03IgB5wsZbV3r7VZqNCnPNTbeMGp/IZdmkZ2i3QNGhiuo
         1p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003173; x=1711607973;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUEt2Z97b8lEWwJktqHAAwXS3vj2uI9IohvvSbiYwx0=;
        b=eMGeqB+4cZOKjTIZIJEF3ckbvCNf/lQi4hqUfsfcJ34L24ztvGln81Uu2aRjB6e8zG
         c+JzKSYnpM7EvlCT+Kh7giUx0Dga4420aV+PSkNwy+3YMvo2D42Hq6QnTYwdTjSMR2YM
         uMYDf0/uyipcgy3xhyPK8ZI8yC8R8xxQHPVBREH36ihbi0wHjZRpPPn2d01fvPs0Msxt
         5GvFeAk8etJEffdzDDYUX6rLqpxtu2XAQFQMaoKE3kb2i1441/mZu2u9tj/tCIg3hkGs
         cYoiC9BhJxDhJIt4UJjYYcxSp/+AgCz/puD7P1wwiMU7L11D+a7M4DExlNdcdx364qRB
         8n5A==
X-Gm-Message-State: AOJu0YzSIspYJt3D5k1nz0TR20eax3GkcwAIKtoq5QjU3eDtEN8zK+KR
	9eGUyrGL1vG9EQbiiWKgyWI22h5juRvwczYTV/Q1Tf5ze+lWTUTokQfMAhkF
X-Google-Smtp-Source: AGHT+IG7FIji/E/jAw67SCf1NYHIL+l6fY8ymudhJKpzx3d9A4mk5XCfbTePe8zj76fRDopw9kOC3w==
X-Received: by 2002:a05:6a20:d80c:b0:1a3:5c61:159 with SMTP id iv12-20020a056a20d80c00b001a35c610159mr1285748pzb.53.1711002744550;
        Wed, 20 Mar 2024 23:32:24 -0700 (PDT)
Received: from ?IPv6:2409:4063:6c85:f395:d58f:6b15:5165:7028? ([2409:4063:6c85:f395:d58f:6b15:5165:7028])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001dddeb10d83sm12862593plx.223.2024.03.20.23.32.23
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 23:32:24 -0700 (PDT)
Reply-To: businesssolutionsrocks23@gmail.com
From: Raju Kumar <rajukumarkorav@gmail.com>
To: linux-mmc@vger.kernel.org
Subject: RE:Mobile App Development || Web App Development
Message-ID: <f5f502ef-33ec-9a8c-9e46-7d1fd316e11e@gmail.com>
Date: Thu, 21 Mar 2024 12:02:19 +0530
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

Hi,

Just checking with you if you got a chance to see my previous email.

Please let us know if you have MOBILE APP or WEB APP DEVELOPMENT 
requirements; we can schedule a quick call to discuss further in detail.

Kindly suggest a good time to connect also best number to reach you.

Thank you
Raju Kumar

  On Tuesday 28 November 2023 5:43 PM, Raju Kumar wrote:


Hi,

We are a leading IT & Non-IT Staffing services company.
We design and develop web and mobile applications for our clients 
worldwide, focusing on outstanding user experience.

We help companies leverage technological capabilities by developing 
cutting-edge mobile applications with excellent UX (User Experience) 
across multiple platforms.

iOS App Development
Android App Development
Cross-platform App Development
Web App Development

Can we schedule a quick call with one of senior consultants so we can 
discuss this further in detail?
Please suggest a day and time and also share the best number to reach you.

Thank you
Raju Kumar
