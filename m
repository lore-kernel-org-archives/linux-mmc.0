Received: from list.virtualsheetmusic.com (list.virtualsheetmusic.com [170.249.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C11772F
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.249.201.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042634; cv=none; b=Qwx21uFq6YyuVDTyAvho8slXwhQMEpiAoR6wPhLu9RAQ0p9zuElgeKYYjq/ZbUmiSyRiYbl+n2wJzc0MBs6ClVC+nsm4/bus6aNfX7OzGmYvtoIrQv4H4iuWntOdjm1VLgGxk96pZidthQIbIwVCSZHRVyUkSW+G/mm9NStD0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042634; c=relaxed/simple;
	bh=MrJjwXhzZ0wKnODmvPZPQW35erhvAg9vN6XO8Nk9sHI=;
	h=To:Subject:MIME-Version:From:Content-Type:Message-Id:Date; b=f/rTPMOIMp2XV963kTRYU3pFdEPzFweYf6HiBMCga1FOxBZl81KVRUFTTUDxrreefgxVvuJw4GT6ZeIgLCRAKWCz7eGA8mmk+VIGTee804LPO2INmRSiO69qODkFiX9EvmXFD6kKtnzP9xrZalDCYM7fBUicDBdtiC2iEsRyryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com; spf=pass smtp.mailfrom=musicianspage.com; dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b=C+7/oE11; arc=none smtp.client-ip=170.249.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=musicianspage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=list.virtualsheetmusic.com header.i=@list.virtualsheetmusic.com header.b="C+7/oE11"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=list.virtualsheetmusic.com; s=y; h=Date:Message-Id:
	Content-Transfer-Encoding:Content-Type:Reply-To:From:MIME-Version:Subject:To:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=vxNbSN+zA6A48+v/QTWgTjZTwzKJdueqB9yxpiuIi6k=; b=C+7/oE112Hvx
	FMXI527By9aJxD88VjjqdL4yLZ+VUUlFJAQlVdHGWPRCgZCu20vbw5NzO5kl8nFyu3H5dJMRnyJba
	QkjO3Zdw2k6776RN1qyOHq9biC4yea/9Xa//z8xJv5O/q84tz8GU5FEylwWTTc9sC70o3ZCnPrVs6
	ktaVc=;
Received: from root by list.virtualsheetmusic.com with local (Exim 4.92)
	(envelope-from <no-reply@musicianspage.com>)
	id 1rzwmm-0004VZ-4x
	for linux-mmc@vger.kernel.org; Thu, 25 Apr 2024 03:57:04 -0700
To: linux-mmc@vger.kernel.org
Subject: Music News and Site Updates (April 25, 2024)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Musicians Page <newsletter@musicianspage.com>
Reply-To: Musicians Page <newsletter@musicianspage.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1rzwmm-0004VZ-4x@list.virtualsheetmusic.com>
Date: Thu, 25 Apr 2024 03:57:04 -0700

Dear Musician and Music Lover,

Here is the Newsletter from Musicians Page website:

http://www.musicianspage.com

As you have requested. Read on...

(If you are no longer interested in subscribing to this newsletter, you can=
 unsubscribe by clicking the link at the bottom of this newsletter. Thanks!=
)




---------------------------------------------------------------------------=
-

If you are not yet registered as a Musician or Band/Ensemble, be sure to si=
gn-up from the following page (it's free!):

https://www.musicianspage.com/signup.php?email=3Dlinux-mmc@vger.kernel.org

---------------------------------------------------------------------------=
-




Consider to join with a Standard or Pro Membership
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Either if you are a Musician or a Music Employer, have a look at our Member=
ship Plans and sign up for the one that best fits your needs:


http://www.musicianspage.com/membership.html


A Standard or Pro Membership gives you the ability to upload unlimited audi=
o, video, and sheet music files to your profile; as well as a more complete=
 resume (or service/company info if you are an employer) and a creative pag=
e with media content. If you are a musician, you will also have the chance =
to get featured on the new Musicians Page radio:

http://www.musicianspage.com/music/radio/


Musicians Page gives you a professional space on the web to showcase your t=
alent to potential employers or, for employers, to have a professional and =
targeted space on the web where to showcase your products or services to po=
tential prospects. Musicians Page gives you the chance to differentiate you=
rself from other musicians or the competition who only use amateur channels=
 such as MySpace, FaceBook, YouTube, or other free sites.

Also, do you know that your profile on Musicians Page is Google optimized?

This means that employers, other musicians or prospects can easily find you=
 via Google. Our system automatically optimizes every Musician's profile to=
 appear at the top of Google results for relevant keywords. Just another re=
ason to take full advantage of all that the Standard and Pro Memberships ha=
ve to offer, and not rely solely on free social networks that won't optimiz=
e your profile for others to see at the top of the list!

With a Standard or Pro Membership, you'll also be able to find and apply fo=
r external jobs Musicians Page finds for you on the web (if you are a music=
ian) and, with a Pro Membership, be notified via email as soon as a new ext=
ernal jobs, matching your profile, are found. Or, if you are an employer, b=
e featured prominently on any webpage of our site to over 2,000 unique user=
s daily.

Musicians Page is a network for professional musicians and music employers,=
 built and planned to grow based on professional musicians' and music emplo=
yers' needs. Don't miss the opportunity to jump on the band wagon from the =
beginning.

Membership fees are likely to be increased in the coming weeks, so join Mus=
icians Page today and start networking the right way!

https://www.musicianspage.com/signup.php




Are you looking for musicians, a song writer, a lyricist, a composer?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If so, please post your music job or project on Musicians Page.
To post a job/project is completely free and takes 5 minutes:

http://www.musicianspage.com/login/panel.php?yourjobs=3D1&postnew=3D1


REMEMBER: you can post a job even for a FREE project you need musicians for=
!




Latest Posted Jobs on Musicians Page
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hammond B3 Organ Player
http://www.musicianspage.com/jobs/7729/

Guitarist Wanted
http://www.musicianspage.com/jobs/7728/

New Woodwind orchestra
http://www.musicianspage.com/jobs/7727/

Female singer,rapper to Collab Remotely
http://www.musicianspage.com/jobs/7724/

Music Duo
http://www.musicianspage.com/jobs/7721/

Guitarist needed in Mexico for rock and roll music
http://www.musicianspage.com/jobs/7720/

STEEL PAN SOLOIST FOR CRUISE SHIPS URGENT
http://www.musicianspage.com/jobs/7715/

Lauren Daigle Cover Singer
http://www.musicianspage.com/jobs/7716/

Violinist Wanted
http://www.musicianspage.com/jobs/7717/

Power rock/pop trio for cruises
http://www.musicianspage.com/jobs/7713/


More jobs:
http://www.musicianspage.com/jobs/




Latest External Jobs or Opportunities (found on the web)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Lead Singer needed
http://www.musicianspage.com/extjobs/1268977/

Seeking an original, innovative, experienced Lead Singer.
http://www.musicianspage.com/extjobs/1268976/

Looking for a violinist, 1hr, 8/18/24
http://www.musicianspage.com/extjobs/1268975/

Keyboardist wanted for UFO tribute
http://www.musicianspage.com/extjobs/1268974/

Lead guitarist wanted for open mic gig
http://www.musicianspage.com/extjobs/1268973/

Seeking  lead Guitar player , For 80's hard Rock - Original's
http://www.musicianspage.com/extjobs/1268972/

Drummer needed for 80's cover band
http://www.musicianspage.com/extjobs/1268971/

Alt/indie/shoegaze band looking for drummer/bass
http://www.musicianspage.com/extjobs/1268970/

Guitarist looking to join or make band (rock, pop punk, alt, etc.)
http://www.musicianspage.com/extjobs/1268969/

Chill jam session; looking for guitar and/or vocals on 4/25
http://www.musicianspage.com/extjobs/1268968/


More jobs:
http://www.musicianspage.com/jobs/




Latest Forum Topics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

New Release - by KonstantinDobriak
posted on the General Forum forum
http://www.musicianspage.com/forums/general/general/9051/


Red Hot Chili Peppers-Under the Bridge (Guitar and Piano) - by Luis Afonso =
Andre
posted on the Rock Music forum
http://www.musicianspage.com/forums/music/rockmusic/9049/


Joe Hisaishi-You&#039;re in Love(Howl&#039;s Moving Castle OST), Piano - by=
 Luis Afonso Andre
posted on the Soundtrack/Film Music forum
http://www.musicianspage.com/forums/music/soundtrack/9047/


More forum topics:
http://www.musicianspage.com/forums/




Latest Uploaded Audio Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

5/4 RE DE LAMIREMI by LIONHELL VONTICH (added by Fontich Lionel)
Genre: Rock
http://www.musicianspage.com/musicians/54008/audiofile/22981/


While There&#039;s Still time by Jeremiah Minahan (added by Jeremiah Minaha=
n)
Genre: Christian
http://www.musicianspage.com/musicians/54000/audiofile/22980/


You Are The Blessed by Jeremiah Minahan (added by Jeremiah Minahan)
Genre: Christian
http://www.musicianspage.com/musicians/54000/audiofile/22979/


More audio files:
http://www.musicianspage.com/audio/


We are waiting for your comments and if you have any, please upload your
own audio files from the page below (you must register first):

https://www.musicianspage.com/login/panel.php?addaudiofiles=3D1




Latest Uploaded Video Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Lucas e Karina: Projeto Primavera #LIVE | Parte 2 - Flashback by Lucas e Ka=
rina (added by Lucas e Karina)
Genre: Pop
http://www.musicianspage.com/musicians/44677/videofile/21232/


Lucas e Karina by Lucas e Karina (added by Lucas e Karina)
Genre: Pop
http://www.musicianspage.com/musicians/44677/videofile/21231/


Limehouse Blues by mikewarmblood (added by Thomas Jacques)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/53997/videofile/21230/


More video files:
http://www.musicianspage.com/video/


We are waiting for your comments and if you have any, please upload your
own video files from the page below (you must register first):

https://www.musicianspage.com/login/panel.php?addvideofiles=3D1




Latest Uploaded Sheet Music Files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rodrigo. Concierto de Aranjuez. Parts. by Joaquin Rodrigo (added by Grechan=
ivsky)
Genre: Other...
http://www.musicianspage.com/musicians/9640/sheetmusic/3287/


Along the Danube by Joe Sinha Semple (added by Joe Sinha Semple)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/53961/sheetmusic/3286/


Respighi. Vetrate di Chiesa. Parts by Ottorino Respighi (added by Grechaniv=
sky)
Genre: Classical/Contemporary
http://www.musicianspage.com/musicians/9640/sheetmusic/3282/


More sheet music files:
http://www.musicianspage.com/sheetmusic/


We are waiting for your comments and if you have any, please upload your
own sheet music files from the page below (you must register first):

https://www.musicianspage.com/login/panel.php?addsheetmusic=3D1




Earn money with your website, FaceBook, YouTube or MySpace
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you own a website or simply an account on FaceBook, YouTube, MySpace or =
Twitter, be sure to check out the Virtual Sheet Music's Affiliate Program w=
hich entitles you to earn 30% commission on any referred sale.

It is completely free to join:

https://affiliates.virtualsheetmusic.com/


and once you have an account, start referring users using a special code to=
 put on your website or social account (FaceBook, Twitter, etc).

For any further questions, please reply to this email, we will be glad to h=
elp you step by step.




Join us on the major Social Networks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Stay updated with our latest news on:

1. on FaceBook:
http://www.facebook.com/MusiciansPage

2. on Twitter:
http://twitter.com/MusiciansPage




---------------------------------------------------------------------------=
-----

FEATURE YOURSELF ON MUSICIANS PAGE:
=20
If you have an upcoming concert, CD release, special Event, or just want to=
 promote yourself and your activity, remember you can feature yourself in f=
ront of thousands of musicians, music lovers, and music employers (includin=
g music agents, artist management companies, etc.) by exclusively putting y=
our picture and name on every page of Musicians Page, starting at just $10 =
(that's right, just 10 bucks!):
=20
https://www.musicianspage.com/login/panel.php?featureyourself=3D1
=20
Your ad will be displayed exclusively for the duration of your campaign, gi=
ving you maximum exposure to the Musicians Page community. Musicians Page i=
s visited by thousands of musicians and people working in the music busines=
s every day, so consider putting yourself in front of this specialized audi=
ence.

This is your chance to make new contacts and seize exciting opportunities i=
n minutes! Don't miss this opportunity now!

---------------------------------------------------------------------------=
-----




Please feel free to pass this Newsletter along to friends and other musicia=
ns who might find this content valuable in the same way you do, and be sure=
 to send us your ideas and thoughts by either replying to this email or by =
posting your comments and feedback on the dedicated forum below:

http://www.musicianspage.com/forums/general/feedback/

Thank you!

All the best,
Fabrizio Ferrari, CEO
Musicians Page
http://www.musicianspage.com
Virtual Sheet Music Inc.
http://www.virtualsheetmusic.com
29911 Niguel Road, #6992
Laguna Niguel, CA 92677 (USA)
Fax: +1 800 717 1876 or +1 973 273 2171
----------------------------------------------
This message was sent from Musicians Page
http://www.musicianspage.com
To unsubscribe, please go to:
http://www.musicianspage.com/unsubscribe.php?email=3Dlinux-mmc@vger.kernel=
=2Eorg
