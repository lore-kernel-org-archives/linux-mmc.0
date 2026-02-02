Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72426158C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Feb 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064922; cv=pass; b=g5vmzJf3L5MJEzLjYX8OzwId/T1l5SPqFs0rkNbf1tuDOwWsC6/WLUPiQcLVjpeNQEXfUUd9Sz2N/G4g/NK2nj1WEjf2Msjg3R+vv/uqbdwhK3omjt+SdGszVq/ufpSVgUZsn9BH5LNPUc3PCMy0cx7hUkrxdE1UIk9ZPfMkqnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064922; c=relaxed/simple;
	bh=x8PvMabAxTZQrsN3m38TJhIAVXnRpXGoLfKKF05Z3Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpZ6MzJdLZzU7Y38s3t6JcXBM+6Qpr+zSNkV+ahzdnyZLST+4f2PEYPK6FKujAjcfYJvwfzJ1/QBYCio9F6eVKjFNEGp0+u4hIa4ihzM3XgP3jTRIigWU73Zo5+uNHzryyIA3R4m1sgjiN6xLrwAUQU/hfwU0EWjsFVH0RDxro4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOzWgdqR; arc=pass smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOzWgdqR"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-5029aa94f28so1332811cf.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2026 12:42:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064920; cv=none;
        d=google.com; s=arc-20240605;
        b=lxylE2po1LR9oaR91SUIWpYm6bKNhm3p3Av7TAJ2kekvLt/zeM/jNtglWeDS+m8Inc
         RQ/7c4MfVANhk6rkiQ4XLTh9aC7uEfW0Pzy0oSqHixYlf3K/qL01Y/X3x79APRikpDbW
         4ooIBZcIr6WivqFOYdv4SNMJmUJ6qLuw1HpDwXQ2esm9kQHxNhnu7HJbIb06B01Vzuf/
         TkoadYv88xKTcg4R/YLhkq8k5QSqbT51TNSOlyL8zy7vRWL7VADFC7SxN92b9Krz+QBv
         1gE8yh+a0fCHtMdaRrrqx+2wgGK/MwjoMgeI7Z5LNocaSI527YG3wnLAHyoYLPXoEe67
         pyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x8PvMabAxTZQrsN3m38TJhIAVXnRpXGoLfKKF05Z3Qw=;
        fh=M7UOd/t5//Qe9QvEc+sgAdznt0bpWIM/Iw0CVNsYa9U=;
        b=ZlruC+ty+0IQsQNHz8BTd907QD9WtVqgVHeWWrPmL060GZxVaOw8bOtG0o2o8cKbye
         hhPo5d+rgu4mRLNSBjKlllTzyKeShShBDMzvCybSFuhHQ4h8/uc85avgei+mMsaRaob+
         tFuII6GHNkwU1G+QOSmnMx7OB1S43sYri7Psc2bzOfxGEBqPgx4K1gfstfLSoRwcMhU2
         4SKAA+8h4mChrKkHahHNnxsU4l6qvIv2IClqNbl/wJ0yWjDfg3F9aSG0mZAflqBg/fYT
         WyMeHoCVdpUBQpqRP42DlnEiscBsMDs19aoz67QgGDRjykMmGfSQYqobbg2wCsFZN3U6
         8o+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064920; x=1770669720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8PvMabAxTZQrsN3m38TJhIAVXnRpXGoLfKKF05Z3Qw=;
        b=lOzWgdqR9YK3f4any7KnQaeDYGwcScvQlUpucZxZb7tmJL28QUpxUxzEL8KVAL15Tq
         gD2EctfVcxmsrQc/kqsij+OxUimpR04tiV3T17Q78R492s91OS7PhZoxrsEy8Lln9FNZ
         B3EEp6dmImNQCzK5IhhTyMUGrLcxCO/ut9uVkVIsTJbVOpstDXELjWsnVpQk3fr81vPd
         xn5ui1uuyDZSM5MkIWn0d5PdPYe9L3XWtYIq7rsvUidgHKpndp+8oS9hlZIEck0cBBDS
         xztIcUnhBxq94VXn+FJGF+5bWi3aJUFSSOWjnKg4h90YwPiDeVQlw87RvWof2cdpAvly
         pAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064920; x=1770669720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8PvMabAxTZQrsN3m38TJhIAVXnRpXGoLfKKF05Z3Qw=;
        b=e2UWPvWtMboT6hL6TrUh3T2gdeFxG8LW41kuOFcF32CDMaRKccBp/Xq7BXHxwj4T1j
         4y4lrTRmV0rcCZWJI17ayw0JC+RL9R+JzOM90o1WCFE1zwbvpBoswf+H5wSYQE5Wzd19
         RRcHNjw4Or3pAMA63DaFpgeAScriAPtmVZMPY9WKDquuLTveNklEQWccgSEI7S27Ddjk
         44GoPoYrpzvuvlGPqgPLlt13zjXrjYuA2cYpA9Ek7NjZyINlc5SRipUBhEjE+tRNVDHY
         bw3yT2DmStdTcKzohrkxW2ztFW2CqY+kmXXEfmnrH/rVcOpW4BfYbV6GcbxytH53pSaw
         iRTg==
X-Gm-Message-State: AOJu0Yz5jKKreaSpnyrCTaUsfzZrLe0HbBVORArCQEQGd4fPbIVrn7UR
	f9+dAiBjQBoEe04Q6w1mzhIYcWwKOUstpuYdzC7eQ6ql14wRSfot8f27eqvY7j7MQtzRD7l7FLU
	uHW3DGkPeS8y1BPnZF/M/x9EG2yDYk34=
X-Gm-Gg: AZuq6aK6jVxdQcSsOmqBLGKKtBnJziOBlk9yxbuoI3HX7Ncbw5Or0e7RU7iy43bplla
	qWIyyoQQcT9iQ4j5Q4mdb4SD0QVlV6OH33V9QcjWtp+UpQE/p9P2fRDVNn+YxOCATkE/wvcflYQ
	VSgKJnMIhutcLTm1h+a5QhxC83DDgwGzmQ4xP/3lQITnHZZu/mUeZDIwF3FFeM+CyaWCS0MPcLq
	xz1vYhbxM+3jCJc4IIy7wrLjOTDwi9r4DBQKqSjLN9jhGin9g8GznfGMC5kgbJEFJkA47JKcoeY
	yH/TImTw4/4SSPIGUMd/JInn4mZzRrqzk49ik4MBFMR0hu1uz6vDUQ4kSJvulpLKFjCk85Gwyy4
	4Q7sa0B6vvhTzmg==
X-Received: by 2002:ac8:5a54:0:b0:501:45d7:10cd with SMTP id
 d75a77b69052e-506092c7f24mr8594851cf.20.1770064920512; Mon, 02 Feb 2026
 12:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
 <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com> <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com>
In-Reply-To: <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 12:41:49 -0800
X-Gm-Features: AZwV_QhBvfCKv4AsLQxuoRW4O5tLik_pRwNEE0LhoukFq7Yx_peoFKRdoZgkJH0
Message-ID: <CADkSEUgopExHdfSwyHWOEF8V+HvqeBFqRyqm0T7y=JBd-4Hs=A@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 12:40=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> and the exit function returns zero
Ignore this part. I forgot that the exit function returns void.

Ethan
