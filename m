From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
Date: Wed, 1 Aug 2018 11:41:39 +0200
Message-ID: <CAPDyKFpdfVx4QqOEsBhOrTPp7iVo=qqFr7AFr-e2Sfqef+CtWQ@mail.gmail.com>
References: <20180712195937.GA36007@beast> <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
 <CAGXu5jJbS-P9X+6jPVkiVqDN1vF5ZFiwxRD0fHk+yYnhb9qKGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJbS-P9X+6jPVkiVqDN1vF5ZFiwxRD0fHk+yYnhb9qKGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 31 July 2018 at 22:27, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 16, 2018 at 3:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
>> On 12 July 2018 at 21:59, Kees Cook <keescook@chromium.org> wrote:
>>> Looks like the adjusted syntax wasn't fully build tested. This fixes
>>> failures with powerpc builds:
>>>
>>> drivers/mmc/host/mxcmmc.c: In function =E2=80=98mxcmci_swap_buffers=E2=
=80=99:
>>> drivers/mmc/host/mxcmmc.c:296:51: error: expected =E2=80=98)=E2=80=99 b=
efore =E2=80=98;=E2=80=99 token
>>>    void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>>>                                                    ^
>>> drivers/mmc/host/mxcmmc.c:299:1: error: expected =E2=80=98,=E2=80=99 or=
 =E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token
>>>  }
>>>  ^
>>>
>>> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Thanks, applied for fixes!
>
> I just checked again, and while I see this in linux-next, I would
> expect this to be in 4.18, since this fixes a 4.18-introduced build
> failure for some PPC configurations. Can this please be included in
> 4.18?

Yes it will, I was just about to create a PR for it.

However, I have deliberately slowed down the pace of sending fixes to
Linus, because of trying to achieve a somewhat better test coverage.

If you want to test the latest 4.18 rcs with pending fixes, we have
the pending-fixes branch in Stephen's next tree.

[...]

Kind regards
Uffe
