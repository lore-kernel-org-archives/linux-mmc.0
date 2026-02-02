Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45926158C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Feb 2026 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064842; cv=pass; b=bUymoXOGZIRz0a4tzZkY+8dAIrajTUWVvz4JHVNOdEW7YvY17XQ70R8vYh8UfBcpbPjbt3XB6fEgiMvJ34oiGOeoDqzdsRtUh6dFTixM+Rq+Lgx65li5d0v5WJgAJVCDAR1HxjaOk2VoP1oDqH9gN0xJbRu4/jxpkZ00iT/QTyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064842; c=relaxed/simple;
	bh=sDW+dDq8/2w2wCpoXZZxgatMa+nKPrsA3Kzbb7Lpmx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxoPRwezBi4p59zFf0UWJpKyF6Bd9LZG4DsJi+44pCG1AW5bRwwRzCSbjP2c9+E8fGqkP7c7ns208ASL6YiadiRHEX34sn8RlanXUPQ5FcE+uTtcuTmMrE5GUz6jAZOPr1w53Y7sK5+02PhZb/gvcyN/0l62de4KPg15S75vWnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+PT+Wzb; arc=pass smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+PT+Wzb"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c5386f1c9fso665825585a.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2026 12:40:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064840; cv=none;
        d=google.com; s=arc-20240605;
        b=F9d+9bQQ1SHz1a8fW21EkStlpL8WB2Wr2XHWBGo5Z02AdsiPWdGKnbIK8QpB/Mmx4R
         oPdCpFLC7Rx1HxkAOna4g4NxB/w50+PPa2LFUGLPdczATxSM3co5573zKQBIBCwS35uU
         5wHIkfL5DqpSIAZvJ0s/NL8WaitJA0XdUHorjod4gYfDL5wlRwTqmY/CTTn7F7MG76X1
         09iCGwt/7EnEbolPjpRc4/TmoAKN4jAWGQ6b2mchGbMyJIDEuY/L1s0JwGw3in3Dj3t2
         Q6Eir1PoRH24U1sbYbfcYR/27599tQNRQTpYzQwB4IQ2Ba1YD0i20l77p0h9gFL0EjML
         Hyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sDW+dDq8/2w2wCpoXZZxgatMa+nKPrsA3Kzbb7Lpmx8=;
        fh=M7UOd/t5//Qe9QvEc+sgAdznt0bpWIM/Iw0CVNsYa9U=;
        b=Ndabca4j7Z+xT2CXn+mZJ38YoOI6qOE2THMLtBet3rkP6Vqu3A+Yh3dFpSyXUT2M/H
         CFPTWLc9VN6WWMVygEFwRLhqxsinBmnU9rqaCCnwOXaQR/ADrPARJ8ZhYNewyX0ThV3L
         eJZ5O9i9KFQaEYrz49Mn5BDb5gryeWA4hFo07O9de6sfUea4ing62beUc2+TmMsLRNRV
         Fo7E7eiecKcLxzam1K4uLaQkTl3WpR4aX0eNMtObYcdz9vXnRigO97XoQnAjJJASViMw
         F73arPKMqmhjNfgI+y93v1pk8NTsu42ay1ACyYYvxKIyzktLXAcfoOKn9zvejMGaO2uM
         NAmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064840; x=1770669640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDW+dDq8/2w2wCpoXZZxgatMa+nKPrsA3Kzbb7Lpmx8=;
        b=l+PT+WzbePp8wZbgdvhzu8qphMksDwk65DxtIELVMB27ZjypBVEuBhr1KPZPiKrUt0
         LW6id/vb56RT8wq6SXxfFjJQYFEfvUT4uiIq+XRpwO13MQaQm300exq8umo2BeVyGAs+
         8fjHeHTyMnNpwzPniIu0NVGSNYSTIw8o7VRWG/prKKqMMVwXNb4LrTKODS/s4+TXnmsU
         V5jIjKvhx3y5tZc7aVT4rkGYi/gso2M83HKAZA/JIs0MSGkkOz78JOx2tktedV1BYmtb
         n7Yv/1wHjf5e3DSIDsxUKHpVG388IcKw21a0xwKQJj76DUsKZ8rdTbL1ITEOR11pZ5h4
         ws9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064840; x=1770669640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDW+dDq8/2w2wCpoXZZxgatMa+nKPrsA3Kzbb7Lpmx8=;
        b=vHG8lJQpcYYkmft4ocLZNBlUvhC9I+/H8XrIwsJNxl/FtXtYS40cRfMoOkSXbk53O3
         gemBMUQ4Cf6zWsf7PbAC3mX3wh7q2XX+49ux6AWWnbswR/ExYz/o9P83kpHN1pLXB0fp
         qCqQnCIcYphlYS3+w3TXio5awb5KLtxc3Z+SBBAqSp6ajbmeEzt2h4/oDS9meVF5J9JH
         Hhd77DdUZ0qlFLXDPQUIuzybF4h2GmhzSPz0fAxOw5CqL5EPxJuE4i2tDxQhMnKdEB33
         w2xMLjaRuWt+dvb+/rRKvz0xwMzxkxPwiY5RxMrZIKBw3UY6mf6sO0GtmE8dQec692SU
         QVDQ==
X-Gm-Message-State: AOJu0YzHxg4dnlFy7BJfWNzdYAKv1zWerb76hUVNMLRxSRLm3TGHmbGq
	dNfHsNbVMYHyjjPCaEHAPjYGQ/2HX51rrG2WmK0ajIjCG+dDRYgaxYBn6Uzy2GxNbUR0cKF+pBP
	UBJR5b5keBSGN6+voahn0edHeDf7fz2rmemRH
X-Gm-Gg: AZuq6aKirh/s71AIQ9Z5QlNf3Jr1OExYHEkxprbNExlTKryQu/jCl9eC8VtX9uG8m6U
	m6LRMsL8gmjxj7NTAFjJGgCI+JXC7AGknMc2pR8mdcvSkjwc0G5OpjTQ2ckJFLnNLDVOUpD67Zb
	KlfQPHzk8HYcrM1NtUDgTgTLs0preCSlaJqb6yRRASq54LK7IydnGJsOIBmzowrocVpyNZPpcQT
	v1NOpHh/zFpmcNgt868/vMxNLNiHJlccW/awPN1R1uE7RVuKEfjMmIqhiheJ2tPkv8S41tyi4L3
	5POK9HhmwA5l8qxmvrvGTyDBxxhZuDsOd++nd+MIpzOIPEQIbT/FLhZfFq/v5MtbQDbRe3jL8gD
	3AFQvZw8KDjzJMf7PANF+R7iU
X-Received: by 2002:a05:620a:44cd:b0:8ca:12b5:9a7e with SMTP id
 af79cd13be357-8ca12b59b1amr531072285a.76.1770064839815; Mon, 02 Feb 2026
 12:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com> <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com>
In-Reply-To: <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 12:40:28 -0800
X-Gm-Features: AZwV_QjHzd04gvjhRn0I74SzHqaIKp0f3MahU-OOixIXf9Am-4ifCjdqXL9iUWg
Message-ID: <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ulf,

On Mon, Feb 2, 2026 at 4:32=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
> The above doesn't mention that omitting the _init/exit and functions
> also makes the module unloadable.
I can add that in the next version.

> I think this should be perfectly fine for these cases, assuming that
> we never want to unload the modules as they are pure library
> functions. That said, please clarify this in the commit message.
My understanding is that modules can be unloaded if one of the
following is true:
- They have neither init nor exit functions
- They have both, and the exit function returns zero
but that if a module has an init function but no exit function, it
cannot be unloaded.
Therefore, this change would result in the modules being able to be
unloaded as they are currently.
Feel free to correct me if I'm wrong.

Ethan
