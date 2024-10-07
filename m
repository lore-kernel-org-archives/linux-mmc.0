Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B81D2714
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315278; cv=none; b=uiEhuVsrzpTTrbPTChMKNYQ1pNX12f8GYDx5KDk0LuQUH+TRBOJ8WiB2y5YNQRUuFVfXxsQvYT7M8g8Y+qnwdMpp3ny+WwhXRci4Af38e4AuhiZmq4Ys7L1P4XAYEQrAtrxXDFK3+aST54xdFG2YhIm9yB7etP0ZjNtmZ4UaG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315278; c=relaxed/simple;
	bh=sRRg6piG+3aTg+1ltOa/3wYaOzLT3DJc0mq4t5Vw4Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjXQ+cZVSNE/7h3t2ZGUlYnLiFwbVS8iPP5sbi7EHAaQ3tEaXj4pc7rGn6djPZ2DIRfo9FOizkIt3TyC23nlKjsj769rL37T086s8u3C0SzEQcwXinJezomiu9JGBsxt/gomF6SBUN4JnciS/6E0nx8L/845F32qfDqWjzzo0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTF5R/a5; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTF5R/a5"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25d15846baso3945198276.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728315275; x=1728920075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pWcDwMxqGGnJeEIPc0x3JFXLhGz0Cxxlgi4VrvXAYyQ=;
        b=UTF5R/a53TuG/77WH5Pw3nJUg7n//ndUbiLgUQPQV3QzKvdXnOmlyqNHhDqoCtwhi7
         s8yFsXE2Je/NoFl/OxWdJcCkrmEr9bZpZ85OA0Y2Zf6nhthTNaORxrb1zfrxfv8td6t2
         MdCeB9A2HDQhVjG0pPyXlEy45Xem/XppC4TAA4xvqcXSzjZ3E1sqOnzTSqJHVJiEmMb8
         LfYv//9XTq4GLsADpkrH0GQV/5OjE+GRopz09QrgnMj4MobqRo9aKDPc1vLzhYp3jTxX
         7I9oSiVsAgIhFIX7O+ycJe5HM2khwQ7BmzwvhLEgF+1hJxXTnVgHim1yAdEe8LdKIWJr
         1lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315275; x=1728920075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWcDwMxqGGnJeEIPc0x3JFXLhGz0Cxxlgi4VrvXAYyQ=;
        b=LJQziJ4VgXtNlWzaav1Q0JYxiGxNNSdtnqoFAhhq/abq/luhEDScgIJoVRVyBOplng
         wPvpRxYxRJO83LIF/JhB4EsGLl4phj4BEVqig05iR7ni13UzPWaHQbpEL9ayDUT2TtJz
         jvalQnvye8C+M1RybFa0XuDclYmIQ5roD7+AyX8hqP96hvA4zH/gxh3lE7S4FLC/vp+L
         eRIbm53bH0N7H10Ty6F51IYKdE32eOqiNK1ZYS1jD65Sa0zjYJVW4njH/y691IIKmJuZ
         PH12Y0NXHtaCVY5gpEdvsCOqp6OOJTt3IgTehN6TnXkwu8PPZ8kIZR0MdBBd57Pm7XSd
         DXtA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhOdoBw5tA99lzU3HNmRNnnVqBXAbLcY5PbfVbFiqePYqVhm0KO7/V1QfpF5HuKiBtoveCuAYij8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2q7vblVxm9A02ZMwAxz3mTah+IMWZwYxEP5Rqy99IpC8qkQ6
	9wjxdCOZUxY6TlbyLP2qwBQGtOvgBvHFeiAbVYkgRSw8RLfyO6PrL41oUmjHOc5YCIwfcIoyJ+i
	6r3UGoU6ERa4ddy9bzn5w7wQqKxe9rFKBdLkoBg==
X-Google-Smtp-Source: AGHT+IEJLEcH0O8UkVxsEgmlUswd0019MM6C0rHCgsIZpGEEbxovs4AhtDVb82JufMnhLZNKSxzuqQu7Kq4+iELR25M=
X-Received: by 2002:a5b:181:0:b0:e28:99d8:9eef with SMTP id
 3f1490d57ef6-e2899d89f9bmr6194074276.2.1728315275354; Mon, 07 Oct 2024
 08:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Oct 2024 17:33:58 +0200
Message-ID: <CAPDyKFoHrRGYkNCu0ev8iF6e8tQV7cbTAxm9jS0CCqvizmoWmw@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 12:28, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 and GL9767
> UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
>   Sequence[2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
>   [2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
>   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
>   Setting Register Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy
>   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.1
>   Packet Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> ===============
> patch#1-#7:  for core
> patch#8-#20: for sdhci
> patch#21:    for GL9755
> patch#22:    for GL9767

Patch 1 -> 6 applied for next, with some minor updates to patch2.

Patch 7 needs some more work, I will comment on that separately.

I am okay with patch 8 -> 22, but since there will be a re-spin for a
new version, perhaps you can run a new round of checkpatch.pl to see
if some of the warning that it reports can be fixed too.

[...]

Kind regards
Uffe
