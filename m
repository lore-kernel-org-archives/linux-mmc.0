Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C312EBBB5
	for <linux-mmc@vger.kernel.org>; Fri, 26 Sep 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891566; cv=none; b=XXByP6wwzAbVGgV7xm0p+bydWvSBlLvUVzO5MiC/lgtsnI9S1VRiEGBC2ug2IZAKX84WX+nWFUKEfqPq+RnXhC7Xkr7Hy0PTt/cMD2bj1FJOOrG4LiW9qsv8NOWayJ+2S/YtC+npgHR7rqG2GUwcUDUbo0LdfAXB2OIM9ToWM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891566; c=relaxed/simple;
	bh=02Yf5iZvdujxZVH+jqS3dyafWvnK7oPlWCy6GNcQ3hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGL3upfWyZ1AmeTu+q/of9svYo5T1rWTB64VgAIf00qFvy5c0BSkNgGZ0lCcMVMPZDIYpoFrhnZwOg13ZIkwYCx6LHHJIJd3q2Y6kf8kWVn826/IxPjVdwCnXzKxX3lgnyWh5v5c4YATOIvyyZb7MuyhQpufYmX5C5d3Ath8sHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BvxO8qAy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvxO8qAy"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-723ad237d1eso24212867b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Sep 2025 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758891564; x=1759496364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U62ax70uCqInVF9dbB1TLBloFnLqPoTXpl/uaUUkTyY=;
        b=BvxO8qAyaQajR+Bk3TSsnuCZl4zcTwYdg5Z8RJiJAeGbjrIeXcySJkSDXmoX8nIsaa
         RgomBODuxnBCPS3DJuA0l5gAa6KuM2YbN8pJKM8yJXC5NnNYSWXl+gDKbAKat0Tjz3bB
         kzK9erXGEo99CJmuESUbDRt1FRyBuYChO9k4uCVWHYUO3SXR3pqVHs7r8dokcdOuygSD
         GZ8L/vbpNFPm4YbLx2jN6JMpmm3I1mLgV/PEV0jxYk3w9Eo8y1hhjVU8L7WexTWCvURb
         Wq6XXXkwu9UbFaY+ltGLSt2CZo9tGq+bYbdKnO4iWsxT+x1hjpOGaJ2j5obkVuLL76Q+
         SkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891564; x=1759496364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U62ax70uCqInVF9dbB1TLBloFnLqPoTXpl/uaUUkTyY=;
        b=kTEpQD6jc1Rrw+jBhC4qtb7vG1dab5ArzvFMZ08hyVjXAUt6wRljRdFgxOPI27o+XO
         uKcyX/GHfYg2p9RXneF3+FyAJt8mb2Q70d/1jflOTczT4NNNpAITkbaMsIZzkc0bGxgZ
         caRMmr07vGl1kKikCmXNX9JJzmkty7vjfUGwCEF/vh4Sytg8T+Lg5eEuH/cg9VN6om7k
         XFQ4vxyDJm83f6PCv4sKf84aKz+/U0WpurQ5Ck2FLjxrXlybiby57barjNgpU9A19SY1
         YYocJDWvG78nb82tIGdton8sZbewoFVGrsyjXhhNvIvXAmmWJKUc4Ade7tGfLw3+bDvy
         vn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0zRgwTxVXRyPmaHZSIoJgNrohfKXGNviySShRHTEZaIq6gR+7zuC0h4moDWUtrV2fy93xULNboIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KIHPZbuWh31TbzJxaEzjBTumiSAov0fM9C6aJR1tzEXK2GO2
	78DUyu6XbLISXl6gQ5MDywpoLlwUvzxAU+nG+Gqp5lXaQL3+GCQrsYRzacqpPLMR9vfIbfxoNzU
	51M7ot8UQowA3msKjErKilphLU/DrXRlKiUIWCfpYBwXCubtJXKAC
X-Gm-Gg: ASbGncsIEtu2U88oPbY+16+tYex4J/99gJ4Ln2vibp8yLiGFkba1oOGrzA+L9oX8EI4
	TntYjBYwCj4ctjYmgwv50D5PQIw68pu+RoaVUcZggz1jN9f4p3jFT5BP+BFiC4v40rdeyPkwqJ9
	3NO+qiJ1y9oTQS7mNQ53vGVtO3AsS3+C7SBUTIqXyM3nHfdkEste+X3fLdt4UcDGLKKVLa/B4hy
	UfrUl4FM7pzLTnE6Jp+wKuTmBs=
X-Google-Smtp-Source: AGHT+IEifAFv5a29zDdEPDUIOM2OjVksRuMIY/eSpVY+ut3BzhbdYH7ms3/JOahQoZ7Gu6d4Q7GU29r5HlKeqYxKNkw=
X-Received: by 2002:a53:d01a:0:b0:635:4ecf:bdc7 with SMTP id
 956f58d0204a3-6361a892f9bmr5524554d50.41.1758891563753; Fri, 26 Sep 2025
 05:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
 <fc592d6d-5f6b-4afd-9e4a-e77987a88a56@siemens.com> <CAPDyKForTu9xdtPbYZ-DyLPGrnx7c6aXE8E1qoz9U_yZzAhRWQ@mail.gmail.com>
 <PH7PR16MB6196BB890A60C66FD6B300E5E51FA@PH7PR16MB6196.namprd16.prod.outlook.com>
 <edad7f10-887b-4603-9bf4-d22629d11cd7@siemens.com>
In-Reply-To: <edad7f10-887b-4603-9bf4-d22629d11cd7@siemens.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Sep 2025 14:58:47 +0200
X-Gm-Features: AS18NWBdWwrR_XCk50sCIsAgqfTjUpTDDYzrCh5-c53mG04hgcNkEpo0i9VqqDU
Message-ID: <CAPDyKFpPZH16XhtR9reuc=17osYa+GChG926eHyUQkLbWD6=9Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Correctly handle write counter overflow status
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Avri Altman <Avri.Altman@sandisk.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 17:54, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 25.09.25 17:43, Avri Altman wrote:
> >>>> +#define RPMB_OP_RESULT_MASK          0x7f
> >>>> +
> >>>>  struct rpmb_frame {
> >>>>       u_int8_t  stuff[196];           /* Bytes 511 - 316 */
> >>>>       u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
> >>>> @@ -2295,7 +2297,7 @@ int do_rpmb_write_key(int nargs, char **argv)
> >>>>       }
> >>>>
> >>>>       /* Check RPMB response */
> >>>> -     if (frame_out.result != 0) {
> >>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >>>>               printf("RPMB operation failed, retcode 0x%04x\n",
> >>>>                          be16toh(frame_out.result));
> >>>>               exit(1);
> >>>> @@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd,
> >> unsigned int *cnt)
> >>>>       }
> >>>>
> >>>>       /* Check RPMB response */
> >>>> -     if (frame_out.result != 0) {
> >>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >>>>               *cnt = 0;
> >>>>               return be16toh(frame_out.result);
> >>>>       }
> >>>> @@ -2442,7 +2444,8 @@ int do_rpmb_read_block(int nargs, char **argv)
> >>>>       }
> >>>>
> >>>>       /* Check RPMB response */
> >>>> -     if (frame_out_p[blocks_cnt - 1].result != 0) {
> >>>> +     if ((frame_out_p[blocks_cnt - 1].result &
> >>>> +          htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >>>>               printf("RPMB operation failed, retcode 0x%04x\n",
> >>>>                          be16toh(frame_out_p[blocks_cnt - 1].result));
> >>>>               exit(1);
> >>>> @@ -2573,7 +2576,7 @@ static int rpmb_auth_write(int nargs, char
> >> **argv, uint16_t addr,
> >>>>       }
> >>>>
> >>>>       /* Check RPMB response */
> >>>> -     if (frame_out.result != 0) {
> >>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >>>>               printf("RPMB operation failed, retcode 0x%04x\n",
> >>>>                      be16toh(frame_out.result));
> >>>>       }
> >>>> @@ -2621,7 +2624,7 @@ static int rpmb_auth_read(int nargs, char **argv)
> >>>>       }
> >>>>
> >>>>       /* Check RPMB response */
> >>>> -     if (frame_out.result != 0) {
> >>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >>>>               printf("RPMB operation failed, retcode 0x%04x\n",
> >> be16toh(frame_out.result));
> >>>>               goto out;
> >>>>       }
> >>>> @@ -2783,7 +2786,7 @@ int do_rpmb_write_block(int nargs, char **argv)
> >>>>       }
> >>>>
> >>>>       /* Check RPMB response */
> >>>> -     if (frame_out.result != 0) {
> >>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >>>>               printf("RPMB operation failed, retcode 0x%04x\n",
> >>>>                          be16toh(frame_out.result));
> >>>>               exit(1);
> >>>
> >>> Any news on this one?
> >>
> >> I was waiting for you and Avri to reach a conclusion. Avri, is this good to go or
> >> do you expect Jan to send a new version?
> > My point was that, given the Byte order of the RPMB data frame is MSB first,
> > we only need to check the lower 3 bits, and the expression above doesn't do that IMHO.
>
> As I wrote: The spec says that all 7 bits define the result value - it's
> safer to include them all in the evaluation.
>
> > Hence, I couldn't add my reviewed-by tag.
> > If, however, someone else finds this code useful I have no objection to accept it.
> > The patch in its entirety is fixing a valid issue.  Therefore:
> >
> > Acked-by: Avri Altman <avri.altman@sandisk.com>
> >
>
> Thanks!
>
> Jan

Applied for mmc-utils master, thanks!

Kind regards
Uffe
